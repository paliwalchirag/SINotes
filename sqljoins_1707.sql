--sql joins 
set search_path to HRDB,public 
show search_path

select e.first_name, e.last_name, d.department_name from employees e join 
	departments d on e.department_id = d.department_id;

--here we do the same thing without joins but we should use joins its better and clear
select e.first_name, e.last_name, d.department_name from employees e ,departments d 
	where e.department_id= d.department_id;

--display susan's (first_name) details along with department details
select * from employees e join departments d on e.department_id = d.department_id where 
	e.first_name ilike 'susan';

select e.first_name, e.last_name, d.department_name, l.city from employees e 
join departments d on e.department_id=d.department_id 
	join locations l on d.location_id=l.location_id;

--display the first name ,last name separated by '.'as full name along with the address(location) and city
select concat(e.first_name ,'.',e.last_name) as "full name",
concat(l.*) as address from employees e join departments d on e.department_id=d.department_id
join locations l on d.location_id = l.location_id;

--display the employees name ,address,country and region
select concat(e.first_name ,'.',e.last_name) as "full name",
concat(l.*) as address , c.country_name as country_name ,r.region_name as regions
from employees e join departments d on e.department_id =d.department_id
join locations l on d.location_id = l.location_id 
join countries c on l.country_id = c.country_id
join regions r on c.region_id=r.region_id;

--disply the fn,ln,dn of the employees from purchasing depa
select e.first_name, e.last_name, d.department_name from employees e join 
	departments d on e.department_id = d.department_id where d.department_name='Purchasing';

--display the total count of employes from purchasing department 
select count(employee_id) from employees e join departments d 
on e.department_id=d.department_id 
where d.department_name ='Purchasing';

--display the fn and depaname of employe from depar
--Administration ,Sales and Marketing
select e.first_name, e.last_name, d.department_name from employees e join 
	departments d on e.department_id = d.department_id
	where d.department_name in('Administration','Sales','Marketing'); 

--find all the employe who work in the region europ
SELECT e.first_name, r.region_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
JOIN regions r ON c.region_id = r.region_id
WHERE r.region_name = 'Europe';


-- find the average salary of employee in the department with the department name ='Sales'
SELECT Round (AVG (salary), 2) AS average_salary FROM employees e
JOIN departments d ON e.department_id= d.department_id
WHERE d.department_name = 'Sales';

select round(avg(salary), 2) from employees 
	where department_id = (select department_id from departments where department_name ilike 'sales');

--display avg salary of all the employe
select avg(salary) from employees;

--display the avg salary for each departmnent
select department_id, avg(salary) from employees group by department_id;
--round higher karke dega ceil
select department_id, CEIL(avg(salary)) from employees group by department_id;
select department_id, FLOOR(avg(salary)) from employees group by department_id;

--display the number of employees in each department along with the department id ;
select count(employee_id),department_id from employees group by department_id;
select count(employee_id),department_id from employees group by department_id order by count(employee_id);

--display the dep_id which has the highest number of employees
select count(employee_id), d.department_name from employees e 
join departments d on e.department_id = d.department_id
group by department_name order by count(employee_id) desc limit 1;

--display the name and the salary of the employee who gets the highest pay
select first_name,salary from employees where salary=(select max(salary) from employees);

--find the department name where the average salary is 
--less than the total avarage salary of all the departments
select d.department_name from departments d
join employees e on d.department_id = e.department_id
group by d.department_name
having avg(e.salary) < (select avg(salary) from employees);

SELECT d.department_name, Round(avg(e.salary),4)
FROM departments d JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name order by Round(avg(e.salary),4)

--Find the names of employees who have the highest salary in their respective department:
Select first_name from employees e join departments d join where  max (salary), department_id
from employees group by department_id order by department_id

--find the name of the employee along with their job title 
select e.first_name , j.job_title from employees e join jobs j on e.job_id =j.job_id ;

--display all employees name along with the number of dependents
select count(*) employee_id from dependents group by employee_id;
SELECT e.first_name, e.last_name, COUNT (d.dependent_id) AS num_dependents FROM employees e
LEFT JOIN dependents d ON e.employee_id= d.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;


--display the employee name along with their dependents name if only id they have dependences
SELECT e.first_name, e.last_name, COUNT(d.dependent_id) as num_dependents
	FROM employees e
Right JOIN dependents d ON e.employee_id= d.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;

--find the department name and the number of employees in each department 
select department_name, count(employee_id) as no_of_employee
from departments d
join employees e on d.department_id=e.department_id
group by department_name order by count(employee_id);

--display the employee_id ,first_name along their manager_id and manager_name
select e.employee_id, e.first_name, e.manager_id from employees  e 
	left join employees m on e.manager_id = m.employee_id;

