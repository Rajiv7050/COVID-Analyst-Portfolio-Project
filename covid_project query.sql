-- looking at the columns of data
Select * from Covid_Project.dbo.Covid_deaths;

--update new_cases from Zero to NULL
Update Covid_Project.dbo.Covid_deaths
set new_cases = Null 
where new_cases= '0' ;

-- update new_deaths from Zero to NULL
Update Covid_Project.dbo.Covid_deaths
set new_deaths = Null 
where new_deaths= '0' ;

--slecting important columns
Select continent, location, date, population, total_cases, new_cases,total_deaths, new_deaths
from Covid_Project.dbo.Covid_deaths
where continent is  not null  
order by  location, date;



--GLOBAL DATA
--counts of total cases all over world
 Select  sum(new_cases) as totalcases
from Covid_Project.dbo.Covid_deaths
where continent is not null  ;

--counts of total deaths all over world
 Select sum(cast (new_deaths as float))as totaldeaths
from Covid_Project.dbo.Covid_deaths
where continent is not null  ;

--- Mortality rate all over world
Select sum(cast (new_deaths as float))as totaldeaths, sum(new_cases) as totalcases,
(sum(cast (new_deaths as float))/sum(new_cases))*100 as mortality_rate
from Covid_Project.dbo.Covid_deaths
where continent is not null
order by mortality_rate;

-- percentage of deaths in respect of population all over world
Select sum(cast (new_deaths as float))as totaldeaths, 
sum(distinct population) as population,
(sum(cast (new_deaths as float))/sum(distinct population))*100 as mortality_rate
from Covid_Project.dbo.Covid_deaths
where continent is not null
order by mortality_rate;

-- infection rate  all over world
Select sum(cast (new_cases as float))as totalcases, 
sum(distinct population) as population,
(sum(cast (new_cases as float))/sum(distinct population))*100 as infection_rate
from Covid_Project.dbo.Covid_deaths
where continent is not null
order by infection_rate;



--CONTINENTS LeVEL DATA
-- counts of total cases in continents
Select continent, max(total_cases) as total
from Covid_Project.dbo.Covid_deaths
where continent is not null
group by continent
order by total desc;

-- counts of deaths on continent level
Select continent, sum(cast (new_deaths as int)) as totaldeaths
from Covid_Project.dbo.Covid_deaths
where continent is not null
group by continent
order by totaldeaths desc;
 
 -- percentage of deaths in respect of population on continent level
Select continent, sum(cast (new_deaths as int)) as totaldeaths ,sum(distinct population)as population,
sum(cast (new_deaths as int))/ sum (distinct population)*100
as death_percentage_of_population
from Covid_Project.dbo.Covid_deaths
where continent is not null 
group by continent
order by death_percentage_of_population  desc;

--Mortality rate on continent level
Select continent ,sum(cast (new_deaths as int)) as totaldeaths, sum(new_cases) totalcases,
( max(cast (new_deaths as int))/sum(new_cases)*100) as mortality_rate
from Covid_Project.dbo.Covid_deaths
where continent is not null 
group by continent
order by continent, mortality_rate  desc;

-- infection rate on continent level
Select continent,sum(cast (new_cases as float))as totalcases, 
sum( distinct population) as population,
(sum(cast (new_cases as float))/sum (distinct population))*100 as infection_rate
from Covid_Project.dbo.Covid_deaths
where continent is not null
group by continent
order by infection_rate;



-- INDIA Level data
-- count of deaths in India
Select  location,
max(cast (total_deaths as int)) as total
from Covid_Project.dbo.Covid_deaths
where continent is not null and location = 'India'
group by location;

-- count of total cases in INDIA
Select  location,
max(cast (total_deaths as int)) as total
from Covid_Project.dbo.Covid_deaths
where continent is not null and location = 'India'
group by location;

--  mortality rate in our country(INDIA) on daily basis
Select date,location, total_cases,total_deaths, (total_deaths/total_cases)*100 as mortality_rate
from Covid_Project.dbo.Covid_deaths
where continent is not null 
and location like 'India'
order by  date;

-- overall mortality rate in our country(INDIA) 
Select location ,max(cast (total_deaths as int)) as totaldeaths, max(total_cases) totalcases,
( max(cast (total_deaths as int))/max(total_cases)*100) as mortality_rate
from Covid_Project.dbo.Covid_deaths
where continent is not null and location = 'India'
group by location
order by location, mortality_rate  desc;

 -- percentage of deaths in respect of population in INDIA
 Select location ,max(cast (total_deaths as int)) as totaldeaths, max(population) as population,
 max(cast (total_deaths as int))/ max(population)*100 as percentage_of_deaths
from Covid_Project.dbo.Covid_deaths
where continent is not null and location = 'India'
group by location
order by location, percentage_of_deaths  desc;

--infection rate in INDIA
 Select location ,max(cast (total_cases as int)) as totaldeaths, max(population) as population,
 max(cast (total_cases as int))/ max(population)*100 as percentage_of_deaths
from Covid_Project.dbo.Covid_deaths
where continent is not null and location = 'India'
group by location
order by location, percentage_of_deaths  desc;



--ASIAN COUNTRIES DATA
-- Mortality rate till 8 JAN 2022 in various countries across ASIA
Select location, max(cast (total_deaths as int)) as totaldeaths, max(total_cases) as totalcases
,(max(cast (total_deaths as int))/max(total_cases))*100  as  Mortality_rate
From Covid_Project.dbo.Covid_deaths
Where 
 continent is not null and continent = 'Asia'
 group by location
order by  Mortality_rate desc;

--percentage of deaths in respect of population  till 8 JAN 2022 with Covid in various countries of Asia
Select location,  sum(cast (new_deaths as int)) as totaldeaths,max(population) as population, 
sum(cast (new_deaths as int))/ max(population)*100
as death_percentage_of_population
from Covid_Project.dbo.Covid_deaths
where continent is not null  and continent = 'Asia'
group by location
order by death_percentage_of_population  desc;

--Infection Rate compared in various countries of  Asia
select location, sum(cast (new_cases as int)) totalcases,max(population) population, sum(cast (new_cases as int))/ max(population)*100
as death_percentage_of_population
from Covid_Project.dbo.Covid_deaths
where continent is not null  and continent = 'Asia'
group by location
order by death_percentage_of_population  desc;
--OR
select location, max(cast (total_cases as int)) totalcases,max(population) population, max(cast (total_cases as int))/ max(population)*100
as death_percentage_of_population
from Covid_Project.dbo.Covid_deaths
where continent is not null  and continent = 'Asia'
group by location
order by death_percentage_of_population  desc;



--DAILY BASIS DATA
-- perecentage_of_daily_deaths
Select location,date, new_cases,new_deaths,date ,(new_deaths/new_cases)*100 as perecentage_of_daily_deaths
from Covid_Project.dbo.Covid_deaths
where continent is not null 
order by location, perecentage_of_daily_deaths  desc;

-- highest_perecentage_of_daily_deaths country wise
Select location , date,max(new_deaths/new_cases)*100 as highest_perecentage_of_daily_deaths
from Covid_Project.dbo.Covid_deaths
where continent is not null 
group by date, location
order by location, highest_perecentage_of_daily_deaths  desc;

--percentage_of_deaths in ASIA on dialy basis
Select date,location, total_cases,total_deaths, (total_deaths/total_cases)*100 as perecentage_of_deaths
from Covid_Project.dbo.Covid_deaths
where continent is null 
and location like 'Asia'
order by  date;

--VACCINATION
-- looking at the columns of data
