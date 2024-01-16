create database sqlassignment3
use sqlassignment3
create table EmployeeDetails (Empid int,Fullname varchar(max),managerid int,Dateofjoining date,city varchar(max))
insert into EmployeeDetails values 
(
121,'John Snow' ,321,'2019-01-31','Toronto'),
(321,'Walter White',986,'2020-01-30','California'),
(421,'Kuldeep Rana',876,'2021-11-27','new delhi')

create table EmployeeSalary (Empid int,Project varchar(max),Salary int,Variable int)
alter table EmployeeSalary alter column Variable varchar(max)  null

insert into EmployeeSalary values 
(
121,'P1' ,8000,500),
(321,'P2',10000,1000),
(421,'P1',12000,0)

select * from EMployeeDetails
select * from Employeesalary

ASSINGMENT nos - 1


Q1)SQL Query to fetch records that are present in one table but not in another table.


SELECT EmployeeSalary.*
FROM EmployeeSalary
LEFT JOIN
employeedetails
on employeedetails.empid=employeesalary.empid
WHERE employeedetails.empid is null

Q2)SQL query to fetch all the employees who are not working on any project.
select fullname from EmployeeDetails where empid not in(select empid from EMployeeSalary where Project in ('p1','p2'))

Q3)SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.
select * from employeedetails where Dateofjoining between '2020-01-01' and '2020-12-31'

Q4)Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.

select * from EmployeeDetails where empid in (select empid from EMployeesalary where salary is not null)


Q5)Write an SQL query to fetch a project-wise count of employees.
select project,count(empid) as empl_count  from EmployeeSalary
group by project

Q6)Fetch employee names and salaries even if the salary value is not present for the employee.
select e.fullname,s.salary from employeedetails as e
join employeesalary s
on e.empid=s.empid
where s.salary is null


Q7)Write an SQL query to fetch all the Employees who are also managers.
select e.empid,e.fullname from employeedetails e
join employeedetails e1
on e.empid=e1.managerid

Q8)Write an SQL query to fetch duplicate records from EmployeeDetails.

select empid,fullname,count(empid) from EmployeeDetails
group by empid,fullname
having count(empid)>1

SELECT FullName, ManagerId, DateOfJoining, City, COUNT(*)
FROM EmployeeDetails
GROUP BY FullName, ManagerId, DateOfJoining, City
HAVING COUNT(*) > 1;



Q9)Write an SQL query to fetch only odd rows from the table.
with oddrows as (
select *,row_number() over (order by empid) as rownumber from employeedetails)
select * from oddrows where rownumber%2=1

SELECT * 
FROM (
    SELECT *, Row_Number() OVER(ORDER BY EmpId) AS RowNumber
    FROM EmployeeSalary
) E
WHERE E.RowNumber % 2 = 1



Q10)Write a query to find the 3rd highest salary from a table without top or limit keyword.
with salarycte as (
select *,row_number() over ( order by salary desc) as rownumber from employeesalary)
select * from salarycte where rownumber=3

SELECT Salary
FROM EmployeeSalary Emp1
WHERE 2 = ( SELECT COUNT( DISTINCT ( Emp2.Salary ) )
                FROM EmployeeSalary Emp2
                WHERE Emp2.Salary > Emp1.Salary
            )


ASSINGMENT nos - 2


Ques.1. Write an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – ‘986’.
select empid,fullname from EmployeeDetails where managerid=986


Ques.2. Write an SQL query to fetch the different projects available from the EmployeeSalary table.
select project from EMployeeSalary
group by project
SELECT DISTINCT(Project)
FROM EmployeeSalary;


Ques.3. Write an SQL query to fetch the count of employees working in project ‘P1’.
select count(empid) from EmployeeSalary
where project='p1'



Ques.4. Write an SQL query to find the maximum, minimum, and average salary of the employees.
select max(salary) as maxsal,min(salary) as minsal,avg(salary) as avgsal from  employeesalary


Ques.5. Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000.
select empid from EmployeeDetails where empid in (select empid from employeesalary where salary between 9000 and 15000)
select empid from EmployeeSalary where salary between 9000 and 15000


Ques.6. Write an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321.
select * from employeedetails where city='toronto' and managerid=321

