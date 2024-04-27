WITH salaries AS (
        SELECT
            payroll_year AS reference_year,
            industry.name AS industry,
            round(avg(value)) AS salary,
            round(((round(avg(value))- lag( round(avg(value))) OVER (PARTITION BY name ORDER BY payroll_year)) /
                   lag( round(avg(value))) OVER (PARTITION BY name ORDER BY payroll_year)) * 100, 1) AS percentage_yr_grow
            FROM czechia_payroll AS czpay
            JOIN czechia_payroll_industry_branch AS industry ON czpay.industry_branch_code = industry.code
            WHERE payroll_year IN (2006, 2018)
            GROUP BY payroll_year, industry
            ORDER BY industry, reference_year
    ),
    prices AS (
        SELECT
            category.name AS item,
            round(value, 1) AS unit_price,
            year(date_from) AS year,
            concat(price_value,' ', price_unit) AS "measure unit",
            price_unit

            FROM czechia_price_category AS category
            JOIN czechia_price AS cp ON category.code = cp.category_code
            WHERE category.name IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
            AND (year(date_from)) IN (2006, 2018)
            GROUP BY year, name
            ORDER BY year
    )
        SELECT
            sal.reference_year,
            sal.industry,
            concat(salary,' Kč') AS salary,
            pri.item,
            concat(unit_price, ' Kč') AS unit_price,
            round(sal.salary / pri.unit_price) AS 'purchasing_power',
            price_unit
            FROM salaries AS sal
            JOIN prices pri ON pri.year = sal.reference_year;

