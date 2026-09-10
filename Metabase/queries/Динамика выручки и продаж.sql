SELECT
  DATE(purchase_datetime) AS dt,
  SUM(total_price) AS total_revenue,
  sum(quantity) AS cnt
FROM sales
WHERE true
  [[AND {{product_id}}]]
  [[AND {{purchase_datetime}}]]
  [[AND {{gender}}]]
  [[AND {{client_id}}]]
GROUP BY dt
ORDER BY dt;