--display the Top level employee (MD) from the employee list
select first_name, manager_id from employees where manager_id is NULL;

--Find all employees and their respective managers (if they have one),
--display their full Name (first_name and last_name)
SELECT e.employee_id,concat(e.first_name, ',',e.last_name) as "FullName",
concat(m.first_name,',', m.last_name) AS "Manger Name" FROM employees e 
LEFT JOIN employees m ON e.manager_id = m.employee_id;


--Write a query to find the top 3 regions with the highest number of countries.
--Display the region_id, region_name, and the number of countries.
SELECT r.region_id, r.region_name, COUNT(c.country_id) AS country_count FROM regions r
LEFT JOIN countries c ON r.region_id = c.region_id
GROUP BY r.region_id, r.region_name
ORDER BY country_count DESC
LIMIT 3;

--- Find the department names with at least two employees I
--earning more than the department's average salary:
SELECT d.department_name
FROM departments d
WHERE (
SELECT COUNT(*)
FROM employees e
WHERE e.department_id = d.department_id AND e.salary > (
SELECT AVG(salary)
FROM employees e2
WHERE e2.department_id= d.department_id)
) >= 2;

--sub query with multiple levels of nesting
--Get full details of all employees whose department is located in Dallas.


create table employee_details  as select * from employees;

alter table  employee_details   alter column email TYPE varchar(40) ;

	update employee_details set email=null where first_name='Shelley'
	update employee_details set email=null where first_name='Charles'


--display first_name with email if email is not avialble get phone_number else display
--"M"
--name the column as "Contact Details"
select first_name, coalesce (email, phone_number, 'Not Available') as "Address" from employee_details;
--List departments with the highest-paid employee in each department:
SELECT d.department_name, e.first_name, e.last_name, e.salary, e.department_id FROM departments d
JOIN employees e ON d.department_id = e.department_id
WHERE e.salary = (
SELECT MAX(e2.salary) I
FROM employees e2
WHERE e2.department_id = d.department_id
);


-----------------------------------------------



CREATE TABLE PROJECT (PROJECT_NO CHAR(4) ,PROJECT_NAME CHAR(15) NOT NULL, BUDGET FLOAT NULL,
CONSTRAINT PK_PROJ PRIMARY KEY (PROJECT_NO));

CREATE TABLE WORKS_ON (EMP_NO INT, PROJECT_NO CHAR(4), JOB CHAR(15) NULL, ENTER_DATE DATE NULL,
 CONSTRAINT PK_WORKS PRIMARY KEY (EMP_NO,PROJECT_NO),
 CONSTRAINT FK1_WORKS FOREIGN KEY (EMP_NO) REFERENCES employees(employee_id) ON DELETE CASCADE,
 CONSTRAINT FK2_WORKS FOREIGN KEY (PROJECT_NO) REFERENCES PROJECT(PROJECT_NO) ON UPDATE CASCADE)

INSERT INTO PROJECT values ('P1', 'Apollo', 95000.00);
  INSERT INTO PROJECT values ('P2', 'Gemini', 100000.00);
   INSERT INTO PROJECT values ('P3', 'Mercury', 150000.00);

    insert into  WORKS_ON values( 108,'P1', 'Finance Manager','1995-10-12');
   insert into  WORKS_ON values( 118,'P1', 'Clerk','1999-11-12');
 insert into  WORKS_ON values( 118,'P2', 'Clerk','2000-11-12');
		 insert into  WORKS_ON values( 206,'P1', 'Manager','1995-11-12');
		  insert into  WORKS_ON values( 103,'P1', 'PROGRAMMER','1990-03-03');
		   insert into  WORKS_ON values( 103,'P2', 'PROGRAMMER','1990-05-06');
		      insert into  WORKS_ON values( 104,'P2', 'PROGRAMMER','1990-05-06')  ;

select * from project;
select * from works_on;

SELECT E.FIRST_NAME FROM EMPLOYEES E WHERE 'P2' IN
(SELECT PROJECT_NO FROM WORKS_ON W WHERE W.EMP_NO = E.employee_id);

--This correlated subquery compares each employee's salary with the average salary in their r
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.salary > (
SELECT AVG(e2.salary)
FROM employees e2
WHERE e2.department_id = e.department_id
);

--select first_name ,salary ,'increment salary ' for empoyee
--if the salary incremented by 5%
select first_name, salary, salary+(salary * 0.5) as incremented_salary from employees;

CREATE TABLE library.tags (
    pk integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tag text NOT NULL,
    parent integer
);

insert into library.tags (tag) values ('Database'),('Operating Systems');

