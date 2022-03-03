# Nicolas Haas - Launching into Computer Science, Assignment 1: Part 3


Question 1:
===========

List all Employees whose salary is between 1,000 AND 2,000. Show the Employee Name, Department and Salary.

#### Solution 1: 

SELECT ENAME,DNAME,SAL FROM EMP INNER JOIN DEPT ON DEPT.DEPTNO = EMP.DEPTNO WHERE SAL<=2000 AND SAL>=1000;

The solution uses an inner join operation (based on the department number) between the EMP and DEPT table because of the reason that it tries to show the name of the department rather than the department number. The choice of an inner join (intersection of both tables based on an identifier) is not restricted to be the only solution in this case (one could also use a full join because the DEPT table only contains metadata about the departments). The rest of the sql statement is a usual "select, from, where" statement which selects the required variables (ename, dname and sal) from the adapted table (after inner join) and depends this on the condition that the salary is between 1000 and 2000 units (where clause).

#### Alternative 1:

a) SELECT ENAME,DEPTNO,SAL FROM EMP WHERE SAL<=2000 AND SAL>=1000;

One could avoid to join on both tables in simply using the department number (instead of the name). This would then only use the EMP table and uses less programming time. 

b) SELECT ENAME,DNAME,SAL FROM EMP LEFT JOIN DEPT ON DEPT.DEPTNO = EMP.DEPTNO WHERE SAL<=2000 AND SAL>=1000;

Alternatively, inner, full and left join in the framework here lead to the same solution because the DEPT table contains only metadata and doesn't consist of added value in terms of new attributes. 

Finally, it should be mentioned that a restriction based on distinct values shouldn't be of interest in this question. This is simply explained by the reason that if it would be the case that an employee with the same name of the same department has the same salary, then one wants probably to see that there are two employees with the same properties.

Question 2:
===========

Count the number of people in department 30 who receive a salary and the number of people who receive a commission.

#### Solution 2:

SELECT CONCAT(COUNT(EMPNO),' salaries') AS 'Kind of remuneration' FROM EMP WHERE SAL!="" AND DEPTNO="30" UNION SELECT CONCAT(COUNT(EMPNO), ' commissions') FROM EMP WHERE COMM!="" AND DEPTNO="30";

Compared to a usual "select, from, where" statement the question in this case asks for two different sql queries which should be shown in one table. Therefore, the main solution uses the UNION operator which allows for such an "and" condition between two queries (The AND operator does this not). Additionally, each query is also restricted on the use of two conditions (department number '30' and salary/commission). In this case, one can always use the AND operator two combine two conditions into one query. Furthermore, to use the count of employees rather than the employees itself, the query needs to use the COUNT function when choosing the select field. The rest are simpler sql function such as "AS" to rename a variable while displaying it to the screen and "CONCAT" is chosen to see the difference between salaries and commissions.

#### Alternative 2:

SELECT COUNT(EMPNO), CASE WHEN (COMM>0 AND (SAL IS NULL OR SAL="")) THEN 'commissions' WHEN (SAL>0 AND (COMM="" OR COMM IS NULL)) THEN 'salaries' WHEN (SAL>0 AND COMM>0) THEN 'salaries and commissions' END AS 'unit' FROM EMP WHERE DEPTNO="30" GROUP BY unit;

The main idea of the alternative solution is to work with if, else statements which are in sql "WHEN, THEN" queries. These queries can in this case be used to distinguish between 3 main categories 'salaries', 'commissions' and 'salaries and commissons' and it saves this as a new variable 'unit'. It is important to group by the new variable 'unit' otherwise it will end up in using the EMPNO variable which is included in the COUNT clause. Because there are no surprises in commissions (for example only commission but no salary), the output only displays 'salaries' and 'salaries and commissions'. 

Question 3:
===========

Find the name and salary of employees in Dallas.

#### Solution 3:

SELECT LOC, ENAME,SAL FROM EMP LEFT JOIN DEPT ON DEPT.DEPTNO = EMP.DEPTNO WHERE LOC="DALLAS";

The query is very similar to question 1 and also uses a joint operator (in this case LEFT JOINT, but INNER and FULL work similarly in this case because the DEPT table only contains metadata). The main difference is that the variables of interest changes (name, salary) and the condition (where clause) is this time based on the department location which has to be "dallas".

#### Alternative 3:

See comments to "Alternative 1" which can be similarly interpreted.

Question 4:
===========

List all departments that do not have any employees.

#### Solution 4:

SELECT COUNT(EMPNO),LOC FROM EMP RIGHT JOIN DEPT ON DEPT.DEPTNO = EMP.DEPTNO GROUP BY LOC HAVING COUNT(EMPNO)="";

The query for this question differs essentially with respect to two dimensions. Firstly, it uses a right join on the DEPT table to ensure that all departments are included, also the departments which have an aggregated count of employees 0 (i.e. departments which have no entry in the EMP table). Secondly, the HAVING function is included because it allows to use an aggregate function (here COUNT) when applying it in a condition (here GROUP BY). To be more precise, in this particular case it means group all locations where the count by employee number is empty or zero. Finally, the count and the location will be displayed.

#### Alternative 4:

SELECT LOC FROM DEPT WHERE DEPTNO NOT IN (SELECT DEPTNO FROM COMPANY1.EMP);

Alternatively, one can work with the IN function which is comparable with pythons "in" function to compare the existence of a substring in a string. Here, it is used to check whether there is a department number in the DEPT table which is NOT a department number in the EMP table. If so, then the location of this department number will be displayed.

Question 5:
===========

List the department number and average salary of each department

#### Solution 5:

SELECT DEPTNO,AVG(SAL) FROM EMP GROUP BY DEPTNO;

In this query the GROUP BY function is once again used to aggregate values by the different departments. In this case it is the average value of salaries that one wants to know for each department. Hence, the AVG function is used because it directly calculates the mean of salaries (in this case by department because the table is grouped by department number). 

#### Alternative 5:

SELECT DEPTNO,SUM(SAL)/COUNT(sal) FROM EMP GROUP BY DEPTNO;

The alternative only changes in using more specific aggragation functions. Hence, the alternative answer only changes the AVG by the precise calculation of the mean which is the SUM(sal)/COUNT(sal). The rest is the same "SELECT FROM GROUP BY" statement as seen in the main solution.

