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
### 2. Get the Average, minimum and maximum price with OVER()

```
SELECT
	booking_id,
	listing_name,
	neighbourhood_group,
	price,
	AVG(price) OVER() as avg_price,
	MIN(price) OVER() as min_price,
	MAX(price) OVER() as max_price
FROM bookings;
```

###  3. Get the Difference from Average price with OVER()

```
SELECT
	booking_id,
	listing_name,
	neighbourhood_group,
	price,
	ROUND(AVG(price) OVER(), 2),
	ROUND((price - AVG(price) OVER()), 2) AS diff_from_avg
FROM bookings;
```

###  4. Get the Percent of Average price with OVER()

```
SELECT
	booking_id,
	listing_name,
	neighbourhood_group,
	price,
	ROUND(AVG(price) OVER(), 2) AS avg_price,
	ROUND((price / AVG(price) OVER() * 100), 2) AS percent_of_avg_price
FROM bookings;
```

### 5. Get the Percent Difference from Average price

```
SELECT
	booking_id,
	listing_name,
	neighbourhood_group,
	price,
	ROUND(AVG(price) OVER(), 2) AS avg_price,
	ROUND((price / AVG(price) OVER() - 1) * 100, 2) AS percent_diff_from_avg_price
FROM bookings;
```

### 6. PARTITION BY neighbourhood group

```
SELECT  
	 booking_id,
	listing_name,
	neighbourhood_group,
	neighbourhood,
	price,
	AVG(price) OVER(PARTITION BY neighbourhood_group) AS avg_price_by_neigh_group
FROM bookings;
```

### 7. PARTITION BY neighbourhood group and LIMIT 3 for each neighborhood

```
SELECT * FROM 
	(SELECT booking_id,
	listing_name,
	neighbourhood_group,
	neighbourhood,
	price,
	AVG(price) OVER(PARTITION BY neighbourhood_group) AS avg_price_by_neigh_group,
	ROW_NUMBER() OVER(PARTITION BY neighbourhood_group) as popularity
FROM bookings) 
WHERE popularity <= 3;
```

### 8. PARTITION BY neighbourhood group and neighbourhood

```
SELECT
	booking_id,
	listing_name,
	neighbourhood_group,
	neighbourhood,
	price,
	AVG(price) OVER(PARTITION BY neighbourhood_group) AS avg_price_by_neigh_group,
	AVG(price) OVER(PARTITION BY neighbourhood_group, neighbourhood) AS avg_price_by_group_and_neigh
FROM bookings;
```

### 9. Neighbourhood group and neighbourhood group and neighbourhood delta

```
SELECT
	booking_id,
	listing_name,
	neighbourhood_group,
	neighbourhood,
	price,
	AVG(price) OVER(PARTITION BY neighbourhood_group) AS avg_price_by_neigh_group,
	AVG(price) OVER(PARTITION BY neighbourhood_group, neighbourhood) AS avg_price_by_group_and_neigh,
	ROUND(price - AVG(price) OVER(PARTITION BY neighbourhood_group), 2) AS neigh_group_delta,
	ROUND(price - AVG(price) OVER(PARTITION BY neighbourhood_group, neighbourhood), 2) AS group_and_neigh_delta
FROM bookings;
```

### 10. Get the overall price rank

```
SELECT
	booking_id,
	listing_name,
	neighbourhood_group,
	neighbourhood,
	price,
	ROW_NUMBER() OVER(ORDER BY price DESC) AS overall_price_rank
FROM bookings;
```

### 11. Get the neighbourhood price rank

```
SELECT
	booking_id,
	listing_name,
	neighbourhood_group,
	neighbourhood,
	price,
	ROW_NUMBER() OVER(ORDER BY price DESC) AS overall_price_rank,
	ROW_NUMBER() OVER(PARTITION BY neighbourhood_group ORDER BY price DESC) AS neigh_group_price_rank
FROM bookings;
```

### 12. Get the Top 3 for all neighbourhood

```
SELECT
	booking_id,
	listing_name,
	neighbourhood_group,
	neighbourhood,
	price,
	ROW_NUMBER() OVER(ORDER BY price DESC) AS overall_price_rank,
	ROW_NUMBER() OVER(PARTITION BY neighbourhood_group ORDER BY price DESC) AS neigh_group_price_rank,
	CASE
		WHEN ROW_NUMBER() OVER(PARTITION BY neighbourhood_group ORDER BY price DESC) <= 3 THEN 'Yes'
		ELSE 'No'
	END AS top3_flag
FROM bookings;
```


### 13. Get the rank using RANK()

```
SELECT
	booking_id,
	listing_name,
	neighbourhood_group,
	neighbourhood,
	price,
	ROW_NUMBER() OVER(ORDER BY price DESC) AS overall_price_rank,
	RANK() OVER(ORDER BY price DESC) AS overall_price_rank_with_rank,
	ROW_NUMBER() OVER(PARTITION BY neighbourhood_group ORDER BY price DESC) AS neigh_group_price_rank,
	RANK() OVER(PARTITION BY neighbourhood_group ORDER BY price DESC) AS neigh_group_price_rank_with_rank
FROM bookings;
```

### 14. Get the rank using DENSE_RANK()

```
SELECT
	booking_id,
	listing_name,
	neighbourhood_group,
	neighbourhood,
	price,
	ROW_NUMBER() OVER(ORDER BY price DESC) AS overall_price_rank,
	RANK() OVER(ORDER BY price DESC) AS overall_price_rank_with_rank,
	DENSE_RANK() OVER(ORDER BY price DESC) AS overall_price_rank_with_dense_rank
FROM bookings;
```

### 15. Get the LAG BY 1 period using LAG()

```
SELECT
	booking_id,
	listing_name,
	host_name,
	price,
	last_review,
	LAG(price) OVER(PARTITION BY host_name ORDER BY last_review)
FROM bookings;
```

### 16. Get the LAG BY 2 periods using LAG()

```
SELECT
	booking_id,
	listing_name,
	host_name,
	price,
	last_review,
	LAG(price, 2) OVER(PARTITION BY host_name ORDER BY last_review)
FROM bookings;
```

### 17. Get the LEAD by 1 period using LEAD()

```
SELECT
	booking_id,
	listing_name,
	host_name,
	price,
	last_review,
	LEAD(price) OVER(PARTITION BY host_name ORDER BY last_review)
FROM bookings;
```

### 18. Get the LEAD by 2 periods LEAD()

```
SELECT
	booking_id,
	listing_name,
	host_name,
	price,
	last_review,
	LEAD(price, 2) OVER(PARTITION BY host_name ORDER BY last_review)
FROM bookings;
```


### 19. Get the Top 3 with subquery to select only the 'Yes' values in the top3_flag column

```
SELECT * FROM (
	SELECT
		booking_id,
		listing_name,
		neighbourhood_group,
		neighbourhood,
		price,
		ROW_NUMBER() OVER(ORDER BY price DESC) AS overall_price_rank,
		ROW_NUMBER() OVER(PARTITION BY neighbourhood_group ORDER BY price DESC) AS neigh_group_price_rank,
		CASE
			WHEN ROW_NUMBER() OVER(PARTITION BY neighbourhood_group ORDER BY price DESC) <= 3 THEN 'Yes'
			ELSE 'No'
		END AS top3_flag
	FROM bookings
	) a
WHERE top3_flag = 'Yes'
```
