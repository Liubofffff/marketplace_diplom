SELECT
  client_id,
  SUM(total_price) AS revenue
FROM sales
WHERE true
  [[AND {{product_id}}]]
  [[AND {{purchase_datetime}}]]
  [[AND {{gender}}]]
  [[AND {{client_id}}]]
GROUP BY client_id
ORDER BY revenue DESC, client_id
LIMIT 3;