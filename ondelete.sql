create table Parent (id int primary key, name varchar(20))
insert into Parent values(1, 'ECE'), (2, 'ECCE'), (3, '1');

create table Child (id int primary key ,name varchar(20), did int references Parent(id)) 
insert into Child values (1, 'Alice',1), (2, 'bob',2), (3, 'charles',3);

select * from child;
delete from parent where id=1;--error since child is using parent id key as ref
truncate child ;
select * from child;
--moral of the story we cannot delete the data of parent until we delete it from child 
drop table child;
create table Child (id int primary key ,name varchar(20), did int references Parent(id) on delete cascade)
insert into Child values (1, 'Alice',1), (2, 'bob',2), (3, 'charles',3);
delete from parent where id=3;
select * from child;

select * from parent;
drop table child;
create table Child (id int primary key ,name varchar(20), did int references Parent(id) on delete set null)
insert into Child values (1, 'Alice',1),  (3, 'charles',3);
delete from parent where id=3;
select * from child;

--restrict wala restrict ka exception show karega
create table Child (id int primary key ,name varchar(20), did int references Parent(id) on delete restrict)





