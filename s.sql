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