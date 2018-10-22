-- mysql

-- 顺序：
-- from
-- (on) join
-- where 
-- group by (可以用别名了）
-- avg,sum...
-- having
-- select
-- distinct 
-- order by 
-- limit 

--avg!!!!!

date:
postgresql: 

to_char(pay_date,'yyyy-mm')

(NOW() + interval '1 hour') AS an_hour_later

datefiff:
age(date(entrant_date),date(convertion_date))
0 years 0 mons 17 days 0 hours 0 mins 0.00 secs 

date_part('day',time) = extract ('day'  from time)
                            
date_part('day',age('2010-04-01', '2012-03-05'))
26
                                 
-- CENTURY	The century	The number of centuries
-- DAY	The day of the month (1-31)	The number of days
-- DECADE	The decade that is the year divided by 10	Sames as TIMESTAMP
-- DOW	The day of week Sunday (0) to Saturday (6)	N/A
-- DOY	The day of year that ranges from 1 to 366	N/A
-- EPOCH	The number of seconds since 1970-01-01 00:00:00 UTC	The total number of seconds in the interval
-- HOUR	The hour (0-23)	The number of hours
-- ISODOW	Day of week based on ISO 8601 Monday (1) to Saturday (7)	N/A
-- ISOYEAR	ISO 8601 week number of year	N/A
-- MICROSECONDS	The seconds field, including fractional parts, multiplied by 1000000	Sames as TIMESTAMP
-- MILLENNIUM	The millennium	The number of millennium
-- MILLISECONDS	The seconds field, including fractional parts, multiplied by 1000	Sames as TIMESTAMP
-- MINUTE	The minute (0-59)	The number of minutes
-- MONTH	Month, 1-12	The number of months, modulo (0-11)
-- QUARTER	Quarter of the year	The number of quarters
-- SECOND	The second	The number of seconds
-- TIMEZONE	The timezone offset from UTC, measured in seconds	N/A
-- TIMEZONE_HOUR	The hour component of the time zone offset	N/A
-- TIMEZONE_MINUTE	The minute component of the time zone offset	N/A
-- WEEK	The number of the ISO 8601 week-numbering week of the year	N/A
-- YEAR	The year	

cte:
WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)  
AS  
(  
    SELECT ….
)  

running sum:
SUM (StudentAge) OVER (ORDER BY Id) AS RunningAgeTotal
SUM (StudentAge) OVER (PARTITION BY StudentGender ORDER BY Id) AS RunningAgeTotal

round(population*100.0/sum(population) over (partition by continent),2)  as percentage
round(sum(case when Status like 'cancelled_%' then 1.0 else 0.0 end)/count(t.Id),2) as 'Cancellation Rate'

 AVG (price) OVER (PARTITION BY group_name)
 ROW_NUMBER () OVER (PARTITION BY group_name ORDER BY price)

                  
count, sum, avg 等不会加入null

mysql: 
date_format(pay_date, '%Y-%m')

join two tables, set different name for same col in two derived tables:

-- 615. Average Salary: Departments VS Company
select  b.pay_month1 as pay_month,  
        b. department_id,
        case when dep_mon_ave>mon_ave then 'higher'
            when dep_mon_ave=mon_ave then 'same'
            when dep_mon_ave<mon_ave then 'lower'
            end as comparison           
from (
    select *
    from 
        (select date_format(pay_date, '%Y-%m') as pay_month1, department_id, avg(amount) as dep_mon_ave
        from salary s 
        join employee e 
            on s.employee_id=e.employee_id
        group by 1,2)t
    join 
        (select date_format(pay_date, '%Y-%m') as pay_month2, avg(amount) as mon_ave
        from salary
        group by  1)a 
        on t.pay_month1=a.pay_month2
    )b
order by 2,1


UPDATE salary
    SET sex  = (CASE WHEN sex = 'm' 
        THEN  'f' 
        ELSE 'm' 
        END)
--pivot table
SUM(CASE WHEN year = 'FR' THEN players ELSE NULL END) AS fr,
       SUM(CASE WHEN year = 'SO' THEN players ELSE NULL END) AS so,
       SUM(CASE WHEN year = 'JR' THEN players ELSE NULL END) AS jr,
       SUM(CASE WHEN year = 'SR' THEN players ELSE NULL END) AS sr
       
-- 601. Human Traffic of Stadium
-- # with temp_table as (
-- # select s1.id as id1,s2.id as id2, s3.id as id3 
-- # from stadium s1
-- # join stadium s2 on datediff(s1.date, s2.date)=-1 
-- # join stadium s3 on datediff(s2.date, s3.date)=-1 
-- # where s1.people >=100 and s2.people >=100 and s3.people >=100 );
    

select * from
stadium
where id in (
select id1 as id
from (select s1.id as id1,s2.id as id2, s3.id as id3 
from stadium s1
join stadium s2 on s1.id+1=s2.id
join stadium s3 on s2.id+1=s3.id
where s1.people >=100 and s2.people >=100 and s3.people >=100) a1
union 
select id2 as id
from (select s1.id as id1,s2.id as id2, s3.id as id3 
from stadium s1
join stadium s2 on s1.id+1=s2.id
join stadium s3 on s2.id+1=s3.id 
where s1.people >=100 and s2.people >=100 and s3.people >=100) a2
union
select id3 as id
from (select s1.id as id1,s2.id as id2, s3.id as id3 
from stadium s1
join stadium s2 on s1.id+1=s2.id
join stadium s3 on s2.id+1=s3.id
where s1.people >=100 and s2.people >=100 and s3.people >=100)a3)
    
-- 184. Department Highest Salary

SELECT
    Department.name AS 'Department',
    Employee.name AS 'Employee',
    Salary
FROM
    Employee
        JOIN
    Department ON Employee.DepartmentId = Department.Id
WHERE
    (Employee.DepartmentId , Salary) IN
    (   SELECT
            DepartmentId, MAX(Salary)
        FROM
            Employee
        GROUP BY DepartmentId
    )
-- 262. Trips and Users
select 
    t.Request_at as Day
    , round(sum(case when Status like 'cancelled_%' then 1.0 else 0.0 end)/count(t.Id),2) as 'Cancellation Rate'
from 
    Trips t
join 
    Users u1 on t.Client_Id=u1.Users_Id
join 
    Users u2 on t.Driver_Id=u2.Users_Id
where  
    u1.Banned='No' 
    and u2.Banned='No' 
    and t.Request_at between '2013-10-01' and '2013-10-03'
group by 1

-- 177. Nth Highest Salary  ---if not exsit will return null!!
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
DECLARE M INT;
SET M=N-1;
  RETURN (   
      select distinct Salary 
      from Employee
      order by Salary desc
      limit 1 offset m       
  );
END
        
select name
from customer
where referee_id!=2 or referee_id is null


select customer_number
from orders
group by customer_number
order by count(*) desc
limit 1


select e1.Name as Employee
from Employee e1
left join Employee e2
on e1.ManagerId=e2.Id
where e1.Salary>e2.Salary


-- group by 中column可以不出现在select 中
SELECT c.Name as Customers
from Customers c
left join Orders o on c.Id=o.CustomerId
where o.Id is NULL
group by c.Id


        
