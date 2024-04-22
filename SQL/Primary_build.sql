/*
 CZ: Q1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
     Q2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období
         v dostupných datech cen a mezd?
     Q3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
     Q4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
     Q5: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce,
         projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

 Note: data mezd a cen potravin pro společné roky 2006 - 2018
 */
-- zjištění společných let q2
SELECT payroll_year FROM czechia_payroll;
SELECT max(year(date_from)), max(year(date_to)) FROM czechia_price;

-- Q1
SELECT
    payroll_year AS reference_year,
    industry.name AS industry,
    round(avg(value))  AS salary
    FROM czechia_payroll AS czpay
    JOIN czechia_payroll_industry_branch AS industry ON czpay.industry_branch_code = industry.code
    WHERE payroll_year >= 2006 AND payroll_year <= 2018
    GROUP BY payroll_year, industry
    ORDER BY industry, reference_year;

-- výpočet % nárustu/ poklesu mezd
-- # ((aktuální hodnota) - (počáteční hodnota)) / (počáteční hodnota) * 100


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

-- --------------------------------------------------------------------------------------------------------------