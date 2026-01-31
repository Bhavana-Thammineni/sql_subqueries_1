create database mall;
use mall;
create table trend(
sno int,
female varchar(10),
male char(10) 
);
select*from trends;
#dml-insert
insert into trend values(1,'bhavaba','bhavana'),(2,'priya','priva');

#alter- adding column
alter table trend add column kids text;
alter table trend add column child text after female;
alter table trend add column cosmoties char first;

#alter-changing the column name 
alter table trend rename column kids to kid;

#alter-incase the dxatatype change
alter table trend modify column cosmoties varchar(20);
desc trend;

#alter-remove the column
alter table trend drop column kid;

#rename
rename table trend to trends;
show tables;

#truncate
create table trendind(
id int 
);
insert into trendind values (1),(2);
truncate table trendind;
select*from trendind;

#drop
drop table trendind;
show tables;

#dml
#updates
set sql_safe_updates=0;
update trends set female = 'bhav' where sno = 1;

#delete
set autocommit =0;
delete from trends where female = 'bhav';
rollback;

use mall;
select*from trends;
desc trends;
set sql_safe_updates =0;
update trends set male = "sai" where sno =1;
delete from trends where cosmoties is null;
rollback; #no rollback
alter table trends drop column cosmoties;
alter table trends add column cosmatices text;
insert into trends values (1,"bhavana","sai","rrr","chips"),(2,"kavya","suu","lipbob","sdfghj"),(3,"kavi","ruru","handcup","oiugf");
alter table trends add   sale bigint;
set sql_safe_updates=0;
update trends set sale =4 where sno =3;
alter table trends add column profit float;
alter table trends add column loss float;
insert into trends (profit,loss) values (20.34,4.8),(34.4,45.34),(3456.456,456.45);

#operators
select*,sale*100 from trends;
select*from trends where profit > 20;
select*from trends where profit>20 and loss <5;
select*from trends where sale in(4);
select*from trends where sale is not null;

#constriants
show tables;
desc maps;
use mall;
drop table map;

#adding the data set to form the browse option
select*from data ;
desc data;
select distinct quantity from data;
set sql_safe_updates=0;
update data set quantity = 1 where quantity = "one";
update data set quantity = 2 where quantity = "two";
update data set quantity = 10 where quantity = "one0";

alter table data modify column quantity int;

alter table data add column grade char(1) after quantity;
select*from data;
update data set grade=(case
when quantity >= 7 then 'A'
when quantity >= 5 then 'b'
when quantity >= 3 then 'c'
else "d"
end);

update data set order_date = date_format(str_to_date(order_date,'%m/%d/%Y'),'%Y-%m-%d');
UPDATE data
SET order_date = DATE_FORMAT(
    STR_TO_DATE(order_date, '%m/%d/%Y'),
    '%Y-%m-%d'
);

Select*from data order by Sale_ID asc;

use mall;
show tables;
select*from data;

#opertors: 1.like 2.as 3.between

select*from data where Customer_Name like 'a%';
select*from data where Customer_Name like 'a_____';
select*from data where Customer_Name like '_a%';

select grade as GRADE1 from data;

select*from data where quantity between 1 and 5;

#string functions
use mall;
show tables;
select*from data;
####### concatanation
#--------method one
select*,concat(Payment_Method," ", Delivery_Status) from data;
alter table data add column Payment_Delivery_Status VARCHAR(100);
set sql_safe_updates=0;
update data set Payment_Delivery_Status = concat(Payment_Method," ",Delivery_Status) ;
#--------method two
update data set Payment_Method = concat(Payment_Method," ",Delivery_Status) ;

########## upper
select*,upper(Product_Name) from data;
set sql_safe_updates=0;
update data set  Product_Name = upper(Product_Name);
select*from data;

#########lower
select*,lower(Region) from data;
set sql_safe_updates=0;
update data set  Region = lower(Region);
select*from data;

######length
select*,length(product_name) from data;
alter table data add column leng_product_name bigint after product_name;
update data set leng_product_name=length(product_name);

########substr
select*,substr(Region,1,1) from data;
alter table data add column region_sub char(2) after Region;
update data set region_sub = substr(Region,1,1);

#####left
select*,left(Region,2) from data;
alter table data add column region_left char(2) after Region_sub;
update data set region_left = left(Region,2);

#####right
select*,left(Region,4) from data;
alter table data add column region_right char(4) after Region_left;
update data set region_right = right(Region,4);

#####replace
select*,replace(Region,'o','0') from data;
alter table data add column region_replace char(8) after Region_right;
update data set region_replace= replace(Region,'o','0');
select*from data;

