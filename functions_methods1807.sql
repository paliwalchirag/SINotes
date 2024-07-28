--functions 

create or replace function my_sum(x integer,y integer) returns integer as 
$$
select x+y;
$$
language sql;

----To execute a function call select follwed by function name and pass parameters 
select my_sum(1,2) as "SUM";

set search_path to
	
CREATE OR REPLACE FUNCTION delete_person(title text) returns setof integer as 
$$
	delete from person where pname=title returning pid;
$$
LANGUAGE SQL;
select delete_person('Dia');

insert into person values(7,'Dia',60);
insert into person values(8,'Dia',60);

select * from project;
--write a function that accept the project_id and increment amount and return the 
--updated budget value 
create or replace function salaryraise(project_id character,y integer) returns setof integer as
$$
update project set budget = (budget + (budget*y*00.1)) where project_no=project_id
returning budget;
$$
language sql;

select salaryraise('P1',4);

create table dup_posts as select pk, title from library.posts;
insert into dup_posts (pk, title) values (5, 'CSharp Programming');
select * from dup_posts;

create or replace function delete_posts_table (p_title text) 
	returns table (ret_key integer, ret_title text) AS 
	$$
		delete from dup_posts where title=p_title returning pk,title;
	$$
language SQL;

select delete_posts_table('CSharp Programming');

--Polymorphic SQL functions
--Polymorphic functions are useful for DBAs when we need to write a function
--that has to work with different types of data.

create or replace function nvl (anyelement, anyelement) returns
anyelement as
$$
select coalesce ($1,$2);
$$
language SQL;

select nvl(null :: int ,1 :: int);
select nvl(''::text, 'n':: text);
select nvl('a'::text, 'n':: text);

--pl/psql
--It is very similar to Oracle PL/SQL and supports the following:
--• Variable declarations
--• Expressions
--• Control structures as conditional structures or loop structures

CREATE OR REPLACE FUNCTION my_sum2(x integer, y integer) RETURNS
integer AS
$BODY$
DECLARE
	--here we delcrale variable
ret integer;
BEGIN
	--here we delacre counstructor,function logic
ret := x+y;
return ret;
END;
$BODY$
language 'plpgsql';

select my_sum2(32,33);

--find the avrage budget if the project budget is less than the 
--average increment that budget

CREATE OR REPLACE FUNCTION my_sum_3_params (IN x integer, IN y integer, OUT z integer) AS
$BODY$
BEGIN
z:= x+y;
END;
$BODY$
language 'plpgsql';
select my_sum_3_params(2,3);


CREATE OR REPLACE FUNCTION my_check(x integer default 0, y integer default 0) RETURNS text AS 
$BODY$
BEGIN
IF x > y THEN
return 'first parameter is higher than second parameter';
ELSIF x < y THEN
return 'second paramater is higher than first parameter';
ELSE
return 'the 2 parameters are equals';
END IF;
END;
$BODY$
language 'plpgsql';

select my_check(3);
select my_check(9,3);

CREATE OR REPLACE FUNCTION my_check2(x integer default 0, y integer default 0) RETURNS text AS 
$BODY$
BEGIN
	case
	when x > y then return 'first parameter is higher than second parameter';     
	when x < y THEN return 'second paramater is higher than first parameter';
ELSE
return 'the 2 parameters are equals';
END CASE;
END;
$BODY$
language 'plpgsql';

create extension hstore;
create type my_ret_type as (
	id integer,
	title text,
	record_data hstore --hstore mean storing data in key value pair
	);
select 'a=>2,a=>2'::hstore;
select 'a=>2,b=>2'::hstore;

CREATE OR REPLACE FUNCTION my_first_fun (p_id integer) returns setof my_ret_type as
$$
DECLARE
 rw library.posts%ROWTYPE; -- declare a rowtype;
 ret my_ret_type;
BEGIN
    for rw in select * from library.posts where pk=p_id loop
      ret.id := rw.pk;
      ret.title := rw.title;
      ret.record_data := hstore(ARRAY['title',rw.title,'Title and Content'
                         ,format('%s %s',rw.title,rw.content)]);
     return next ret;
     end loop;
 return;
END;
$$
language 'plpgsql';

select my_first_fun(1);

CREATE OR REPLACE FUNCTION my_first_except (x real, y real ) returns real as 
$$
DECLARE
 ret real;
BEGIN
 ret := x / y;
 return ret;
END;
$$
language 'plpgsql';

select my_first_except(4,2);
select my_first_except(4,0);

--exception handling 
CREATE OR REPLACE FUNCTION my_second_except1 (x real, y real ) returns real as 
$$
DECLARE
  ret real;
BEGIN
  ret := x / y;
  return ret;
EXCEPTION
	--if we dont know the error type write error 
  WHEN division_by_zero THEN 
     RAISE INFO 'DIVISION BY ZERO';
     RAISE INFO 'Error % %', SQLSTATE, SQLERRM;
    -- RETURN 0;
END;
$$
language 'plpgsql' ;

select my_second_except1(4,0);


--roles and users
-- =============================================================================

--Roles, users and connections

/* In PostgreSQL, the concepts of both a single user account and a group 
of accounts are encompassed by the concept of a role.
A role represents a collection of database permissions and connection properties. */


--Managing Roles 
/*
Roles can be managed by means of three main SQL statements: CREATE ROLE to create a role from 
scratch, ALTER ROLE to change some role properties (for example, the login password), and DROP 
ROLE to remove an existing role
*/

--the default optio is nologin
create role tester with LOGIN password 'xxx';

create role tester with 
LOGIN password='xxx'
VALID UNTIL '2030-12-25 23:59:59'

--using a role as a grp 
--a group is a role taht contains other role 

