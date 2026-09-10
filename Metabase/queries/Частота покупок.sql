WITH order_like AS (
    SELECT
      client_id,
      purchase_datetime AS dt,
      SUM(total_price) AS revenue
    FROM sales
    WHERE true
	  [[AND {{product_id}}]]
	  [[AND {{purchase_datetime}}]]
	  [[AND {{gender}}]]
    GROUP BY client_id, dt
  ),
  client_orders AS (
    SELECT
      client_id,
      COUNT(*) AS purchase_events
    FROM order_like
    GROUP BY client_id
  )
SELECT
  CASE
    WHEN purchase_events = 1 THEN '1 покупка'
    WHEN purchase_events = 2 THEN '2 покупки'
    ELSE '3+ покупок'
  END AS purchase,
  COUNT(*) AS clients_count
FROM client_orders
GROUP BY purchase
ORDER BY purchase;