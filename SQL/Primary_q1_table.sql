SELECT
        payroll_year AS reference_year,
        industry.name AS industry,
        round(avg(value)) AS salary,
        round(((round(avg(value))- lag( round(avg(value))) OVER (PARTITION BY name ORDER BY payroll_year)) /
               lag( round(avg(value))) OVER (PARTITION BY name ORDER BY payroll_year)) * 100, 1) AS percentage_yr_grow
        FROM czechia_payroll AS czpay
        JOIN czechia_payroll_industry_branch AS industry ON czpay.industry_branch_code = industry.code
        WHERE payroll_year >= 2006 AND payroll_year <= 2018
        GROUP BY payroll_year, industry
        ORDER BY industry, reference_year;