--Using a role as a group
--A group is a role that contains other roles.
/* when you want to create a group, all you need to do is create a role without the LOGIN option and then add all the members one after the other to the containing role.
CREATE ROLE book_authors WITH NOLOGIN */
	
CREATE ROLE book_authors WITH NOLOGIN
	
--In order to create a role as a member of a specific group, the IN ROLE option can be used.
CREATE ROLE proof_reader
WITH LOGIN PASSWORD 'xxx'
IN ROLE book_authors;

CREATE ROLE enrico
WITH LOGIN PASSWORD 'xxx'
IN ROLE book_authors;

create role reviewer with login password 'xxx';

--every group can have  one or more  admin memvber ,ehich are allowed to add new memeber 
-- to the group
create role book_reviewer with nologin admin reviewer;

grant book_reviewer to enrico with admin option;

SELECT current_role ;
SELECT groname FROM pg_group;
SELECT * FROM pg_group where  groname = 'book_reviewers';
SELECT * FROM pg_group where  groname = 'book_authors';
SELECT rolname, rolcanlogin, rolconnlimit, rolpassword FROM pg_roles
 WHERE rolname = 'enrico';
SELECT * FROM pg_roles  WHERE rolname = 'enrico';

alter role tester with createdb;
alter role tester with createrole;
alter role tester nocreaterole nocreatedb;
alter role tester rename to luca;


SELECT r.rolname, g.rolname AS group,
 m.admin_option AS is_admin
 FROM pg_auth_members m
 JOIN pg_roles r ON r.oid = m.member
 JOIN pg_roles g ON g.oid = m.roleid
 ORDER BY r.rolname

grant select on library.authors to luca;
revoke select on library.authors from luca;

--to check permission 	on a reltion
--\dp library.authors

GRANT select ,update,insert 
on library.categories to luca

--GRANT <permission> ON SEQUENCE <sequence> TO <role>;
--REVOKE <permission> ON SEQUENCE <sequence> FROM <role>;

--grant permission on schema 
grant create  on schema library to enrico;

--enrico can create new object in the library schema 
revoke usage on schema library from enrico;

REVOKE ALL
ON ALL TABLES IN SCHEMA configuration
FROM luca;

--For instance, if you need to lock every user out of a database, for instance, because you h --do maintenance work, you can issue the following REVOKE command:
REVOKE CONNECT ON DATABASE demodb FROM PUBLIC;

GRANT CONNECT ON DATABASE demodb to public;

alter table sample owner to luca;

--PostgreSQL provides mechanism to restrict access to tabular data: RLS. 
--The idea is that RLS decides which tuples the role can have access to, either in read or write mode. 
--RLS provides a way to restrict the horizontal shape of the data itself.
--	The RLS infrastructure works on so-called policies. A policy is a set of rules --according to which 
--certain tuples should be made available to a user. Depending on the policies you ---apply, your roles 
--(that is, users) will be able to read and/or write

SHOW min_parallel_table_scan_size;
SHOW min_parallel_index_scan_size;
SHOW debug_parallel_query ;

SELECT name, setting
 FROM pg_settings
 WHERE name LIKE 'cpu%\_cost'
 OR name LIKE '%page\_cost'
 ORDER BY setting DESC

-----------------------------------------------------------------------------------
-- INDEXIS
------------------------------------------------------------------------------------
--An index is a data structure that allows faster access to the underlying table so -----that specific tuples can be found quickly.

--An index in PostgreSQL can be built on a single column or multiple columns at once; PostgreSQL supports indexes with up to 32 columns

--An index can cover all the data in the underlying table, or can index specific values only – in that  case, the index is known as “partial.” For example, you can decide to index only those values of  certain columns that you are going to use the most.Index types The default index PostgreSQL uses is Balanced Tree (B-Tree), a particular implementation of a  tree that keeps its depth constant even with large increases in the size of the underlying table, therefore requiring the same effort to be traversed from the root to its leaves.

--Block Range Index (BRIN) is a particular type of index that is based on the range of values in data blocks on storage. The idea is that every block has a minimal and maximal value, and the index then stores a couple of values for every data block on the storage. 

--Generalized Index Search Tree (GIST), which is a platform on top of which new 
--index types can be built. The idea is to provide a pluggable infrastructure where you can define  operators and features that can index a data structure. An example is SP-GIST, a spatial index  used in geographical applications

create index idx_post_category on library.posts(category);
create index idx_author_created_on on library.posts(author,created_on);
create index idx_post_created_on on library.posts using hash(created_on);
--now go and check the \d library.posts

SELECT relname, relpages, reltuples,
 i.indisunique, i.indisclustered, i.indisvalid,
 pg_catalog.pg_get_indexdef(i.indexrelid, 0, true)
 FROM pg_class c JOIN pg_index i on c.oid = i.indrelid
 WHERE c.relname = 'posts'

--The EXPLAIN statement
--EXPLAIN is the statement that allows you to see how PostgreSQL is going to execute a specific query It will only show the best plan, which is the one with the lowest cost among all the evaluated plans.It will not execute the statement you are asking the plan for, at least unless you explicitly ask for its execution. Therefore, the EXPLAIN execution is fast and pretty much constant each time.• It will present you with all the execution nodes that the executor will use to provide you  with the dataset.

explain select * from library.categories;
explain select first_name from employees order by hire_date desc;

EXPLAIN analyze SELECT first_name
FROM employees ORDER BY hire_date DESC;

EXPLAIN (ANALYZE)
SELECT first_name FROM employees ORDER BY hire_date DESC;

EXPLAIN (VERBOSE ON)
SELECT first_name FROM employees ORDER BY hire_date DESC;

EXPLAIN (ANALYZE ,BUFFERS ON)
SELECT first_name FROM employees ORDER BY hire_date DESC;





















