SELECT  name,
        min(year(date_from)) AS year_min,
        min(round(value)) AS price_min,
        max(year(date_from)) AS year_max,
        max(round(value)) AS price_max,
        concat(round(((max(round(value)) - min(round(value))) / min(round(value))) * 100,1),' %') AS ΔP_food_dif
FROM czechia_price_category AS category
JOIN czechia_price AS cp ON category.code = cp.category_code
GROUP BY name
ORDER BY ΔP_food_dif;

