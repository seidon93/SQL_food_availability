SELECT  name AS item,
        min(year(date_from)) AS year_min,
        min(round(value)) AS price_min,
        'Kč' AS unit_price_measure,
        max(year(date_from)) AS year_max,
        max(round(value)) AS price_max,
        'Kč' AS unit_price_measure,
        round(((max(round(value)) - min(round(value))) / min(round(value))) * 100,1) AS P_food_dif,
        '%' AS measure_food_dif
FROM czechia_price_category AS category
JOIN czechia_price AS cp ON category.code = cp.category_code
WHERE name != 'Jakostní víno bílé'
GROUP BY name
ORDER BY P_food_dif;