Ques.7. Write an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321.
select * from employeedetails where city='california' or managerid=321


Ques.8. Write an SQL query to fetch all those employees who work on Projects other than P1.
select * from EMployeedetails where empid in ( select empid from employeesalary where project !='p1')

select * from employeesalary where not Project='p1'

Ques.9. Write an SQL query to display the total salary of each employee adding the Salary with Variable value.

select empid,salary,(salary+variable) as total_salary from employeesalary


Ques.10. Write an SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” and ends with any sequence of characters.

select * from employeedetails where fullname like '[a-z]hn%'

SELECT FullName
FROM EmployeeDetails
WHERE FullName LIKE '__hn%'

ASSINGMENT nos - 3


Ques.1 Write an SQL query to fetch all the EmpIds which are present in either of the tables – ‘EmployeeDetails’ and ‘EmployeeSalary’.
select empid from EmployeeDetails
union 
select empid from Employeesalary

Ques.2 Write an SQL query to fetch common records between two tables.

SELECT *
FROM EmployeeSalary
WHERE EmpId IN 
(SELECT EmpId from employeedetails)

Ques.3. Write an SQL query to fetch records that are present in one table but not in another table.

SELECT EmployeeSalary.*
FROM EmployeeSalary
LEFT JOIN
employeedetails
on employeedetails.empid=employeesalary.empid
WHERE employeedetails.empid is null


Ques.4. Write an SQL query to fetch the EmpIds that are present in both the tables –  ‘EmployeeDetails’ and ‘EmployeeSalary.
SELECT EmpId FROM 
EmployeeDetails 
where EmpId IN 
(SELECT EmpId FROM EmployeeSalary);


Ques.5. Write an SQL query to fetch the EmpIds that are present in EmployeeDetails but not in EmployeeSalary.

select empid from employeedetails where empid not in (select empid from employeesalary)

Ques.6. Write an SQL query to fetch the employee’s full names and replace the space

select replace(fullname,' ','-')
from employeedetails

Ques.7. Write an SQL query to fetch the position of a given character(s) in a field.
select charindex('h',fullname) from employeedetails

select * from employeedetails



s.8. Write an SQL query to display both the EmpId and ManagerId together.
select concat(empid,managerid) from employeedetails



Ques.9. Write a query to fetch only the first name(string before space) from the FullName column of the EmployeeDetails table.
select * from employeedetails

select substring(fullname,1,charindex(' ',fullname)) from employeedetails


Ques.10. Write an SQL query to uppercase the name of the employee and lowercase the city values.
select upper(fullname),lower(city) from employeedetails



ASSINGMENT nos - 4

Ques.1. Write an SQL query to find the count of the total occurrences of a particular character – ‘n’ in the FullName field.
SELECT
    LEN(fullname) - LEN(REPLACE(fullname, 'n', ''))
        AS occurrences_total
    FROM employeedetails
	select* from employeedetails


Ques.2. Write an SQL query to update the employee names by removing leading and trailing spaces.

select  LTRIM(RTRIM(FullName)) as newfullname from employeedetails


Ques.3. Fetch all the employees who are not working on any project.

select fullname from employeedetails where empid  in (select empid from employeesalary where project is null)



Ques.4. Write an SQL query to fetch employee names having a salary greater than or equal to 5000 and less than or equal to 10000.

select fullname from employeedetails where empid in ( select empid from employeesalary where salary between 5000 and 10000)


Ques.5. Write an SQL query to find the current date-time.

select getdate() 


Ques.6. Write an SQL query to fetch all the Employee details from the EmployeeDetails table who joined in the Year 2020.
select * from EMployeeDetails where dateofjoining between '2020-01-01' and '2020-12-31'

SELECT * FROM EmployeeDetails 
WHERE YEAR(DateOfJoining) = '2020';



Ques.7. Write an SQL query to fetch all employee records from the EmployeeDetails table who have a salary record in the EmployeeSalary table.
select * from employeedetails where exists( select * from employeesalary where employeedetails.empid=employeesalary.empid)


Ques.8. Write an SQL query to fetch the project-wise count of employees sorted by project’s count in descending order.

