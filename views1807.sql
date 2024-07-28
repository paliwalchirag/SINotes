
set search_path to hrdb,public;

create view v_employee_department as select first_name,last_name,phone_number,d.department_name
from employees e join departments d on e.department_id=d.department_id;

drop view v_employee_department;
select * from v_employee_department;

--display employee name,phone number,and department name for employees who belong to the 
-- shipping department
select first_name ,phone_number,department_name from v_employee_department
	where department_name='Shipping';

--create view to display employee name,phone number,and department name,
--adrres ,country and region
create view v_employee_country as select e.first_name,e.last_name,e.phone_number,
	d.department_name, c.country_name,r.region_name,l.street_address 
	from employees e 
	join departments d on d.department_id=e.department_id 
	join locations l on l.location_id = d.location_id 
	join countries c on c.country_id=l.country_id
	join regions r on r.region_id =c.region_id;

select * from v_employee_country;

----create a view named IT_Employees that display only employees from IT department from the
--Works ON along with the project details

create view it_emp as
	select first_name,last_name ,project_name, works_on.project_no,budget,job,department_name 
	from employees 
	join works_on
	on employees.employee_id = works_on.emp_no
	join departments
	on employees.department_id = departments.department_id
	join project
	on works_on.project_no = project.project_no
	where departments.department_name ilike 'it'


select * from it_emp;
select * from jobs;
select * from works_on;
select * from project;
select * from employees;
create view v_it_employees select as d.department_name 

--create a view to display the project_no and count of employee working on that project
create view project_det
 as select p.project_name , count(emp_no) as cnt
	from WORKS_ON w 
	right join project p
	on p.project_no = w.project_no
	group by p.project_name ;

create view v_count(project_no, emp_count)
as select PROJECT_NO, count(*) from WORKS_ON group by PROJECT_NO
	
select * from v_count;


CREATE TABLE person (pid int primary key , pname varchar(20), age int);
	 	  insert into person values (1,'Vivian' , 65);
		   insert into person values (2,'Alice' , 60);
		   insert into person values (3,'Bob' , 25);
		   insert into person values (4,'Joe' , 30);
		    insert into person values (5,'Joe' , 55);

create view v_person as select * from person;

insert into v_person values(6,'rita',32);
select * from person;
update v_person set age=35 where pname='rita';
delete from v_person where pname='rita';


create table roles (role_id int primary key, name varchar(20),
pid int references person (pid));
insert into roles values (1, 'Admin', 1);
insert into roles values (2, 'Manager' ,2);
insert into roles values (3, 'Developer', 3);
insert into roles values (4, 'Tester', 4);
insert into roles values (5, 'ff');

create view v_person_roles as select p.pid , pname,  p.age, r.role_id, r.name
	from person p,
roles r where p.pid= r.pid

select * from v_person_roles;

select p.pid ,pname ,p.age, r.role_id, r.name from person p 
	FULL OUTER JOIN roles r on p.pid = r.pid

insert into v_person_roles values(8,'lara',99);



