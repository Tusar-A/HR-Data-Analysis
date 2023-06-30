# HR-Data-Analysis
HR Data Analysis with MYSQL &amp; Power BI
![image](https://github.com/Tusar-A/HR-Data-Analysis/assets/40721215/48a3ba27-f129-4ef6-815f-75ddd2dbc359)



Data – HR Data with over 22000 rows from 2000 to 2020<br>
Data Cleaning & Analysis – MySQL Workbench<br>
Data Visualization – Power BI<br>

## Goal
The goal of this project is to find out the distribution of employee into different criteria. For example, the gender distribution, race distribution, employee location, age group and so on. The dataset has more than 22000 rows and 14 columns. 
The analysis part of this project is done in MySQL workbench and for dashboarding I’ve used Microsoft Power BI tool.

## Questions to be answered.
1.	What is the gender breakdown of employees in the company?
2.	2. what is the race/ethnicity breakdown of the employees in the company?
3.	What is the age distribution of employees in the company?
4.	How many employees work at headquarters versus remote locations?
5.	What is the average length of employment for employees who have been terminated?
6.	How does gender distribution vary across departments and job titles?
7.	What is the distribution of job titles across the company?
8.	which department has the highest turnover rate?
9.	What is the distribution of employees across locations by city and state?
10.	How has the company's employee count changed over time based on hire and term dates?
11.	What is the tenure distribution for each department?

## Findings

1.	Average employee termination length is around 8 years.
2.	There is more male employee than female but the difference is no so big.
3.	Around 75% employee work in office where around 25% employee work remotely
4.	Most of the employee are from Ohio State and its number is 14144. It might be the headquarter of the company is in Ohio.
5.	White is the most dominant race while American Indian and Native Hawaian are least dominant.
6.	Most of the employees in the company are from 25 -34 years age group where least age group is 55-64.
7.	Breaking down department most of the employee both male and female are in Engineering department and least are in Auditing.
8.	The net change in employee is increased over the years

   
## Limitations
1.	Some record had negative ages and these were excluded by querying. Taken the age only 18 or above 18.
2.	Some termdates were far into the future. These were not included in the analysis. Taken the termdates used were those are less than or equal to current date.
