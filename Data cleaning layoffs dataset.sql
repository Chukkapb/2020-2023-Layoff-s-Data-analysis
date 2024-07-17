-- Data cleaning
SELECT * FROM layoffs_eda.layoffs;

Create table layoffs_staging like layoffs;

insert layoffs_staging 
select * from layoffs;



-- checking and removing duplicates

#no unique identifier in the table, will be doing by adding row number

Select *,
Row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off, `date`) as row_num
from layoffs;

with duplicate_cte as
(Select *,
Row_number() 
over(partition by company,location,industry,total_laid_off,percentage_laid_off,country,funds_raised_millions, `date`) as row_num
from layoffs)
select * from duplicate_cte where row_num>1;

select * from layoffs where company = 'Casper';


with duplicate_cte as
(Select *,
Row_number() 
over(partition by company,location,industry,total_laid_off,percentage_laid_off,country,funds_raised_millions, `date`) as row_num
from layoffs)
delete from duplicate_cte where row_num>1;

#creating another staging table with a fields row_num
CREATE TABLE `layoffs_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_staging_2;

insert layoffs_staging_2
(Select *,
Row_number() 
over(partition by company,location,industry,total_laid_off,percentage_laid_off,country,funds_raised_millions, `date`) as row_num
from layoffs);

select * from layoffs_staging_2 where row_num>1;

delete from layoffs_staging_2
where row_num>1;

select * from layoffs_staging_2;

-- Standardizing the data
select company from layoffs_staging_2;

select company, Trim(company)
from layoffs_staging_2;

update layoffs_staging_2
set company = Trim(company);

select * from layoffs_staging_2 where industry like 'Crypto%';

update layoffs_staging_2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct(industry) from layoffs_staging_2 order by industry;

select distinct(location) from layoffs_staging_2 order by location;
select country, location from layoffs_staging_2 where location in ('MalmÃ¶','Malmo');

select * from layoffs_staging_2 where location = 'MalmÃ¶';

update layoffs_staging_2 
set location = 'Malmo'
where location = 'MalmÃ¶';

select country, location from layoffs_staging_2 where location = 'DÃ¼sseldorf';

update layoffs_staging_2
set location = 'Dusseldorf'
where location = 'DÃ¼sseldorf';

select country, location from layoffs_staging_2 where location = 'FlorianÃ³polis';

update layoffs_staging_2
set location = 'Florianopolis'
where location = 'FlorianÃ³polis';

select distinct country from layoffs_staging_2 order by country;

select distinct country, Trim(trailing '.' from country) from layoffs_staging_2 order by country;

update layoffs_staging_2
set country  = trim(trailing '.' from country);

select `date` from layoffs_staging_2;

select `date`,
str_to_date(`date`,'%m/%d/%Y')
 from layoffs_staging_2;
 
update layoffs_staging_2
 set `date` = str_to_date(`date`,'%m/%d/%Y');
 
alter table layoffs_staging_2
modify column `date` Date;

-- working with null and blank values
select * from layoffs_staging_2
where total_laid_off is null;

select * from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;

select * from layoffs_staging_2
where industry is null or industry = '';

update layoffs_staging_2
set industry = Null
where industry = '';

select * from layoffs_staging_2 where company = 'Carvana';

select t1.company, t1.industry, t2.industry from layoffs_staging_2 t1 join layoffs_staging_2 t2
on t1.company = t2.company 
where t1.industry is null and t2.industry is not null;

update layoffs_staging_2 t1 join
layoffs_staging_2 t2 on t1.company = t2.company 
set t1.industry = t2.industry 
where t1.industry is null and t2.industry is not null;

select * from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;
-- we do not have additional information like total number of employees to generate values

update layoffs_staging_2
set percentage_laid_off = round(percentage_laid_off *100);

select * from layoffs_staging_2;


alter table layoffs_staging_2
drop column row_num;

select company,stage from layoffs_staging_2 where stage is null or stage = '';

select * from layoffs_staging_2 where company = 'Gatherly';
