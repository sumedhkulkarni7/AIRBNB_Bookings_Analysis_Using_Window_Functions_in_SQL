CREATE TABLE bookings (
	booking_id INT PRIMARY KEY,
	listing_name VARCHAR,
	host_id INT,
	host_name VARCHAR(50),
	neighbourhood_group VARCHAR(30),
	neighbourhood VARCHAR(30),	
	latitude DECIMAL(11,8),
	longitude DECIMAL(11,8),
	room_type VARCHAR(30),
	price INT,
	minimum_nights INT,
	num_of_reviews INT,
	last_review DATE,
	reviews_per_month DECIMAL(4,2),
	calculated_host_listings_count INT,
	availability_365 INT
);