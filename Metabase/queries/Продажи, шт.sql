SELECT
	SUM(quantity) AS total_units_sold
FROM sales
WHERE true
	[[AND {{product_id}}]]
	[[AND {{purchese_datetime}}]]
	[[AND {{gender}}]]
	[[AND {{client_id}}]];