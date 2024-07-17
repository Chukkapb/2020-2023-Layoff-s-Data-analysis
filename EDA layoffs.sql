-- Exploratory Data analysis

select * from layoffs_staging_2;

Select Max(total_laid_off), Max(percentage_laid_off) from layoffs_staging_2;

select * from layoffs_staging_2 where percentage_laid_off = 100 ;

select * from layoffs_staging_2 where percentage_laid_off = 100 order by funds_raised_millions desc ;

#to understand which company has higher layoffs
select company, sum(total_laid_off), avg(percentage_laid_off) from layoffs_staging_2 
group by company order by avg(percentage_laid_off) desc, sum(total_laid_off) desc ;

select company, sum(total_laid_off), avg(percentage_laid_off) from layoffs_staging_2 
group by company order by sum(total_laid_off) desc, avg(percentage_laid_off) desc ;

#dataset with 3 years gap
select min(`date`), max(`date`) from layoffs_staging_2;

#to understand which industry is effected and has more layoffs
select industry, sum(total_laid_off), Round(avg(percentage_laid_off),2) from layoffs_staging_2 
group by industry order by sum(total_laid_off) desc, avg(percentage_laid_off) desc ;

select industry, sum(total_laid_off), Round(avg(percentage_laid_off),2) from layoffs_staging_2 
group by industry order by 3 desc, 2 desc ;

#gives out which country has higher number of layoffs
select country, sum(total_laid_off), Round(avg(percentage_laid_off),2) from layoffs_staging_2 
group by country order by 2 desc, 3 desc ;

#layoffs based on the year
select year(`date`), sum(total_laid_off) from layoffs_staging_2 group by year(`date`) order by 2 desc;

select month(`date`), sum(total_laid_off) from layoffs_staging_2 group by month(`date`) order by 2 desc;


#layoffs based on the stage 
select stage, sum(total_laid_off) from layoffs_staging_2 group by stage order by 2 desc;


Select substring(`date`,1,7) as month, sum(total_laid_off) 
from layoffs_staging_2
where substring(`date`,1,7) is not null
group by `month`
order by  2 desc
 ;

with rolling_total as
(
Select substring(`date`,1,7) as month, sum(total_laid_off) as laid_off
from layoffs_staging_2
where substring(`date`,1,7) is not null
group by `month`
order by  2 desc
)
select `month`,laid_off, sum(laid_off) over(order by `month`)
from rolling_total;

select company, year(`date`), sum(total_laid_off)
from layoffs_staging_2 
group by company, year(`date`)
order by 3 desc;

with company_cte(company,years,laid_off_total) as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging_2 
group by company, year(`date`)
)
select * ,
DENSE_RANK() over(partition by years order by laid_off_total desc) as ranking
from company_cte
where years is not null
order by ranking asc ;

# year wise top 5 companies that laid off more people
with company_cte(company,years,laid_off_total) as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging_2 
group by company, year(`date`)
), layoff_ranking as
(select * ,
DENSE_RANK() over(partition by years order by laid_off_total desc) as ranking
from company_cte
where years is not null)
select * from layoff_ranking  where ranking <= 5;

with industry_cte(industry,years,laid_off_total) as
(
select industry, year(`date`), sum(total_laid_off)
from layoffs_staging_2 
group by industry, year(`date`)
), layoff_ranking as
(select * ,
DENSE_RANK() over(partition by years order by laid_off_total desc) as ranking
from industry_cte
where years is not null)
select * from layoff_ranking where ranking<=5 ;