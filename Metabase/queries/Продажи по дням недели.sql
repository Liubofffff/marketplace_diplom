SELECT
    EXTRACT(ISODOW FROM purchase_datetime) AS day_of_week,
    CASE EXTRACT(ISODOW FROM purchase_datetime)
        WHEN 1 THEN 'Понедельник'
        WHEN 2 THEN 'Вторник'
        WHEN 3 THEN 'Среда'
        WHEN 4 THEN 'Четверг'
        WHEN 5 THEN 'Пятница'
        WHEN 6 THEN 'Суббота'
        WHEN 7 THEN 'Воскресенье'
    END AS day_name,
    SUM(total_price) AS revenue,
    AVG(total_price) AS avg_check,
    COUNT(*) AS transactions,
    COUNT(DISTINCT client_id) AS unique_clients,
	SUM(quantity) AS quantity_sold
FROM sales
WHERE true
  [[AND {{product_id}}]]
  [[AND {{purchase_datetime}}]]
  [[AND {{gender}}]]
GROUP BY
    EXTRACT(ISODOW FROM purchase_datetime),
    day_name
ORDER BY day_of_week;