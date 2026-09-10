SELECT
    SUM(total_price)::numeric / NULLIF(COUNT(DISTINCT client_id), 0)
FROM sales
WHERE true
  [[AND {{purchase_datetime}}]]
  [[AND {{product_id}}]]
  [[AND {{gender}}]];