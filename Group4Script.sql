# Before these commands, I cleaned the data. Most of the queries are used for years from 1995 and 2015 after 5 year of spam.
#1,2,3 Show Database
SELECT * FROM DatabaseProject.gdp;
SELECT * FROM DatabaseProject.median_age;
SELECT * FROM DatabaseProject.obesity ;

#4 Joined GDP and Median_AGE Tables for Analysis
Select G.Year,GDP_in_USD,Population,Median_Age from DatabaseProject.median_age M
Join DatabaseProject.gdp G on M.Year = G.Year 
Order by G.year Asc;



#5 Joined Obesity and Median_age Tables for Analysis 

Select O.Year,Median_Age,Obesity_Rate,Sex as Gender from DatabaseProject.median_age M
 Join DatabaseProject.obesity O on M.Year = O.Year 
where  M.Year>=1995 and M.Year%5=0 
order by M.Year Asc;


#6Fetching Population growth 
Select Year, Population from DatabaseProject.gdp
where Year%5=0 and Year>=1995
order by Year Asc;

#7Fetching Obesity and Population
Select O.Year, Obesity_Rate, GDP_in_USD, Population From DatabaseProject.obesity O
Join DatabaseProject.gdp G on O.Year = G.Year 
where sex ="Both Sexes" and O.Year%5=0 and O.Year>=1995 
order by O.Year Asc;


#8Average GDP from 1995 to 2015 after every 5 Years
SELECT Avg(GDP_in_USD)
FROM DatabaseProject.gdp
where Year%5=0 and Year>=1995 
;


#9minimum population in different year
Select Year, Population
from DatabaseProject.gdp
where population = (
Select min(Population)
from DatabaseProject.gdp where Year%5=0 and Year>=1995);

#10maximum population in different year
Select Year, Population
from DatabaseProject.gdp
where population = (
Select max(Population)
from DatabaseProject.gdp where Year%5=0 and Year>=1995);

#11fetching year for maximum percentage change of GDP
Select Year,GDP_Change_percent from DatabaseProject.gdp 
where GDP_Change_percent = (
select max(GDP_Change_percent)
from DatabaseProject.gdp where Year%5=0 and Year>=1995);

#12fetching year for minimum percentage change of GDP
Select Year,GDP_Change_percent from DatabaseProject.gdp 
where GDP_Change_percent = (
select min(GDP_Change_percent)
from DatabaseProject.gdp where Year%5=0 and Year>=1995 );


# 13 obesity rate for female for every year
Select * from DatabaseProject.obesity 
where Sex="Female" and Year%5=0 and Year>=1995;


# 14 obesity rate male for every year
Select * from DatabaseProject.obesity 
where Sex="Male" and Year%5=0 and Year>=1995;


#Other Command Use
alter table DatabaseProject.obesity
drop column Country;
;

#Other Command Use
alter table DatabaseProject.gdp
drop column Country;
Select * from DatabaseProject.obesity;

# This command is used for finding the rate change of GDP between two different years. negative value shows the increase percentage 
#
Select ((((
select GDP_in_USD from databaseProject.gdp where Year =1995)
-
(select GDP_in_USD from databaseProject.gdp where Year =2000
))/(
select GDP_in_USD from databaseProject.gdp where Year =1995) )*100)as 1995_2000,
((((
select GDP_in_USD from databaseProject.gdp where Year =2000)
-
(select GDP_in_USD from databaseProject.gdp where Year =2005
))/(
select GDP_in_USD from databaseProject.gdp where Year =2000) )*100)as 2000_2005,
((((
select GDP_in_USD from databaseProject.gdp where Year =2005)
-
(select GDP_in_USD from databaseProject.gdp where Year =2010
))/(
select GDP_in_USD from databaseProject.gdp where Year =2005) )*100)as 2005_2010,
((((
select GDP_in_USD from databaseProject.gdp where Year =2010)
-
(select GDP_in_USD from databaseProject.gdp where Year =2015
))/(
select GDP_in_USD from databaseProject.gdp where Year =2010) )*100)as 2010_2015
from DatabaseProject.gdp 
where Year%5=0 and Year>=1995 
order by Year ASC
limit 1
;
 
 #join three Tables and print new table
Create table DatabaseProject.final_data as
Select M.Year,Median_Age,GDP_in_USD,GDP_Real_in_USD,GDP_Change_percent,GDP_Per_Capita_in_USD,Population,Obesity_Rate,Sex as Gender from DatabaseProject.median_age M
Join DatabaseProject.gdp G on M.Year = G.Year 
Join DatabaseProject.obesity O on M.Year = O.Year;
Select * from DatabaseProject.final_data;