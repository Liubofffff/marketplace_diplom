WITH product_revenue AS (
    SELECT
        product_id,
        SUM(total_price) AS revenue,
        SUM(SUM(total_price)) OVER () AS total_revenue
    FROM sales
    WHERE true
        [[AND {{purchase_datetime}}]]
        [[AND {{gender}}]]
        [[AND {{client_id}}]]
    GROUP BY product_id
),
cumulative AS (
    SELECT
        product_id,
        revenue,
        total_revenue,
        SUM(revenue) OVER (
            ORDER BY revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_revenue
    FROM product_revenue
),
abc_classified AS (
    SELECT
        product_id,
        revenue,
        ROUND(
            (
                cumulative_revenue
                / NULLIF(total_revenue, 0)
                * 100
            )::numeric,
            2
        ) AS cumulative_percent
    FROM cumulative
),
abc_result AS (
    SELECT
        product_id,
        revenue,
        cumulative_percent,
        CASE
            WHEN cumulative_percent <= 80 THEN 'A'
            WHEN cumulative_percent <= 95 THEN 'B'
            ELSE 'C'
        END AS abc_category
    FROM abc_classified
)
SELECT
    product_id,
    revenue,
    cumulative_percent,
    abc_category
FROM abc_result
WHERE true
    [[AND abc_category = {{abc_category}}]]
ORDER BY cumulative_percent;