--preparing the data and joining different table/sheets into single a database
 with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])
SELECT * FROM hotels
LEFT JOIN [dbo].[market_segment$]
ON hotels.market_segment = market_segment$.market_segment
LEFT JOIN
[dbo].[meal_cost$]
ON meal_cost$.meal = hotels.meal

--REVENUE WITH RESPECT TO YEAR,MONTH AND DATE
 with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

SELECT  arrival_date_day_of_month,arrival_date_month,arrival_date_year,ROUND(SUM((hotels.stays_in_weekend_nights +hotels.stays_in_week_nights)*(1-dbo.market_segment$.Discount)*hotels.adr),2) AS revenue
FROM hotels
LEFT JOIN [dbo].[market_segment$]
ON hotels.market_segment = market_segment$.market_segment
GROUP BY arrival_date_month,arrival_date_day_of_month,arrival_date_year
order by arrival_date_month,arrival_date_day_of_month,arrival_date_year


--To calculate the cancellation rate of bookings, you can use a CASE statement and aggregate functions:
with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])
SELECT
ROUND((SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) / CAST(COUNT(*) AS FLOAT)) * 100,2) AS CancellationRate
FROM hotels;

--Number of bookings per year, month, and week:

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])
SELECT arrival_date_year, arrival_date_month, arrival_date_week_number, COUNT(*) AS BookingsCount
FROM hotels
GROUP BY arrival_date_year, arrival_date_month, arrival_date_week_number;

--Number of bookings for each market segment and distribution channel:

WITH hotels AS (
    SELECT * FROM dbo.['2018$']
    UNION
    SELECT * FROM dbo.['2019$']
    UNION
    SELECT * FROM dbo.['2020$']
)

SELECT market_segment, distribution_channel, COUNT(*) AS BookingsCount
FROM hotels
GROUP BY market_segment, distribution_channel;

--Number of repeated guests and their percentage:
WITH hotels AS (
    SELECT * FROM dbo.['2018$']
    UNION
    SELECT * FROM dbo.['2019$']
    UNION
    SELECT * FROM dbo.['2020$']
)
SELECT is_repeated_guest, COUNT(*) AS GuestCount, (COUNT(*) * 100 / (SELECT COUNT(*) FROM hotels)) AS Percentage
FROM hotels
GROUP BY is_repeated_guest;


--Top countries with the most bookings:
WITH hotels AS (
    SELECT * FROM dbo.['2018$']
    UNION
    SELECT * FROM dbo.['2019$']
    UNION
    SELECT * FROM dbo.['2020$']
)
SELECT country, COUNT(*) AS BookingsCount
FROM hotels
GROUP BY country
ORDER BY BookingsCount DESC



--Number of bookings for each meal type:
WITH hotels AS (
    SELECT * FROM dbo.['2018$']
    UNION
    SELECT * FROM dbo.['2019$']
    UNION
    SELECT * FROM dbo.['2020$']
)
SELECT meal, COUNT(*) AS BookingsCount
FROM hotels
GROUP BY meal;

