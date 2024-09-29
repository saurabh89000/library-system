Library Management System using SQL Project 
Project Overview

Project Title: Library Management System
Level: Intermediate
Database: librarydb

This project demonstrates the implementation of a Library Management System using SQL.
It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries.
The goal is to showcase skills in database design, manipulation, and querying.

Database Creation: Created a database named librarydb.
Table Creation: Created tables for branches, employees, members, books, issued status, and return status.
Each table includes relevant columns and relationships.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
create database librarydb;
drop database librarydb;

-- Create table "Branch"
 CREATE TABLE branch (
    branch_id VARCHAR(10) PRIMARY KEY,
    manager_id VARCHAR(20),
    branch_address VARCHAR(30),
    contact_no VARCHAR(20)
);
 
 -- Create table "Employee"
DROP TABLE IF EXISTS employees;
CREATE TABLE employees
(
            emp_id VARCHAR(10) PRIMARY KEY,
            emp_name VARCHAR(30),
            position VARCHAR(30),
            salary DECIMAL(10,2),
            branch_id VARCHAR(10),
            FOREIGN KEY (branch_id) REFERENCES  branch(branch_id)
);


-- Create table "Members"
DROP TABLE IF EXISTS members;
CREATE TABLE members
(
            member_id VARCHAR(10) PRIMARY KEY,
            member_name VARCHAR(30),
            member_address VARCHAR(30),
            reg_date DATE
);



-- Create table "Books"
DROP TABLE IF EXISTS books;
CREATE TABLE books
(
            isbn VARCHAR(50) PRIMARY KEY,
            book_title VARCHAR(80),
            category VARCHAR(30),
            rental_price DECIMAL(10,2),
            status VARCHAR(10),
            author VARCHAR(30),
            publisher VARCHAR(30)
);


-- Create table "IssueStatus"
DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status
(
            issued_id VARCHAR(10) PRIMARY KEY,
            issued_member_id VARCHAR(30),
            issued_book_name VARCHAR(80),
            issued_date DATE,
            issued_book_isbn VARCHAR(50),
            issued_emp_id VARCHAR(10),
            FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
            FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id),
            FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn) 
);



-- Create table "ReturnStatus"
DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status
(
            return_id VARCHAR(10) PRIMARY KEY,
            issued_id VARCHAR(30),
            return_book_name VARCHAR(80),
            return_date DATE,
            return_book_isbn VARCHAR(50),
            FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);
 
select*from books;
select*from branch;
select*from employees;
select*from issued_status; 
select*from members;
select*from return_status;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PROJECT ANALYSIS-

-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert into books (
isbn,book_title,category,rental_price,status,author,publisher)
values
('978-1-60129-456-2','To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
select*from books;

-- Task 2: Update an Existing Member's Address

update members
set member_address="125 Main St"
where member_id="C101";
select*from members;

-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS106' from the issued_status table.

delete from issued_status
where issued_id='IS106';
Select*from issued_status;

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

select* from issued_status
where  issued_emp_id='E101';


-- Task 5: List the member who have issued more than one book.
-- Objective: Use group by to find the member who have issued more than one book.

select issued_member_id
, count(issued_id)as total_issued_book
from issued_status
group by issued_member_id
having count(issued_id)>1;

-- Task 6: Create Summary Tables**:To generate new tables based on query results - each book and total book_issued_cnt

create table book_cnts
as
select
b.isbn,
b.book_title,
count(ist.issued_id) as cnt_issued_id
from 
books as b
join issued_status as ist
on ist.issued_book_isbn=b.isbn
group by 1,2;

select* from book_cnts;

-- Task 7. **Retrieve All Books in a Specific Category:

select*from books
where category='Classic';

-- Task 8: Find Total Rental Income by Category:

select category,sum(rental_price),count(*)
from books
group by category;

-- Task 9. **List Members Who Registered in the Last 1180 Days**:

select*from members
where reg_date >= curdate()-1180;

-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:

select * 
from employees as emp
join branch as b
on emp.branch_id=b.branch_id ;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD

create table books_rentalprice_greater_than_seven
as
select* from books
where rental_price>7;

select*from books_rentalprice_greater_than_seven;

-- Task 12: Retrieve the List of Books Not Yet Returned

select*from
issued_status as ist
 left join return_status as rs
on ist.issued_id=rs.issued_id
where rs.return_id is null;

-- Task 13: Retrive the employee id and name whose branch address is '123 Main St'.

select emp_id, emp_name
from employees
join branch 
on employees.branch_id= branch.branch_id
where branch_address = '123 Main St';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Conclusion
This project demonstrates the application of SQL skills in creating and managing a library management system.
It includes database setup, data manipulation, and advanced querying, providing a solid foundation for data management and analysis.


Thank you for your interest in this project!
