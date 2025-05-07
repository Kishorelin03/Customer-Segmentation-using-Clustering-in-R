
<body style="font-family: Arial, sans-serif; line-height: 1.6; padding: 2rem; max-width: 900px; margin: auto;">

  <h1>📊 Customer Segmentation of Social Media Users using Clustering in R</h1>

  <p>This project analyzes a synthetic dataset of 10,000 global social media users across 13 major platforms (e.g., Facebook, YouTube, TikTok) using unsupervised machine learning techniques. The goal is to segment users based on behavior such as time spent, platform usage, and verification status to support business intelligence and personalized strategy development.</p>

  <h2>🔍 Problem Statement</h2>
  <p>Businesses, banks, and marketers need to segment audiences effectively for targeted messaging and growth optimization. This project clusters users into behavioral segments based on simulated social media activity patterns.</p>

  <h2>📦 Dataset Overview</h2>
  <ul>
    <li><strong>Fields:</strong> Platform, Owner, Primary Usage, Country</li>
    <li><strong>Metrics:</strong> Daily Time Spent (min), Verified Account, Date Joined</li>
    <li><strong>Note:</strong> Synthetic dataset to protect privacy</li>
  </ul>

  <h2>💡 Project Goals</h2>
  <ul>
    <li>Preprocess and clean social media user data in R</li>
    <li>Apply K-means clustering for segmentation</li>
    <li>Visualize clusters using PCA</li>
    <li>Create an interactive Shiny dashboard</li>
    <li>Generate an HTML summary report with RMarkdown</li>
  </ul>

  <h2>📁 Project Structure</h2>
  <pre><code>CustomerSegmentationR/
├── data/
├── scripts/
├── dashboard/
├── output/
├── report.Rmd
└── README.md</code></pre>

  <h2>⚙️ Requirements & Installation</h2>
  <p><strong>Prerequisites:</strong> R, RStudio</p>
  <p><strong>Install dependencies:</strong></p>
  <pre><code>install.packages(c(
  "tidyverse", "caret", "cluster", "factoextra",
  "shinydashboard", "ggplot2", "lubridate"
))</code></pre>

  <h2>🚀 How to Run</h2>
  <ul>
    <li><strong>Step 1:</strong> Run <code>scripts/01_load_clean_data.R</code></li>
    <li><strong>Stestrong> Run <code>scripts/02_clustering_analysis.R</code></li>
    <li><strong>Step 3:</strong> Run <code>scripts/03_visualizations.R</code></li>
  </ul>

  <h2>🖥 Shiny Dashboard</h2>
  <p>Open <code>dashboard/app.R</code> and click <strong>Run App</strong> in RStudio. Filter and explore user clusters visually.</p>

  <h2>🧠 Key Insights</h2>
  <ul>
    <li>Cluster 1: Highly engaged, mostly verified — influencer-type users</li>
    <li>Cluster 4: Low time, mostly unverified — casual or new users</li>
    <li>Country and platform preferences vary greatly across clusters</li>
  </ul>

  <h2>🛠 Technologies Used</h2>
  <ul>
    <li><strong>Language:</strong> R</li>
    <li><strong>IDE:</strong> RStudio</li>
    <li><strong>Libraries:</strong> tidyverse, caret, factoextra, ggplot2, shinydashboard</li>
  </ul>
