
use mydatabase;
/*1.	Create the Salespeople as below screenshot. */

Create table salespeople (snum int , sname varchar(55) , city varchar(55) , comm float);
insert into salespeople values (1001 , 'peel' , 'london' , 0.12) , 
(1002 , 'serres' , 'San jose' , 0.13) , 
(1003 , 'Axelord' , 'New york' , 0.10) ,
(1004 , 'Motika' , 'london' , 0.11) ,
(1007 , 'Rafkin' , 'Barcelona' , 0.15);

/* 2. Create the Cust Table as below Screenshot. */

Create table Custtable (cnum int , cname varchar(55) , city varchar(55) , Rating int, snum int);
insert into Custtable values (2001 , 'Hoffman' , 'london' , 100 , 1001) ,
(2002 , 'Giovanne' , 'Rome' , 200 , 1003) ,
(2003 , 'Liu' , 'San jose' , 300 , 1002) ,
(2004 , 'Grass' , 'Berlin' , 100 , 1002) ,
(2006 , 'Clemens' , 'london' , 300 , 1007) ,
(2007 , 'Pereira' , 'Rome' , 100 , 1004) ,
(2008 , 'James' , 'london' , 200 , 1007);

/*3.	Create orders table as below screenshot. */
Create table Ordertable (onum int , amt float, odate date , cnum int , snum int);
insert into Ordertable values ( 3001 , 18.69 , '1994-10-03' , 2008 , 1007),
( 3002 , 1900.10 , '1994-10-03' , 2007 , 1004),
( 3003 , 767.19, '1994-10-03' , 2001 , 1001),
( 3005 , 5160.45 , '1994-10-03' , 2003 , 1002),
( 3006 , 1098.16 , '1994-10-04' , 2008 , 1007),
( 3007 , 75.75 , '1994-10-05' , 2004 , 1002),
( 3008 , 4723.00 , '1994-10-05' , 2006 , 1001),
( 3009 , 1713.23 , '1994-10-04' , 2002 , 1003),
( 3010 , 1309.95 , '1994-10-06' , 2004 , 1002),
( 3011 , 9891.88 , '1994-10-06' , 2006 , 1001);

/* 4.	Write a query to match the salespeople to the customers according to the city they are living. */
select sname , cname  from salespeople s join custtable c on s.city = c.city;

/* 5	Write a query to select the names of customers and the salespersons who are providing service to them. */
select cname , sname  from custtable c join salespeople s on c.city = s.city;

/* 6.	Write a query to find out all orders by customers not located in the same cities as that of their salespeople. */
select cname , sname  from custtable c join salespeople s on c.city != s.city;

/* 7.   Write a query that lists each order number followed by name of customer who made that order. */
select onum , cname from ordertable o join custtable c on o.cnum = c.cnum;	


/*8. Write a query that finds all pairs of customers having the same rating. */

select sname, s.snum , count(rating) as count from salespeople s join  custtable c on s.snum = c.snum  group by rating having count(rating) >1;

/* 9.	Write a query to find out all pairs of customers served by a single salesperson. */

SELECT c1.cname AS customer1, c2.cname AS customer2, s.sname AS salesperson
FROM custtable c1
JOIN custtable c2 ON c1.snum = c2.snum AND c1.cname < c2.cname
JOIN salespeople s ON c1.snum = s.snum;

/*10.	Write a query that produces all pairs of salespeople who are living in same city*/
SELECT s1.sname,s2.sname,s1.city, s1.snum AS salespersonid, s2.snum AS salespersonid2
FROM salespeople s1
JOIN salespeople s2 ON s1.city = s2.city AND s1.snum < s2.snum;

/*11.	Write a Query to find all orders credited to the same salesperson who services Customer 2008*/

select c.cname , o.onum , o.amt from ordertable o join custtable c on c.snum = o.snum where c.cnum = 2008;

/*12.	Write a Query to find out all orders that are greater than the average for Oct 4th*/

select onum , amt as order_amount from ordertable where amt > (select avg(amt) from ordertable);
select avg(amt) as average_amount from ordertable;

/*13.	Write a Query to find all orders attributed to salespeople in London.*/ 

select o.onum ,  s.sname , s.city from ordertable o join salespeople s where s.city = 'london' ;

/*14.	Write a query to find all the customers whose cnum is 1000 above the snum of Serres*/
SELECT c.cname
FROM custtable c
JOIN salespeople s ON s.snum = c.snum
WHERE c.cnum > (SELECT snum FROM salespeople WHERE sname = 'Serres') + 1000;

/*15.	Write a query to count customers with ratings above San Jose’s average rating*/
select * from custtable;
select * from salespeople;

SELECT c.cname, COUNT(c.cname) AS customer_count, c.rating
FROM custtable c
JOIN salespeople s ON c.snum = s.snum
WHERE c.rating > (
  SELECT AVG(custtable.rating)
  FROM custtable
  JOIN salespeople ON custtable.snum = salespeople.snum
  WHERE salespeople.city = 'San Jose'
)
GROUP BY c.cname, c.rating;

/*16.	Write a query to show each salesperson with multiple customers.*/

SELECT s.sname AS salesperson, COUNT(c.cname) AS customer_count
FROM salespeople s
JOIN custtable c ON s.snum = c.snum
GROUP BY s.sname
HAVING COUNT(c.cname) > 0;
