alter table data drop column length_product_name;

#####reverse
select*,reverse(customer_name)from data;
alter table data add column reverse_cust char(8) after customer_name ;
update data set reverse_cust = substr((customer_name),1,5);



##### date functions
use mall;
show tables;
select*from new_data;
DESC new_data;

###covert into the date format
set sql_safe_updates =0;
update new_data set order_date=date_format(str_to_date(order_date,'%m/%d/%Y'),'%Y-%m-%d');


###now fn
SELECT order_date, NOW() AS current_datetime FROM new_data;

SELECT order_date, CURDATE() AS today_date FROM new_data;

SELECT order_date, CURTIME() AS 'current_time' FROM new_data;

SELECT order_date,
       DATE_ADD(order_date, INTERVAL 10 DAY) AS added_days
FROM new_data;

SELECT DATE_ADD(order_date, INTERVAL 2 MONTH)
FROM new_data;

SELECT order_date,
       DATE_SUB(order_date, INTERVAL 7 DAY) AS before_7_days
FROM new_data;

SELECT order_date,
       DATEDIFF(CURDATE(), order_date) AS days_difference
FROM new_data;

SELECT order_date,
       EXTRACT(YEAR FROM order_date) AS year,
       EXTRACT(MONTH FROM order_date) AS month,
       EXTRACT(DAY FROM order_date) AS day
FROM new_data;

SELECT order_date,
       DAYNAME(order_date) AS day_name
FROM new_data;

######window functions
CREATE TABLE e_commerce_orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10, 2),
    total_amount DECIMAL(10, 2),
    order_date DATE
);
-- Insert sample data (20 rows) with customer names like Ravi
INSERT INTO e_commerce_orders (order_id, customer_name, product_name, quantity, price, total_amount, order_date)
VALUES
(1, 'Ravi Kumar', 'Smartphone', 1, 699.99, 699.99, '2025-10-01'),
(2, 'Amit Sharma', 'Laptop', 1, 999.99, 999.99, '2025-10-02'),
(3, 'Raj Patel', 'Headphones', 2, 49.99, 99.98, '2025-10-03'),
(4, 'Neha Gupta', 'Smartwatch', 1, 199.99, 199.99, '2025-10-04'),
(5, 'Priya Mehta', 'Tablet', 1, 329.99, 329.99, '2025-10-05'),
(6, 'Vikram Singh', 'Keyboard', 1, 89.99, 89.99, '2025-10-06'),
(7, 'Sonia Reddy', 'Mouse', 2, 19.99, 39.98, '2025-10-07'),
(8, 'Ravi Sharma', 'Monitor', 1, 249.99, 249.99, '2025-10-08'),
(9, 'Ananya Iyer', 'Phone Case', 3, 15.99, 47.97, '2025-10-09'),
(10, 'Karan Joshi', 'Smartphone', 2, 699.99, 1399.98, '2025-10-10'),
(11, 'Maya Desai', 'Gaming Console', 1, 399.99, 399.99, '2025-10-11'),
(12, 'Rohit Kapoor', 'Speakers', 2, 79.99, 159.98, '2025-10-12'),
(13, 'Simran Chawla', 'Laptop', 1, 849.99, 849.99, '2025-10-13'),
(14, 'Amitabh Reddy', 'Smartwatch', 1, 199.99, 199.99, '2025-10-14'),
(15, 'Tanya Gupta', 'Smartphone', 1, 799.99, 799.99, '2025-10-15'),
(16, 'Harish Kaur', 'Tablet', 1, 299.99, 299.99, '2025-10-16'),
(17, 'Deepak Singh', 'Keyboard', 2, 69.99, 139.98, '2025-10-17'),
(18, 'Neelam Verma', 'Headphones', 1, 89.99, 89.99, '2025-10-18'),
(19, 'Kunal Joshi', 'Gaming Console', 1, 499.99, 499.99, '2025-10-19'),
(20, 'Pooja Shah', 'Monitor', 1, 199.99, 199.99, '2025-10-20');

select*from e_commerce_orders;

alter table e_commerce_orders add column price_500 int;
alter table e_commerce_orders drop column price_500;
set sql_safe_updates=0;

SELECT *
FROM e_commerce_orders
WHERE price > 500;

SELECT *
FROM e_commerce_orders
WHERE customer_name = 'Ravi Kumar';

SELECT *
FROM e_commerce_orders
WHERE product_name = 'laptop';

SELECT *
FROM e_commerce_orders
WHERE order_date BETWEEN '2025-10-05' AND '2025-10-15';

SELECT DISTINCT product_name
FROM e_commerce_orders;

