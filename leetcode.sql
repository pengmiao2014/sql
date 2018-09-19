-- mysql

-- 顺序：
-- from
-- (on) join
-- where 
-- group by (可以用别名了）
-- ave,sum...
-- having
-- select
-- distinct 
-- order by 
-- limit 
   
UPDATE salary
    SET sex  = (CASE WHEN sex = 'm' 
        THEN  'f' 
        ELSE 'm' 
        END)

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
;        
        
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


        
