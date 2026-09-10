SELECT SUM(total_price) AS revenue
FROM sales
WHERE true
	 [[AND {{product_id}}]]
     [[AND {{purchase_datetime}}]]
	 [[AND {{gender}}]]
	 [[AND{{client_id}}]]