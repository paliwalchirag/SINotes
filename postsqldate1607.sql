set search_path to library, public;

CREATE TABLE IF NOT EXISTS library.authors (
id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL, birthdate DATE
);

CREATE TABLE IF NOT EXISTS library.books (
title VARCHAR(255) NOT NULL,
id SERIAL PRIMARY KEY, published_date DATE,
author_id INT REFERENCES authors (id),
isbn VARCHAR(13),
pages INT,
Language VARCHAR(50)
);

INSERT INTO authors (name, birthdate) VALUES
('George Orwell', '1903-06-25'),
('J.K. Rowling', '1965-07-31'),
('Isaac Asimov', '1920-01-02'),
('Arthur Conan Doyle', '1859-05-22'),
('Agatha Christie', '1890-09-15'),
('J.R.R. Tolkien', '1892-01-03'),
('Stephen King', '1947-09-21'),
('Mark Twain', '1835-11-30'),
('Ernest Hemingway', '1899-07-21'),
('F. Scott Fitzgerald', '1896-09-24');

INSERT INTO books (title, author_id, published_date, isbn, pages, language) VALUES
('1984', 1, '1949-06-08', '1234567890123', 328, 'English'),
('Animal Farm', 1, '1945-08-17', '1234567890124', 112, 'English'),
('Harry Potter and the Philosophers Stone', 2, '1997-06-26', '1234567890125', 223, 'English'),
('Foundation', 3, '1951-06-01', '1234567890126', 255, 'English'),
('Sherlock Holmes', 4, '1887-03-15', '1234567890127', 307, 'English'),
('Murder on the Orient Express', 5, '1934-01-01', '1234567890128', 256, 'English'),
('The Hobbit', 6, '1937-09-21', '1234567890129', 310, 'English'),
('The Shining', 7, '1977-01-28', '1234567890130', 447, 'English'),
('Adventures of Huckleberry Finn', 8, '1884-12-10', '1234567890131', 366, 'English'),
('The Old Man and the Sea', 9, '1952-09-01', '1234567890132', 127, 'English');

select * from books fetch first 8 row only ;


ALTER TABLE books ADD COLUMN genre VARCHAR(20);
UPDATE books
SET genre = CASE
WHEN title = '1984' THEN 'Dystopian'
WHEN title = 'Animal Farm' THEN 'Political Satire'
WHEN title = 'Harry Potter and the Philosophers Stone' THEN 'Fantasy'
WHEN title = 'Foundation' THEN 'Science Fiction'
WHEN title = 'Sherlock Holmes' THEN 'Mystery'
WHEN title = 'Murder on the Orient Express' THEN 'Mystery'
WHEN title = 'The Hobbit' THEN 'Fantasy'
WHEN title = 'The Shining' THEN 'Horror'
WHEN title = 'Adventures of Huckleberry Finn' THEN 'Adventure'
WHEN title = 'The Old Man and the Sea' THEN 'Literary Fiction'
END;

create unlogged table if not exists unlogged_users (
pk int
,username text NOT NULL
,email text NOT NULL
,PRIMARY KEY (pk)
,UNIQUE (username)
);

show search_path;
set search_path TO library, public;
CREATE TABLE library.categories (
pk integer NOT NULL,
title text NOT NULL,
description text
 );

ALTER TABLE library.categories ALTER COLUMN pk ADD GENERATED ALWAYS AS IDENTITY (
SEQUENCE NAME library.categories_pk_seq
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1
);

select * from categories;

ALTER TABLE library.categories
	ADD CONSTRAINT categories_pkey PRIMARY KEY (pk);

select * from categories

INSERT INTO categories(title,description) VALUES
	('c language','languages'),('python language','languages');
INSERT INTO categories(title) VALUES('a new discussion');

insert into categories (title,description) values
('Database', 'Database related discussions') ,('Unix','Unix and Linux discussions'),
	 ('Programming Languages', 'All about programming languages') ;

--select only the tuples where the description is equal to Database Kelated discussions,
select * from categories where description = 'Database related discussions';

-- select all the tuples that both have a description field equal to Languages and 
-- are sorted by title in reverse order,
select * from categories where description='languages' order by title desc;
--order by 2 mean select the 2 column,, here the column start from index 1 not 0
select * from categories where description='languages' order by 2 desc;

-- select all the tuples in which the description is null 
select * from categories where description is NULL;


--search for all the tuples for which their is value in the description field
select title,description from categories where description is not null
select * from categories order by description;
select * from categories order by description Nulls first;
select * from categories order by description nulls last;


--temporary tables ;
--creat table from select 
create temp table temp_categories as select * from categories;
select * from temp_categories;

create table lang_cat as select * from categories where description ='languages';
DROP table lang_cat ;
create table lang_cat as select * from categories where description ='languages';
select * from lang_cat
create table lang_cat as select * from categories where description ='languages';


UPDATE temp_categories set title='linux' where title='Unix';


--delete all row which have description value is null
delete from temp_categories where description is null

truncate table temp_categories;
select * from temp_categories;

--insert mai as select nahi use kiya , create mai as select use karte hai remember
insert into temp_categories select * from categories;

--find all records that have a title field value starting from prog.
select * from categories where title like 'Prog%';

