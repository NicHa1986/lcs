--Connection to SQL
mysql;
--Connection to database 
USE COMPANY1;

--List all Employees whose salary is between 1,000 AND 2,000. Show the Employee Name, Department and Salary
--My solution used an inner join operation (based on the department number) between the EMP and DEPT table because of the reason that I wanted to show the name of the department rather than the department number. The choice of an inner join (intersection of both tables based on the key) is not restricted to be the only solution in this case (one could also use a full join in this case because the DEPT table only contains metadata about the departments). The rest of the sql statement is a usual "select, from, where" statement which selects the required variables (ename, dname and sal) from the adapted table (after inner join) and depends this on the condition that the salary is between 1000 and 2000 units (where clause). 
SELECT ENAME,DNAME,SAL FROM EMP INNER JOIN DEPT ON DEPT.DEPTNO = EMP.DEPTNO WHERE SAL<=2000 AND SAL>=1000;

--Count the number of people in department 30 who receive a salary and the number of people who receive a commission
--Compared to a usual "select, where, statement" the question in this case asks for two different sql queries which should be shown in one table. Therefore, I used the UNION operator which allows for such an "and" condition between two queries (The AND operator does this not). Additionally, each query was also restricted on the use of two conditions (department number '30' and salary/commission). In this case, one can always use the AND operator two combine two conditions into one query. Furthermore, to use the count of employees rather than the employees itself, the query needs to use the count when choosing the select field. The rest are simpler sql function such as "AS" to rename a variable while displaying it to the screen and "CONCAT" was chosen to see the difference between salaries and commissions.
SELECT CONCAT(COUNT(EMPNO),' salaries') AS 'Kind of remuneration' FROM EMP WHERE SAL!="" AND DEPTNO="30" UNION SELECT CONCAT(COUNT(EMPNO), ' commissions') FROM COMPANY1.EMP WHERE COMM!="" AND DEPTNO="30";

--Find the name and salary of employees in Dallas
--The query is very similar to question 1 and also uses a joint operator (in this case LEFT JOINT, but INNER and FULL work similarly in this case because the DEPT table only contains metadata). The main difference is that the variables of interest changes (name, salary) and the condition (where clause) is this time based on the department location which has to be "dallas".
SELECT LOC, ENAME,SAL FROM EMP LEFT JOIN DEPT ON DEPT.DEPTNO = EMP.DEPTNO WHERE LOC="DALLAS";

--List all departments that do not have any employees
--The query for this question differs essentially with respect to two dimensions. Firstly, it uses a right join on the DEPT table to ensure that all departments are included, also the departments which have an aggregated count of employees 0 (i.e. departments which have no entry in the EMP table). Secondly, the HAVING function is included because it allows to use an aggregate function (here COUNT) when applying it in a condition (here GROUP BY). To be more precise, in this particular case it means group all locations where the count by employee number is empty or zero. Finally, the count and the location will be displayed.
SELECT COUNT(EMPNO),LOC FROM EMP RIGHT JOIN DEPT ON DEPT.DEPTNO = EMP.DEPTNO GROUP BY LOC HAVING COUNT(EMPNO)="";

--List the department number and average salary of each department
--In this query the group by function is once again used to aggregate values by the different departments. In this case it is the average value of salaries that one wants to know for each department. Hence, the AVG function is used because it directly calculates the mean of salaries (in this case by department because the table is grouped by department number). 
SELECT DEPTNO,AVG(SAL) FROM EMP GROUP BY DEPTNO;