select tag from library.tags;
select title from library.categories;
select tag as datalist from library.tags UNION select title as datalist from library.categories;
select * from posts
--cross join
select c.pk ,c.title,p.pk,p.category, p.title from library.categories c, library.posts p;
--inner join
--filter all the rows that have the same value as the category field (category.pk posts.ca
select c.pk,c.title,p.pk,p.category,p.title 
from library.categories c, library.posts p where c.pk=p.category;

--it can be written in an other way
select c.pk,c.title,p.pk,p.category, p.title from library.categories c
inner join library.posts p on c.pk=p.category;

--INNER JOIN versus EXISTS/In
--search for all posts that belong to the Database category using the INNER JOIN condition
--search for all posts that belong to the Database category using the INNER JOIN condition
select c.pk,c.title,p.pk,p.category, p.title from library.categories c
inner join library.posts p on c.pk=p.category where c.title='Database';

--LEFT JOINS
select c.*,p.category,p.title from library.categories c left join library.posts p on c.pk=p.category;
--This query returns all records of the categories table and
--returns the matched records from the posts table.
--Using RIGHT JOIN
select c.*,p.category,p.title from library.posts p right join library.categories c on c.pk=p.category;
--Full outer join
-- FULL OUTER JOIN is the combination of what we would have if we put together the right join and the left join.
-- join and the left join 

create temp table new_posts as select * from library.posts; 
SELECT 3
select c.pk,c.title,p.pk,p.title from library.categories c inner 
	join new_posts p on p.category=c.pk

	
--To have the left and right joins between the new_posts and category tables,
	--we'd have to use the full outer join and write the following 
	select c.pk,c.title,p.pk,p.title from library.categories c full
outer join new_posts p on p.category=c.pk;

--Using LATERAL JOIN
--A lateral join is a type of join in SQL that allows you to join a table with a subquery,
--where the subquery is run for each row of the main table. The subquery is executed
--before joining the rows and the result is used to join the rows. With this join mode,
--you can use information from one table to filter or process data from another table

          
alter table library.posts add likes integer default 0; 
select title, likes from library.posts order by likes;

--to search for all users that have posts with likes greater than 2; 
 select u.* from library.users u where exists (select 1 from library.posts p 
where u.pk=p.author and likes > 2 ) ;

--suppose now that we want the value of the likes field too
select u.username,q.* from library.users u join lateral (select author, 
title,likes from library.posts p where u.pk=p.author and likes > 2 ) as q on true;

--UNION/UNION ALL 
--The UNION operator is used to combine the resultset of two or more SELECT statements.
--• Each SELECT statement within UNION must have the same number of columns.
--• The columns must have similar data types.
--• The columns in each SELECT statement must be in the same order.
insert into library.tags (tag) values ('Database'),('Operating Systems');
select tag  from library.tags ;
select title from library.categories ;
select tag as datalist from library.tags UNION select title as datalist from library.categories;

--EXCEPT/INTERSECT
-- The EXCEPT want to operator returns rows by comparing the resultsets of two or more queries. 
-- The EXCEPT operator returns distinct rows from the first (left) query that is not in the output of 
-- the second (right) query. Similar to the UNION operator, the EXCEPT operator can also compare 
-- queries that have the same number and the same datatype of fields

select title as datalist from library.categories except select tag as 
datalist from library.tags order by 1

--The INTERSECT operator performs the reverse operation. It searches for all the records present in 
--the first table that are also present in the second table:
 select title as datalist from library.categories intersect select tag as 
datalist from library.tags order by 1;


--Using UPSERT
--An UPSERT statement is used when we want to insert a new record on top of the existing record or update an existing 
--record. To do this in PostgreSQL, we can use the ON CONFLICT keyword:


	CREATE TABLE library.posts_tags (
    tag_pk integer NOT NULL,
    post_pk integer NOT NULL
);

alter table library.posts_tags add constraint posts_tags_pkey primary key (tag_pk,post_pk);

insert into library.posts_tags (post_pk ,tag_pk) values (7,3),(5,3),(6,3);
select * from library.posts_tags ;
insert into library.posts_tags (post_pk ,tag_pk) values (5,3);
insert into library.posts_tags (post_pk ,tag_pk) values (5,3) ON CONFLICT DO NOTHING;

---MERGE

create temp table new_data as select * from library.categories limit 0;
insert into new_data (pk,title,description) values (1,'Database Discussions','Database discussions'),(2,'Unix/Linux discussion','Unix and Linux discussions');


select * from categories ;
select * from new_data;
merge into library.categories c
using new_data n on c.pk=n.pk
when matched then
  update set title=n.title,description=n.description
when not matched then
  insert (pk,title,description)
  OVERRIDING SYSTEM VALUE values (n.pk,n.title,n.description);












