# Data Cleaning and Exploratory Data Analysis (EDA) Project on Layoffs Data (2020 - March 2023)

## Table of Contents
1. [Introduction](#introduction)
2. [Data Sources](#data-sources)
3. [Project Structure](#project-structure)
4. [Prerequisites](#installation)
5. [Getting Started](#usage)
6. [Data Cleaning Process](#data-cleaning-process)
7. [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
8. [Results](#results)
9. [Contributing](#contributing)

## Introduction
This project focuses on the Data Cleaning and Exploratory Data Analysis (EDA) of layoff data between 2020 and March 2023. The aim is to clean the raw data, handle missing values, remove duplicates, and conduct an in-depth analysis to uncover trends and insights. MySQL has been used for data storage and processing.

## Data Sources
https://drive.google.com/file/d/1AQqiRsojo7aTLByWEx5lkxLzSE9Xxsci/view?usp=sharing

## Project Structure
The project is organized as follows:
.
├── data
│   └── layoffs_data.csv    # Raw data in CSV format
├── sql
│   ├── cleaning.sql        # SQL script for data cleaning
│   └── eda.sql             # SQL script for EDA
├── results
│   # Results of EDA
│   # Detailed insights from EDA
└── README.md               # Project readme file

## Prerequisites
Before runnuing the project , ensure you have the following dependencies installed:
1. MySQL Workbench
2. SQL Server

## Getting Started
1. Clone this repository to your local machine
2. run the queries

## Data Cleaning Process
The data cleaning process involves:

* Removing duplicates
* Handling missing values
* Standardizing date formats
* Ensuring data consistency across different fields
  
  Refer to Data cleaning SQL file for the steps to follow

## Exploratory Data Analysis (EDA)
The EDA process involves:

* Descriptive statistics
* Trend analysis over time
* Analysis by industry, company size, and region
* Visualization of key trends and patterns
  
  Refer EDA Layoffs SQL file the detailed steps of Data analysis

## Results
* By executing the queries, we could understand that companies like 'Butler Hospitality' , 'Deliv', 'Jump' and few other are the companies that has highest percentage(100%) of layoffs
* During the 3 years, Consumer, Retail, Finance, Transportation and Healthcare are the industries that has highest number of layoffs
* United states is the country that has a highest number of layoffs that rounding upto 256559 people
* And found that 2022 is the year, that has most number of layoffs
* Also found year wise top 5 companies that laid off more people

## Contributing
if you want to contribute to this project or suggest improvements, please create an issue or a pull request

  
