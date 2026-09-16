SELECT
  DATE(purchase_datetime) AS dt,
  SUM(total_price) AS total_revenue,
  SUM(quantity) AS cnt,
  AVG(SUM(total_price)) OVER (
        ORDER BY DATE(purchase_datetime)
        ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING
    ) AS revenue_ma_5,
  AVG(SUM(quantity)) OVER (
        ORDER BY DATE(purchase_datetime)
        ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING
    ) AS cnt_ma_5
FROM sales
WHERE true
  [[AND {{product_id}}]]
  [[AND {{purchase_datetime}}]]
  [[AND {{gender}}]]
  [[AND {{client_id}}]]
GROUP BY dt
ORDER BY dt;