--find ending the title from word languages 
select * from categories where title like '%languages';

--search all recrds  that contain the partial string discuss
select * from categories where title like '%discuss%';

select upper('admin');
select lower('ASbasd');
select * from categories where lower(title)='unix';

--show all the distinct values of title from categories and sort by title 
select distinct title from categories order by title;

--dealing with null
-- coalesce function

select coalesce ('Alice',Null);
-- coalesce print the first non-null value it goes from left to right and print
-- the first non-null value
select coalesce (null,'Some value');
select coalesce (null,Null,'some value');
--in the below it will print only chirag that is not null value
select coalesce ('chirag',Null,'some value');

--use coalesce function to show the value 'no description 'insted of null in the description 
select * from categories;
select pk,title, coalesce(description,'no') from categories;

--for the above coalesce query display the column with the title Description
select pk, title, coalesce (description, 'No description') as Description from categories;
--display the coalesce Tolumn alias name as Description Details
select pk, title, coalesce (description, 'No description') as "description detail" from categories;


--fetch the first recoed from categories 
select * from categories limit 1;
--fetch the second record only
--offset 1 mean dont show the first row from the table
select * from categories offset 1 limit 1;

--creat a table name categories2 as a copy of categories with zero record ;
create table categories2 as select * from categories limit 0
select * from categories2

--using Subqueries
--output of one quer in input of another queries

--search for all categories that have the value of pk=1 or the value of pk=2
select * from categories where pk=1 or pk=2;
select * from categories where pk in (1,2);

--search for all categories that do not have pk=1 or pk=2
select * from categories where not (pk=1 or pk=2);
select * from categories where pk not in (1,2);

select * from books;
--find the pag with highest number of page
select max(pages) from books;
--display the title of the  book that has the highest number of pages we use subquery here
select title from books where pages=(select max(pages) from books);

--display thedetails of the book that has the lowest number of pages 
select title from books where pages=(select min(pages) from books);

--display thedetails of the book that has the second highest number of pages 
select title,pages from books where pages=(select pages from books order by pages desc offset 1 limit 1);
select pages from books order by pages desc offset 1 limit 1;

--count the number of row in a table
select count(id) from books;


CREATE TABLE library.posts (
    pk integer  GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    title text,
    content text,
    author integer NOT NULL,
    category integer NOT NULL,
    reply_to integer,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    last_edited_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    editable boolean DEFAULT true,
    likes integer DEFAULT 0
);

create sequence seq_id start 1 increment 1;
CREATE TABLE library.users (
pk integer Primary Key DEFAULT nextval('seq_id'),
username text NOT NULL,
email text NOT NULL
);
insert into users(username,email) values('Alice','alice@gmail.com'),
('bob','bob@gmail.com'),
('jane','jane@gmail.com'),
('harry','harry@gmail.com');

select * from users;
select nextval('seq_id');
insert into users(username,email) values('kiara','kiara@gmail.com');


insert into posts (title,content,author,category) values ('Indexing PostgreSQL','Btree in PostgreSQL is....',1,1);
insert into posts (title,content,author,category) values ('Indexing Mysql','Btree in Mysql is....',1,1);
insert into posts (title,content,author,category) values ('Data types in C++','Data type in C++ are ..' ,2,3);
insert into posts (title,content,author,category) values ('Databse','Data type in C++ are ..' ,2,3);

--it return a column with start row integer 1 and the next row integer is 14 i.e the difference 
--of 13 up till 60 value
select x from generate_series(1,60,13) as x

--String func
	-- lapd(end wala,kitna size,start )
select lpad('ab','4','*') as lpad
select lpad('ab','4','*') as lpad,rpad('ab','4','-') as abpad

select 'hello   chirag            paliwal ',ltrim('     hello gg');

--the split_part function is useful for extracting  and element from a delimited 	string
select 	split_part('abc.123.z45','.',3) as x;
select 	split_part('abc.123.z45','.',2) as x;
select 	split_part('abc-123-z45','-',1) as x;

--the string_to_array function is usefull for creating an array  of element from a delimited string
SELECT string_to_array('abc.123.z45','.') as x;
select unnest (string_to_array('abc.123.z45','.')) as x;

select regexp_replace(
	'4328787',
	'([0-9]{3})([0-9]{3})([0-9]{4})',
	E'\(\\1\\) \\2-\\3'
	) as x;

select substring('wellcome',1,3);

--array constructs
select array[2001,2002,2003] as yr;

--exists and not exists condition
--The EXISTS statement is used when we want to check whether a subquery returns (TRUE), and 
--the NOT EXISTS statement is used when we want to check whether a subquery does not return 
--(FALSE).
--here post table is prim=nted only if their exist a data name databse in title in categories tabel
select pk, title, content, author, category from posts where exists
(select 1 from categories where title='Database');

--here it does not exist so no row is shown
--here select 1 '1 ' is a dummy data which we provide from our own
select pk, title, content, author, category from posts where exists
(select 1 from categories where title='Datbase');

select * from posts;
select * from categories;

--to search for all the posts that belong to the databse categories.
select pk, title, content, author, category from posts where 
category in (select pk from categories where title='c language');








