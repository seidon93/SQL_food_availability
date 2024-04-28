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
      median_age_2018 IS NOT NULL ;


