WITH salary AS (
    SELECT  payroll_year,
            industry.name,
            round(((round(sum(value)/4) - lag(round(sum(value)/4) ) OVER (PARTITION BY name ORDER BY payroll_year)) /
            lag(round(sum(value)/4) ) OVER (PARTITION BY name ORDER BY payroll_year)) * 100, 1) AS percentage_grow_salary
        FROM czechia_payroll AS czpay
        JOIN czechia_payroll_industry_branch AS industry ON czpay.industry_branch_code = industry.code
        WHERE payroll_year >= 2006
        GROUP BY industry.name, payroll_year ),

prices AS (
    SELECT
        name,
        round(avg(value)) AS price,
        year(date_from) AS year,
        round((round(avg(value)) - lag(round(avg(value))) OVER (PARTITION BY name ORDER BY year(date_from))) /
        lag(round(avg(value))) OVER (PARTITION BY name ORDER BY year(date_from)) * 100) AS perc_food_grow
    FROM czechia_price_category AS category
    JOIN czechia_price AS cp ON category.code = cp.category_code
    GROUP BY name, year
    ORDER BY name, year )

SELECT s.payroll_year AS reference_yr,
       s.name AS industry,
       p.name AS item,
       p.price AS unit_price,
       'Kč' AS unit_price_measure,
       s.percentage_grow_salary AS ΔP_salary,
       '%' AS measure_food_dif,
       p.perc_food_grow - s.percentage_grow_salary AS ΔP_food,
       '%' AS measure_food_dif
FROM salary s
JOIN prices p ON s.payroll_year = p.year
WHERE p.perc_food_grow - s.percentage_grow_salary > 10
ORDER BY s.payroll_year, item, industry;