SELECT
  DATE(purchase_datetime) AS dt,
  SUM(total_price) / NULLIF(SUM(quantity), 0) AS avg_sell_price
FROM sales
WHERE true
  [[AND {{product_id}}]]
  [[AND {{purchase_datetime}}]]
  [[AND {{gender}}]]
  [[AND {{client_id}}]]
GROUP BY DATE(purchase_datetime)
ORDER BY dt;