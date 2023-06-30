-- CREATEING DATABASE

CREATE DATABASE hrdatabase;
-- --------------------------------
USE hrdatabase;
SELECT * FROM hr;


set sql_safe_updates = 0;

-- Changeing Column Name

ALTER TABLE hr
change column ï»¿id emp_id varchar(20) null; 

DESCRIBE hr;
select birthdate from hr;

-- -----------
-- Converting birthdate column to datetime format

UPDATE hr 
SET 
    birthdate = CASE
        WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
        WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
        ELSE NULL
    END;

alter table hr
modify column birthdate date;

-- -----------
-- Converting Hire_date column to datetime format

update hr
set 
	hire_date = case
		when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
        when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
        else null
	end;
    
alter table hr
modify column hire_date date;


-- ---------------------
-- Updating termdate column and formating

update hr
set termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate != " ";

alter table hr
modify column termdate date;

-- -------------------
-- calculating age

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr 
SET age = timestampdiff(YEAR, birthdate, CURDATE());

-- --------------------------
-- finding outliers
SELECT MIN(age) as youngest, MAX(age) as oldest
FROM HR;

SELECT COUNT(*)
FROM hr
WHERE age<18;


-- QUESTIONS
-- 1. What is the gender breakdown of employees in the company?

SELECT gender, count(*) as COUNT
FROM hr
WHERE age>=18 and termdate = '0000-00-00'
GROUP BY gender;

-- 2. what is the race/ethnicity breakdown of the employees in the company?

SELECT race, COUNT(*) AS race_count
FROM hr
WHERE age>=18 and termdate = "0000-00-00"
GROUP BY race
ORDER BY count(*) DESC;

-- 3. What is the age distribution of employees in the company?

SELECT 
	MIN(age) AS youngest,
    MAX(age) as olded
FROM hr
WHERE AGE>=18 AND termdate = "0000-00-00";

-- age group

SELECT
	CASE
    WHEN age>=18 AND age<=24 THEN "18-24"
    WHEN age>=25 AND age<=34 THEN "25-34"
    WHEN age>=35 AND age<=44 THEN "35-44"
    WHEN age>=45 AND age<=54 THEN "45-54"
    WHEN age>=55 AND age<=64 THEN "55-64"
    ELSE "65+"
END AS age_group,
count(*) AS age_count
FROM hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;


-- age group by gender

SELECT
	CASE
    WHEN age>=18 AND age<=24 THEN "18-24"
    WHEN age>=25 AND age<=34 THEN "25-34"
    WHEN age>=35 AND age<=44 THEN "35-44"
    WHEN age>=45 AND age<=54 THEN "45-54"
    WHEN age>=55 AND age<=64 THEN "55-64"
    ELSE "65+"
END AS age_group, gender,
count(*) AS age_count
FROM hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 4. How many employees work at headquarters versus remote locations?

SELECT location, count(*) AS location_count
FROM hr
WHERE age>=18 and termdate = "0000-00-00"
GROUP BY location;


-- 5. What is the average length of employment for employees who have been terminated?

SELECT
	round(avg(datediff(termdate, hire_date))/365,0) as avg_length_of_employee
FROM hr
WHERE termdate<= curdate() AND termdate <> '0000-00-00' AND age>=18;


-- 6. How does gender distribution vary across departments and job titles?

SELECT department, gender, count(*) DEPT_COUNT
FROM hr
WHERE age>=18 and termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department;


-- 7. What is the distribution of job titles across the company?

SELECT jobtitle, count(*) jobtitle_count
FROM hr
WHERE age>=18 and termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;


-- 8 which department has the highest turnover rate?

SELECT department,
	total_count,
    terminated_count,
    terminated_count/total_count as termination_rate
FROM(
	SELECT department,
		count(*) as total_count,
        SUM(CASE WHEN termdate != '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
        FROM hr
        WHERE age>=18
        GROUP BY department
        ) as subquery
ORDER BY termination_rate DESC;


-- 9. What is the distribution of employees across locations by city and state?

SELECT location_state, count(*) as location_count
FROM hr
WHERE age>=18 and termdate = '0000-00-00'
GROUP BY location_state
ORDER BY location_count DESC;


-- 10. How has the company's employee count changed over time based on hire and term dates?

SELECT
	year,
	hires,
    terminations,
    hires - terminations as net_change,
    round((hires - terminations)/ hires * 100, 2) as net_change_rate
FROM (
	SELECT 
		YEAR(hire_date) as year,
        count(*) as hires,
        SUM(CASE WHEN termdate != '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
        FROM hr
        WHERE age>=18
        GROUP BY YEAR(hire_date)
        ) AS subquery
ORDER BY year ASC;
    
    
-- 11. What is the tenure distribution for each department?

SELECT department, round(avg(datediff(termdate, hire_date)/365),0) avg_tenure
FROM hr
WHERE termdate<=curdate() AND termdate <> '0000-00-00' AND age>=18
GROUP BY department;