SELECT
    country,
    year,
    gdp AS HDP,
    round(taxes, 1) AS taxes
FROM economies
WHERE year BETWEEN 2006 AND 2018
ORDER BY year
OFFSET 49 ROWS

