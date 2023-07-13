create database mydatabase;
use mydatabase;
create table employee (empno int primary key , empname varchar(50) , job varchar(50) , mgr int, hire_date date , salary int , comm int , depno int);
select * from employee;
insert into employee (empno , empname , job , mgr, hire_date , salary , comm , depno ) values (7369,'smith','clerk',7902,'1890-12-17',800, null , 20);
insert into employee (empno , empname , job , mgr, hire_date , salary , comm , depno ) values 
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600, 300 , 30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250, 500 , 30),
(7566,'JOHNES','MANAGER',7839,'1981-04-02',2975, 500 , 30),
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250, 1400 , 30),
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850, NULL , 30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450, NULL , 10),
(7788,'SCOTT','ANALYST',7566,'1987-04-19',3000, NULL , 20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000, NULL , 10),
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500, 0 , 30),
(7876,'ADAMS','CLERK',7788,'1987-05-23',1100, NULL , 20),
(7900,'JAMES','CLERK',7698,'1981-12-03',950, NULL , 30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000, NULL , 20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300, NULL , 10);

create table dept (depno int unique , dname varchar(50) , loc varchar(50));
insert into dept (depno , dname, loc) values (10,'operations','boston'),(20,'reasearch','dallas'),(30,'sales','chicago'),(40,'accounting','new york');
select * from dept;

select * from employee;
/* 3.	List the Names and salary of the employee whose salary is greater than 1000*/
select empname , salary from employee where salary > 1000 ;

/*4.	List the details of the employees who have joined before end of September 81.*/

select empname,hire_date from employee where hire_date <= '1981-09-30';

/*5.	List Employee Names having I as second character.*/
select empname from employee where substring(empname,2,1) = 'I';

/*6.	List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns*/
select empname as name, 
salary as 'sal' ,
salary * 0.4 as 'allowances' ,
salary * 0.1 as 'PF' , 
(salary + Salary*0.4 - salary * 0.1) as 'netsalary'
 from employee;
 
 /*7.	  List Employee Names with designations who does not report to anybody*/
 select empname ,mgr from employee where mgr is null;
 
 /*8.	List Empno, Ename and Salary in the ascending order of salary.*/
 select empno , empname , salary from employee order by salary asc;
 
 /*9.	How many jobs are available in the Organization ?*/
 select count(empname) as total_jobs from employee;
 
 /*10.	Determine total payable salary of salesman category*/
 select empname, job , salary as payable_salary from employee  where job = 'SALESMAN' order by salary ;
 
 /*11.	List average monthly salary for each job within each department */
 select job, avg(salary) as average_salary from employee group by job;
 
 /*12.	Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.*/
 select empname,depno,salary from employee order by depno asc;
select e.empname , e.depno,e.salary from employee e join dept d on e.depno = d.depno ;

/*13.Create the Job Grades Table as below*/

CREATE TABLE job_grades (
    grade CHAR(1),
    min_salary int,
    max_salary int);

INSERT INTO job_grades (grade, min_salary, max_salary)
VALUES
    ('A', 0, 999),
    ('B', 1000, 1999),
    ('C', 2000.00, 2999),
    ('D', 3000, 3999),
	('E', 4000, 5000);
    
    select * from job_grades;
    
    /*14.	Display the last name, salary and  Corresponding Grade.*/
    
select e.empname,e.salary,g.grade from employee e join job_grades g on e.salary between g.min_salary and g.max_salary; 


/*15.	Display the Emp name and the Manager name under whom the Employee works in the below format .*/
select e.empno, m.empno as manager from employee e join employee m on e.empno = m.empno;
select empno,mgr from employee ;

/*16.	Display Empname and Total sal where Total Sal (sal + Comm)*/
select empname , (salary+comm) as total_salary from employee where (salary+comm) is not null;

/*17.	Display Empname and Sal whose empno is a odd number*/
select empname , salary from employee where empno%2=1;
select empname , salary from employee where empno%2=0;

/*18.	Display Empname , Rank of sal in Organisation , Rank of Sal in their department*/
select empname, rank() over (order by salary desc) as rankemp, rank() over (partition by depno order by salary desc) from employee;


/*19.	Display Top 3 Empnames based on their Salary*/
select empname,salary from employee order by salary desc limit 3 ;


/* 20.Display Empname who has highest Salary in Each Department.*/
select empname,salary from employee where salary = (select max(salary) from employee);
