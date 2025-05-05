# AIRBNB_Bookings_Analysis_Using_Window_Functions_in_SQL

## Overview
This project involves a comprehensive analysis of AIRBNB's data using Window Functions in SQL. The goal is to extract valuable insights and answer some questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives
Analyze Average Prices using the OVER() and PARTITION_BY() function.

Identify different ways of ranking the output using RANK() and DENSE_RANK() functions.

List the row numbers in DESC order using the ROW_NUMBER() function.

Explore and categorize LAG() and LEAD() function and it's capability to find moving average.

## Dataset
The data for this project is sourced from the Kaggle dataset:

Kaggle Link for the Dataset: [AIRBNB Dataset ](https://www.kaggle.com/datasets/dgomonov/new-york-city-airbnb-open-data)

### 1. Get the average price of the data

```
SELECT
	booking_id,
	listing_name,
	neighbourhood_group,
	price,
	AVG(price) OVER() as avg_price
FROM bookings;
```
