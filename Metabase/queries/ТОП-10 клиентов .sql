SELECT
  client_id,
  SUM(total_price) AS revenue,
  SUM(quantity) AS quantity_sold,
  COUNT(DISTINCT product_id) AS unique_products,
  AVG(total_price) AS avg_check
FROM sales
WHERE true
  [[AND {{product_id}}]]
  [[AND {{purchase_datetime}}]]
  [[AND {{gender}}]]
  [[AND {{client_id}}]]
GROUP BY client_id
ORDER BY revenue DESC
LIMIT 10;