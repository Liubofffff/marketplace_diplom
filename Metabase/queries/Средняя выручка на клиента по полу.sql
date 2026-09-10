SELECT
    gender,
    SUM(total_price)::numeric
        / NULLIF(COUNT(DISTINCT client_id), 0) AS arpc
FROM sales
WHERE true
    [[AND {{product_id}}]]
    [[AND {{purchase_datetime}}]]
GROUP BY gender
ORDER BY arpc DESC;