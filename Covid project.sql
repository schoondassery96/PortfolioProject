select * 
from Portfolioproject..CovidDeaths
where continent is not null
order by 3,4

--select * 
--from Portfolioproject..Covidvaccinations
--order by 3,4

select location,date,total_cases,new_cases,total_deaths,population
from Portfolioproject..coviddeaths
order by 1,2

--looking at Total Cases VS Total Deaths
--shows likelihood of dying if you contract in your country
select location, date, total_cases, total_deaths, (convert(decimal(15,3),total_deaths)/Convert(Decimal(15,3),total_cases)*100) as DeathPercentage
from Portfolioproject..coviddeaths
where location like '%india%'
order by 1,2

--Looking at Total Cases VS Populations
select location, date,population, total_cases, (convert(decimal(15,3),total_cases)/Convert(Decimal(15,3),population)*100) as PercentageDeath
from Portfolioproject..coviddeaths
--where location like '%india%'
order by 1,2

--looking at countries with highest infection rate compared to population
select location, population, Max(total_cases) as highestInfectionCount, Max((convert(decimal(15,3),total_cases)/Convert(Decimal(15,3),population))*100) as Percentagepopulationinfected
from Portfolioproject..coviddeaths
--where location like '%india%'
group by location, population
order by Percentagepopulationinfected desc

--Showing countries with highest Death Count per population
select location, max(cast(total_deaths as int)) as highestTotalDeath
from Portfolioproject..coviddeaths
--where location like '%india%'
where continent is not null
group by location
order by highestTotalDeath desc

--break down by continent
select continent, max(cast(total_deaths as int)) as highestTotalDeath
from Portfolioproject..coviddeaths
--where location like '%india%'
where continent is not null
group by continent
order by highestTotalDeath desc

--showing contintent with highest death count

select continent, max(cast(total_deaths as int)) as highestTotalDeath
from Portfolioproject..coviddeaths
--where location like '%india%'
where continent is not null
group by continent
order by highestTotalDeath desc


--breaking global numbers
select   sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/nullif (sum(new_cases),0)*100 as DeathPercentage
from Portfolioproject..coviddeaths
--where location like '%india%'
where continent is not null
--group by date
order by 1,2

--total population vs vaccinations in india


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from Portfolioproject..coviddeaths dea
join Portfolioproject..Covid_Vaccination vac on dea.location = vac.location 
and dea. date=vac.date
where dea.location like '%india%'
order by 1,2,3

--total population vs vaccinations

--use cte
with popvsvac (continent,location,date,population,new_vaccinations,rollingpeoplevaccinated)
as 

(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as bigint )) over (partition by dea.location order by dea.location,dea.date) 
as rollingpeoplevaccinated

from Portfolioproject..coviddeaths dea
join Portfolioproject..Covid_Vaccination vac on dea.location = vac.location 
and dea. date=vac.date
where dea.continent is not null
--order by 2,3
)
select * ,(rollingpeoplevaccinated/population)*100
from popvsvac

--use Temp table

drop table if exists #percentpopulationvaccinated
create table #percentpopulationvaccinated
(continent nvarchar (255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
Rollingpeoplevaccinated numeric
)
insert into #percentpopulationvaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as bigint )) over (partition by dea.location order by dea.location,dea.date) 
as rollingpeoplevaccinated

from Portfolioproject..coviddeaths dea
join Portfolioproject..Covid_Vaccination vac on dea.location = vac.location 
and dea. date=vac.date
--where dea.continent is not null
--order by 2,3

select * ,(rollingpeoplevaccinated/population)*100
from #percentpopulationvaccinated


--create view
create view  percentpopulationvaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as bigint )) over (partition by dea.location order by dea.location,dea.date) 
as rollingpeoplevaccinated

from Portfolioproject..coviddeaths dea
join Portfolioproject..Covid_Vaccination vac on dea.location = vac.location 
and dea. date=vac.date
where dea.continent is not null
--order by 2,3