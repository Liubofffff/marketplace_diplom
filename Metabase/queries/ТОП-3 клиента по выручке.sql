SELECT
  COUNT(DISTINCT client_id) AS unique_clients,
  SUM(total_price) AS revenue
FROM sales
WHERE true
  [[AND {{product_id}}]]
  [[AND {{purchase_datetime}}]]
  [[AND {{gender}}]]
  [[AND {{client_id}}]]
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 3;