CREATE OR REPLACE TABLE t_Ondrej_Seidl_project_SQL_secondary_final AS (
    SELECT country,
           continent,
           region_in_world,
           currency_name,
           population,
           median_age_2018
    FROM countries
    WHERE country IS NOT NULL AND
          continent IS NOT NULL AND
          region_in_world IS NOT NULL AND
          currency_name IS NOT NULL AND
          median_age_2018 IS NOT NULL );



CREATE OR REPLACE TABLE t_Ondrej_Seidl_project_SQL_secondary_final2 AS (
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
);