select project,count(empid) as count_project_emp 
from employeesalary
group by project
order by count_project_emp desc



Ques.9. Write a query to fetch employee names and salary records. Display the employee details even if the salary record is not present for the employee.
SELECT E.FullName, S.Salary 
FROM EmployeeDetails E 
LEFT JOIN 
EmployeeSalary S
ON E.EmpId = S.EmpId

Ques.10. Write an SQL query to join 3 tables.



create table employeeinfo(empid int,empfname varchar(max),emplname varchar(max),department varchar(max),
project varchar(max),address varchar(max), dob date,gender varchar(max))

create table employeeposition (empid int,empposition varchar(max),Dateofjoining date,salary int)

insert into employeeinfo values
(1,'sanjay','mehra','hr','p1','hyderabad(hyd)','1976-12-01','m'),
(2,'ananya','mishra','admin','p2','delhi(del)','1968-05-02','f'),
(3,'rohan','diwan','account','p3','mumbai(mum)','1980-01-01','m'),
(4,'sonia','kulkarni','hr','p1','hyderabad(hyd)','1992-05-02','f'),
(5,'ankit','kapoor','admin','p2','delhi(del)','1194-07-03','m')

insert into employeeposition values(
1,'manager','2022-05-01',500000),
(2,'executive','2022-05-02',75000),
(3,'manager','2022-05-01',90000),
(2,'lead','2022-05-02',85000),
(1,'executive','2022-05-01',300000)

select * from employeeinfo
select * from employeeposition

Q1)Write a query to fetch the EmpFname from the EmployeeInfo table in the upper case and use the ALIAS name as EmpName.
select upper(empfname) as empnanme from employeeinfo

Q2)Write a query to fetch the number of employees working in the department ‘HR’.
select count(*) from employeeinfo
where department='hr'


Q3)Write a query to get the current date.
select getdate()

Q4)Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table.
select left(emplname,4) from EmployeeInfo
select substring(emplname,1,4) from EmployeeInfo

Q5)Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.
select substring (address,1,len(address)-charindex(' (',address)-5) from employeeinfo
select left(address,len(address)-charindex(' (',address)-5) from employeeinfo
	
SELECT SUBSTRING(Address, 1, CHARINDEX('(',Address)) FROM EmployeeInfo;


Q6)Write a query to create a new table that consists of data and structure copied from the other table.

select * into employeeinfoclone
from employeeinfo

select * from employeeinfoclone

Q7)Write q query to find all the employees whose salary is between 50000 to 100000.
select * from employeeposition

update employeeposition set empid=4 where salary=85000
update employeeposition set empid=5 where salary=300000

select e.empfname,s.salary from employeeinfo e
 join employeeposition s
on e.empid=s.empid
where s.salary between 50000 and 100000

SELECT * FROM EmployeePosition WHERE Salary BETWEEN '50000' AND '100000';

Q8)Write a query to find the names of employees that begin with ‘S’
select empfname from employeeinfo where empfname like 's%'

Q9)Write a query to fetch top N records.

select top n * from employeeposition order by salary desc

select * from employeeposition

Q10)Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space.

select concat (empfname,' ',emplname) as fullname from employeeinfo

Q11. Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1975 and are grouped according to gender

select count(dob) from employeeinfo where dob between '1970-05-02' and '1975-12-31'
group by gender

Q12. Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order.

select * from employeeinfo 
order by emplname desc,department asc

Q13. Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.
select emplname from employeeinfo where
emplname like '%A' and len(emplname)=5


Q14. Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo tables.
select * from EmployeeInfo where empfname not in ('sanjay','sonia')

Q15. Write a query to fetch details of employees with the address as “DELHI(DEL)”.
select * from EmployeeInfo where address='delhi(del)'


Q16. Write a query to fetch all employees who also hold the managerial position.
select e.empfname,e.emplname,p.empposition from employeeinfo e
join employeeposition p on
e.empid=p.empid
where empposition='manager'


Q17. Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order.
select department,count(empid) as empcount from employeeinfo
group by department
order by empcount desc


Q18. Write a query to calculate the even and odd records from a table.
select *  from (select *,row_number() over (order by empid) as rownumber from employeeinfo  )emp
where rownumber % 2=0

