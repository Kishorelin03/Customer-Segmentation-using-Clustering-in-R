library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(factoextra)
library(caret)

# Load clustered data
clustered_data <- readRDS("~/Downloads/co-op/Projects/CustomerSegmentationR/data/clustered_users.rds")

# Pre-create dummy encoder for consistent structure
full_dummy <- dummyVars(" ~ Platform + Primary.Usage + Country", data = clustered_data)

# UI
ui <- dashboardPage(
  dashboardHeader(title = "Social Media User Segmentation"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "main", icon = icon("dashboard")),
      selectInput("platform", "Select Platform:", choices = c("All", unique(clustered_data$Platform))),
      selectInput("country", "Select Country:", choices = c("All", unique(clustered_data$Country))),
      selectInput("cluster", "Select Cluster:", choices = c("All", sort(unique(clustered_data$Cluster))))
    )
  ),
  
  dashboardBody(
    fluidRow(
      valueBoxOutput("userBox"),
      valueBoxOutput("avgTimeBox"),
      valueBoxOutput("verifiedBox")
    ),
    fluidRow(
      box(title = "Summary Table", status = "primary", solidHeader = TRUE, width = 6,
          tableOutput("summaryStats")),
      box(title = "PCA Cluster Plot", status = "warning", solidHeader = TRUE, width = 6,
          plotOutput("pcaPlot", height = "400px"))
    )
  )
)

# Server
server <- function(input, output) {
  
  filtered_data <- reactive({
    data <- clustered_data
    if (input$platform != "All") data <- data[data$Platform == input$platform, ]
    if (input$country != "All") data <- data[data$Country == input$country, ]
    if (input$cluster != "All") data <- data[data$Cluster == input$cluster, ]
    data
  })
  
  output$userBox <- renderValueBox({
    valueBox(nrow(filtered_data()), "Users", icon = icon("users"), color = "blue")
  })
  
  output$avgTimeBox <- renderValueBox({
    valueBox(round(mean(filtered_data()$Daily.Time.Spent..min.), 2), "Avg Time (min)", icon = icon("clock"), color = "green")
  })
  
  output$verifiedBox <- renderValueBox({
    rate <- round(mean(filtered_data()$Verified) * 100, 2)
    valueBox(paste0(rate, "%"), "Verified Users", icon = icon("check-circle"), color = "purple")
  })
  
  output$summaryStats <- renderTable({
    req(nrow(filtered_data()) > 0)
    filtered_data() %>%
      group_by(Cluster) %>%
      summarise(
        Users = n(),
        AvgTimeSpent = round(mean(Daily.Time.Spent..min.), 2),
        VerifiedRate = round(mean(Verified), 2)
      )
  })
  
  output$pcaPlot <- renderPlot({
    data <- filtered_data()
    
    # Safe checks
    validate(need(nrow(data) >= 2, message = NULL))
    
    dummy_data <- tryCatch({
      data.frame(predict(full_dummy, newdata = data))
    }, error = function(e) return(NULL))
    
    validate(need(!is.null(dummy_data), message = NULL))
    
    features <- cbind(dummy_data,
                      TimeSpent = data$TimeSpent_Scaled,
                      Verified = data$Verified)
    
    features_filtered <- features[, apply(features, 2, var) != 0]
    validate(need(ncol(features_filtered) >= 2, message = NULL))
    
    pca <- prcomp(features_filtered, scale. = TRUE)
    
    fviz_pca_ind(pca,
                 geom.ind = "point",
                 col.ind = data$Cluster,
                 palette = "jco",
                 addEllipses = TRUE,
                 legend.title = "Cluster")
  })
}

# Run app
shinyApp(ui = ui, server = server)
