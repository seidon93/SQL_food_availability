SELECT
    country,
    year,
    population,
    gini,
    round(GDP, 1)AS HDP,
    round(taxes, 1) AS taxes
FROM economies
WHERE gini  IS NOT NULL
  AND taxes IS NOT NULL
