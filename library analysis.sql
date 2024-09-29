-- Project TASK

-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

-- Task 2: Update an Existing Member's Address

-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS106' from the issued_status table.

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

-- Task 5: List the member who have issued more than one book.
-- Objective: Use group by to find the member who have issued more than one book.

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt

-- Task 7. **Retrieve All Books in a Specific Category:

-- Task 8: Find Total Rental Income by Category:

-- Task 9. **List Members Who Registered in the Last 1180 Days**:

-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold

-- Task 12: Retrieve the List of Books Not Yet Returned

-- Task 13: Retrive the name of employee id and name whose branch address is '123 Main St'.

---------------------------------------------------------------------------------------------------------------------------------------------------

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