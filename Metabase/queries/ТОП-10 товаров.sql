SELECT
  product_id,
  SUM(total_price) AS revenue,
  SUM(quantity) AS quantity_sold,
  COUNT(DISTINCT client_id) AS unique_clients,
  SUM(total_price) / NULLIF(SUM(quantity), 0) AS avg_price
FROM sales
WHERE true
  [[AND {{product_id}}]]
  [[AND {{purchase_datetime}}]]
  [[AND {{gender}}]]
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 10;