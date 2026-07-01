-- Data Cleaning

SELECT * 
FROM layoffs;

-- 0. Duplicating our raw database to keep it safe
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * 
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- 1. Remove Duplicates
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location,
industry, total_laid_off, 
percentage_laid_off, `date`, stage, country,
funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

# Now we will create a new table to filter it
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num`INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location,
industry, total_laid_off, 
percentage_laid_off, `date`, stage, country,
funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT * 
FROM layoffs_staging2
WHERE row_num > 1; 

-- We will create a new column called row_id to assign an id for each row
-- PRIMARY KEY — guarantees every value is unique
-- FIRST — puts the column as the first column in the table
ALTER TABLE layoffs_staging2
ADD COLUMN row_id INT AUTO_INCREMENT PRIMARY KEY FIRST;


-- 2. Standardize the Data

# TRIM will just remove this white space

SELECT company, TRIM(company)
FROM layoffs_staging2
;

UPDATE layoffs_staging2
SET company = TRIM(company);

# Looking at the industry, we see that there is "Crypto", "Crypto Currency" and "CryptoCurrency, which should all be the same 
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1; #industry

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

# Looking at location, country, to see if we find more problems, we see that US has a problem
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

# Someone put "United States.", so a little trick to erase the "." is:
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country) #Trailing will just erase the dot
WHERE country like 'United States%';

# Or do the usual process: 
UPDATE layoffs_staging2
SET country = 'United States'
WHERE country like 'United States%';

# We will change the date type from text to Date, so we can use Time Series and EDA later
# First we have to change the format to the proper MySQL format, otherwise it will return an error
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

# Now we can update the type of the column
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- 3. Null Values or blank values
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = '';

# We see that there are some blanks in industry but we can populate them
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

# we will join on itself, cause then we will check:
# in this table do we have an industry that is blank/null and the same one not blank?
# if so, we update it with the non-blank one

# Error debugging: we will update BLANKS to NULL, because if we dont, it will not populate correctly

UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = ''; 

SELECT industry
FROM layoffs_staging2
ORDER BY 1
;

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;


-- 4. Remove Any Columns Useless or that we do not need

# We will delete this rows because it seems that these companies did not lay anyone off
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;
















