SELECT
    DATE(purchase_datetime) AS dt,
    SUM(total_price) AS revenue,
    SUM(quantity) AS quantity_sold
FROM sales
WHERE true
  [[AND {{product_id}}]]
  [[AND {{purchase_datetime}}]]
  [[AND {{gender}}]]
  [[AND {{client_id}}]]
GROUP BY dt
ORDER BY dt;