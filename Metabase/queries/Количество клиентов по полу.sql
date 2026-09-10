SELECT
  gender,
  COUNT(DISTINCT client_id) AS unique_clients,
  ROUND(COUNT(DISTINCT client_id) * 100.0 / SUM(COUNT(DISTINCT client_id)) OVER(), 2) AS client_share_percent
FROM sales
WHERE true
  [[AND {{product_id}}]]
  [[AND {{purchase_datetime}}]]
  [[AND {{gender}}]]
GROUP BY gender;