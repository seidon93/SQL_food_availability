WITH items AS (
        SELECT
            category.name AS item,
            round(avg(value), 1) AS unit_price,
            price_unit AS measure_unit,
            year(date_from) AS ref_year

            FROM czechia_price_category AS category
            JOIN czechia_price AS cp ON category.code = cp.category_code
            WHERE category.name IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
            AND (year(date_from)) IN (2006, 2018)
            GROUP BY item, measure_unit, ref_year
            ORDER BY ref_year
    ),

    salary AS (
        SELECT
            payroll_year AS reference_year,
            round(avg(value)) AS salary

            FROM czechia_payroll AS czpay
            JOIN czechia_payroll_industry_branch AS industry ON czpay.industry_branch_code = industry.code
            WHERE payroll_year IN (2006, 2018)
            GROUP BY reference_year
            ORDER BY  reference_year
    )

        SELECT  sal.reference_year,
                salary,
                item,
                unit_price,
                round(sum(salary / unit_price), 0) AS item_count,
                measure_unit

        FROM salary AS sal
        JOIN items  AS ite ON sal.reference_year = ite.ref_year
        GROUP BY ref_year, item, measure_unit