select * from (select *,row_number() over (order by empid) as rownumber from employeeinfo ) emp1
where rownumber %2 =1


Q19. Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table.
select e.empfname,e.emplname,e1.dateofjoining from employeeinfo e
join employeeposition e1
on e.empid=e1.empid

SELECT * FROM EmployeeInfo E 
WHERE EXISTS 
(SELECT * FROM EmployeePosition P WHERE E.EmpId = P.EmpId);

Q20. Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table.

select *  from employeeposition
maximum salaries

select top 2* from (select * ,dense_rank() over (order by salary desc) as rownumber
from employeeposition) EMP
order by rownumber 

select top 2 * from (select * ,dense_rank() over (order by salary desc) as rownumber
from employeeposition) EMP
order by rownumber desc

SELECT DISTINCT Salary FROM EmployeePosition E1 
 WHERE 2 >= (SELECT COUNT(DISTINCT Salary) FROM EmployeePosition E2 
  WHERE E1.Salary <= E2.Salary) ORDER BY E1.Salary DESC;

  SELECT DISTINCT Salary FROM EmployeePosition E1 
 WHERE 2 >= (SELECT COUNT(DISTINCT Salary)FROM EmployeePosition E2 
  WHERE E1.Salary >= E2.Salary) ORDER BY E1.Salary DESC;

Q21. Write a query to find the Nth highest salary from the table without using TOP/limit keyword.

select top 1 salary from employeeposition where salary in 
(select distinct top n salary from employeeposition order by salary desc)
order by salary asc


Q22. Write a query to retrieve duplicate records from a table.

SELECT empfname, project, gender,  COUNT(*)
FROM Employeeinfo
GROUP BY empfname, project, gender
HAVING COUNT(*) > 1;



Q23. Write a query to retrieve the list of employees working in the same department.

select distinct e.empfname,e.department from employeeinfo e
 inner join employeeinfo e1
on e.empid=e1.empid
where e.department=e1.department
AND e.EmpID != e1.EmpID

 SELECT * FROM employeeinfo
WHERE department IN
(
  SELECT department
  FROM employeeinfo
  GROUP BY department
  HAVING COUNT(*) > 1)

  Select DISTINCT E.EmpID, E.EmpFname, E.Department 
FROM EmployeeInfo E, Employeeinfo E1 
WHERE E.Department = E1.Department AND E.EmpID != E1.EmpID;


Q24. Write a query to retrieve the last 3 records from the EmployeeInfo table.
select top 3 * from employeeinfo
order by empid desc

select * from employeeinfo e
where 3> (select count(distinct(empid)) from employeeinfo e1 where e1.empid>e.empid)

Q25. Write a query to find the third-highest salary from the EmpPosition table.
select * from (select *,row_number() over (order by salary desc) as rownumber from employeeposition) e
where rownumber =3

select e.salary from employeeposition e
where 2 = (select count(distinct(e1.salary)) from employeeposition e1 where e.salary>e1.salary)


Q26. Write a query to display the first and the last record from the EmployeeInfo table.
select * from (select *,row_number() over (order by empid) as rownumber from employeeinfo) e
where rownumber =1 or rownumber =5

SELECT * FROM EmployeeInfo WHERE EmpID = (SELECT MAX(EmpID) FROM EmployeeInfo);
SELECT * FROM EmployeeInfo WHERE EmpID = (SELECT MIN(EmpID) FROM EmployeeInfo);


Q27. Write a query to add email validation to your database
SELECT Email FROM EmployeeInfo WHERE NOT REGEXP_LIKE(Email, ‘[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}’, ‘i’) 


Q28. Write a query to retrieve Departments who have less than 2 employees working in it.
select department from employeeinfo
group by department
having count(empid) <2


Q29. Write a query to retrieve EmpPostion along with total salaries paid for each of them
select empposition,sum(salary) as total_salary from employeeposition
group by empposition


Q30. Write a query to fetch 50% records from the EmployeeInfo table.
select top 50 percent * from employeeinfo

SELECT * 
FROM EmployeeInfo WHERE
EmpID < = (SELECT COUNT(EmpID)/2 from EmployeeInfo)






















.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.







































































































































































































































































































































































































































































