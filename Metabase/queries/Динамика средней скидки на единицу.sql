SELECT
    DATE(purchase_datetime) AS dt,
    SUM(discount_per_item * quantity)
        / NULLIF(SUM(quantity), 0) AS avg_discount_per_item
FROM sales
WHERE true
    [[AND {{product_id}}]]
    [[AND {{purchase_datetime}}]]
    [[AND {{gender}}]]
    [[AND {{client_id}}]]
GROUP BY dt
ORDER BY dt;