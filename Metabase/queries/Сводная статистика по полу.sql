SELECT
    gender,
    SUM(total_price) AS total_revenue,
    COUNT(DISTINCT client_id) AS unique_clients,
    SUM(quantity) AS total_quantity,
    COUNT(*) AS total_transactions,
    ROUND(
        (
            SUM(total_price)
            / NULLIF(SUM(quantity), 0)
        )::numeric,
        2
    ) AS avg_sell_price,
    ROUND(
        (
            SUM(discount_per_item * quantity)
            / NULLIF(SUM(quantity), 0)
        )::numeric,
        2
    ) AS avg_discount_per_item
FROM sales
WHERE true
    [[AND {{product_id}}]]
    [[AND {{purchase_datetime}}]]
    [[AND {{gender}}]]
GROUP BY gender
ORDER BY total_revenue DESC;