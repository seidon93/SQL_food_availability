# <span style="color:#104be0"> Project food availability</span>

##   <span style="color:#108f1f">• CÍL PROJEKTU </span>

**Pokusím se odpovědět na 5 výzkumných otázek, které zní:**

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?


2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné 
období v dostupných datech cen a mezd?


3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?


4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?


5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

6. Dodatečná data o dalších evropských státech

<span style="color:#911410"> <b>Note: pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období. </span>

### <span style="color:#000000">Použitý software </span>
- **DataGrip v. 2024.1.1**
- **RDBMS MariaDb 10.11.5**
- **Tableau 2024.1**

### <span style="color:#000000">Původ dat: </span>

Data jsou převzatá z Engeto academy a ČSÚ

#### <span style="color:#108f1f">Použité datové sady: </span>
- czechia_payroll
- czechia_payroll_industry_branch
- czechia_price
- czechia_price_category
- countries
- economies


### <span style="color:#000000"> Obecná logika </span>
- načtení datových sad
- spojení potřebných entit, k zodpovězení jednotlivých otázek
- vyčištění, seskupení dat v průběhu operací
- výpočtové operace
- přidání nebo, odebrání znaků či atributů pro přehlednost jednotek