SELECT DISTINCT customer_name
FROM e_commerce_orders
WHERE product_name = 'Smartphone';

SELECT *
FROM e_commerce_orders
ORDER BY order_date ASC;

SELECT *
FROM e_commerce_orders
ORDER BY total_amount DESC;

SELECT *
FROM e_commerce_orders
LIMIT 5;

SELECT *
FROM e_commerce_orders
ORDER BY order_date DESC
LIMIT 3;

SELECT *
FROM e_commerce_orders
WHERE customer_name LIKE 'R%';

SELECT *
FROM e_commerce_orders
WHERE price BETWEEN 100 AND 500;

SELECT *
FROM e_commerce_orders
WHERE quantity > 1;

SELECT *
FROM e_commerce_orders
WHERE product_name <> 'Smartphone';

SELECT DISTINCT customer_name
FROM e_commerce_orders
WHERE order_date = '2025-10-10';


####27/01/2026
use mall;
CREATE TABLE Emp (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    Age INT,
    City VARCHAR(50)
);

INSERT INTO Emp (EmpID, Name, Department, Salary, Age, City) VALUES
(1, 'Amit', 'HR', 35000, 29, 'Delhi'),
(2, 'Sneha', 'Finance', 48000, 32, 'Mumbai'),
(3, 'Ravi', 'IT', 55000, 28, 'Bangalore'),
(4, 'Priya', 'Sales', 40000, 30, 'Chennai'),
(5, 'Karan', 'Finance', 60000, 35, 'Delhi'),
(6, 'Meena', 'HR', 30000, 26, 'Pune'),
(7, 'Suresh', 'IT', 70000, 40, 'Hyderabad'),
(8, 'Divya', 'Sales', 42000, 27, 'Mumbai'),
(9, 'Vikram', 'Finance', 65000, 36, 'Bangalore'),
(10, 'Nisha', 'IT', 72000, 31, 'Delhi'),
(11, 'Rohit', 'HR', 31000, 25, 'Chennai'),
(12, 'Pooja', 'Sales', 38000, 29, 'Pune'),
(13, 'Anil', 'Finance', 58000, 34, 'Hyderabad'),
(14, 'Neha', 'IT', 64000, 33, 'Mumbai'),
(15, 'Rajesh', 'Sales', 45000, 37, 'Delhi'),
(16, 'Komal', 'HR', 33000, 28, 'Bangalore'),
(17, 'Deepak', 'Finance', 52000, 30, 'Chennai'),
(18, 'Swati', 'IT', 76000, 38, 'Pune'),
(19, 'Arjun', 'Sales', 47000, 29, 'Hyderabad'),
(20, 'Lakshmi', 'Finance', 61000, 32, 'Delhi'),
(21, 'Manoj', 'IT', 69000, 36, 'Bangalore'),
(22, 'Sakshi', 'Sales', 39000, 26, 'Mumbai'),
(23, 'Harish', 'HR', 29500, 24, 'Chennai'),
(24, 'Kavita', 'Finance', 57000, 35, 'Hyderabad'),
(25, 'Sunil', 'IT', 73000, 39, 'Delhi'),
(26, 'Ramesh', 'Sales', 46000, 33, 'Pune'),
(27, 'Jyoti', 'Finance', 59000, 31, 'Bangalore'),
(28, 'Ashok', 'IT', 71000, 34, 'Mumbai'),
(29, 'Tanvi', 'Sales', 41000, 27, 'Delhi'),
(30, 'Gaurav', 'HR', 34000, 29, 'Hyderabad');

select * from emp;
##1. Find employees whose salary is greater than the average salary of all employees.
select*from emp where salary >
(select avg(salary) from emp);

##2. Find employees whose age is less than the youngest employee in the HR department.
select*from emp where age < 
(select min(age) from emp where department ='hr') ;

##3. Find employees living in the same city as Ravi
select*from emp where city =
(select city from emp where name='ravi'); 

##4. Find employees with the same salary as Karan
select*from emp where salary =
(select salary from emp where name='karan'); 

##5. Find employees earning more than Sneha
select*from emp where salary >
(select salary from emp where name='sneha'); 

##6. Find employees working in the same department as Nisha
select*from emp where department =
(select department from emp where name='nisha');

##7. Find employees who live in the same cities as Finance department employees.
select*from emp where city in
(select city from emp where department='finance');

##8. Find employees older than any employee in the Sales department
select*from emp where age > any
(select age from emp where department='sales');

##9. Find employees earning more than all employees in HR.
SELECT * FROM emp WHERE salary > (SELECT MAX(salary) FROM emp WHERE department = 'HR');




