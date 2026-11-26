USE africa;

SHOW TABLES;

DESCRIBE Africa_population_long;

SELECT COUNT(*) AS total_records
FROM Africa_population_long;

SELECT COUNT(DISTINCT `Country Code`) AS total_countries
FROM Africa_population_long;

SELECT
    MIN(`Year`) AS first_year,
    MAX(`Year`) AS last_year,
    COUNT(DISTINCT `Year`) AS total_years
FROM Africa_population_long;

SELECT
    SUM(`Population`) AS population_1960
FROM Africa_population_long
WHERE `Year` = 1960;


SELECT
    SUM(`Population`) AS population_2025
FROM Africa_population_long
WHERE `Year` = 2025;

SELECT
    SUM(CASE WHEN `Year` = 2025
        THEN `Population` ELSE 0 END)
    -
    SUM(CASE WHEN `Year` = 1960
        THEN `Population` ELSE 0 END)
    AS total_population_increase
FROM Africa_population_long;

SELECT
    `Country Name`,
    `Population`
FROM Africa_population_long
WHERE `Year` = 2025
ORDER BY `Population` DESC
LIMIT 10;

SELECT
    `Country Name`,
    `Population`
FROM Africa_population_long
WHERE `Year` = 2025
ORDER BY `Population` ASC
LIMIT 10;

SELECT
    `Country Name`,
    ROUND(AVG(`Growth Rate (%)`) * 100, 2)
        AS average_growth_rate
FROM Africa_population_long
WHERE `Year` BETWEEN 1961 AND 2025
GROUP BY `Country Name`
ORDER BY average_growth_rate DESC;

SELECT
    `Year`,
    SUM(`Population`) AS total_population
FROM Africa_population_long
GROUP BY `Year`
ORDER BY `Year`;

SELECT
    `Country Name`,
    `Year`,
    `Population`
FROM Africa_population_long
WHERE `Country Name` IN (
    'Nigeria',
    'Egypt, Arab Rep.',
    'Ethiopia',
    'South Africa',
    'Congo, Dem. Rep.'
)
ORDER BY `Year`, `Country Name`;

SELECT
    `Country Code`,
    `Year`,
    COUNT(*) AS duplicate_count
FROM Africa_population_long
GROUP BY `Country Code`, `Year`
HAVING COUNT(*) > 1;


SELECT
    SUM(`Country Name` IS NULL) AS missing_country_names,
    SUM(`Country Code` IS NULL) AS missing_country_codes,
    SUM(`Year` IS NULL) AS missing_years,
    SUM(`Population` IS NULL) AS missing_population,
    SUM(`Annual Change` IS NULL) AS missing_annual_change,
    SUM(`Growth Rate (%)` IS NULL) AS missing_growth_rate
FROM Africa_population_long;

SELECT
    ROUND(
        (
            SUM(CASE WHEN `Year` = 2025
                THEN `Population` ELSE 0 END)
            -
            SUM(CASE WHEN `Year` = 1960
                THEN `Population` ELSE 0 END)
        )
        /
        SUM(CASE WHEN `Year` = 1960
            THEN `Population` ELSE 0 END) * 100,
        2
    ) AS population_growth_percentage
FROM Africa_population_long;