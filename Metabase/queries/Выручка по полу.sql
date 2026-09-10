SELECT
  gender,
  SUM(total_price) AS revenue
FROM
  sales
where true
	[[AND {{product_id}}]]
	[[AND {{purchase_datetime}}]]
GROUP BY gender
