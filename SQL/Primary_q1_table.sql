SELECT
        industry.name AS industry,
        payroll_year AS reference_year,
        round(avg(value)) AS salary,
        'Kč' AS salary_measure,

        coalesce(
        round(((round(avg(value))- lag( round(avg(value))) OVER (PARTITION BY name ORDER BY payroll_year)) /
        lag( round(avg(value))) OVER (PARTITION BY name ORDER BY payroll_year)) * 100, 1), 0) AS ΔP_yr_grow_salary,

        '%' AS ΔP_yr_measure_grow
        FROM czechia_payroll AS czpay
        JOIN czechia_payroll_industry_branch AS industry ON czpay.industry_branch_code = industry.code
        WHERE payroll_year >= 2006 AND payroll_year <= 2018 AND value IS NOT NULL
        GROUP BY payroll_year, industry
        ORDER BY industry, reference_year;

