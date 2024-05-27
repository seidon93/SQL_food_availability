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
        lag(round(avg(value))) OVER (PARTITION BY name ORDER BY year(date_from)) * 100, 1) AS perc_food_grow
    FROM czechia_price_category AS category
    JOIN czechia_price AS cp ON category.code = cp.category_code
    GROUP BY name, year
    ORDER BY name, year ),

hdp AS (
    SELECT
        country,
        year AS eco_year,
        GDP AS HDP
    FROM economies
    WHERE economies.year BETWEEN 2006 AND 2018
      AND  country = 'Czech republic'
    ORDER BY eco_year
)

SELECT s.payroll_year,
       p.name AS product,
       p.price AS product_price,
       'Kč' AS measure,
       s.percentage_grow_salary AS ΔP_grow_salary,
       '%' AS percent,
       p.perc_food_grow - s.percentage_grow_salary AS ΔP_grow_food,
        '%' AS percent,
       hdp.HDP
FROM salary s
JOIN prices p ON s.payroll_year = p.year
JOIN hdp ON eco_year = payroll_year
GROUP BY year, product
ORDER BY product, year;


