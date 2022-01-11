CREATE DATABASE mail_order;
USE mail_order;

CREATE TABLE employee (
	employee_no VARCHAR(10) NOT NULL PRIMARY KEY,
    f_name VARCHAR(20) NOT NULL,
    l_name VARCHAR(20) NOT NULL,
    zip_code INT
);

CREATE TABLE customer (
	customer_no VARCHAR(10) NOT NULL PRIMARY KEY,
    f_name VARCHAR(20) NOT NULL,
    l_name VARCHAR(20) NOT NULL,
    zip_code INT
);	

CREATE TABLE orders (
	order_no VARCHAR(10) NOT NULL PRIMARY KEY,
    customer_no VARCHAR(10) NOT NULL,
    file_order_id VARCHAR(10) NOT NULL,		-- FOREIGN KEY
    CONSTRAINT customer_no_FK_orders FOREIGN KEY (customer_no) REFERENCES customer (customer_no)
);
ALTER TABLE orders
ADD COLUMN time_date DATE NOT NULL; 	-- FOREIGN KEY


CREATE TABLE orders_employee (
	order_no VARCHAR(10) NOT NULL PRIMARY KEY,
    employee_no VARCHAR(10) NOT NULL,
    CONSTRAINT employee_no_FK_orders_employee FOREIGN KEY (employee_no) REFERENCES employee (employee_no)
);

CREATE TABLE file_order (
	file_order_id VARCHAR(10) NOT NULL PRIMARY KEY,
    order_no VARCHAR(10) NOT NULL,	-- FOREIGN KEY
    date_receipt DATE NOT NULL,
    exp_ship_date DATE,
    actual_date DATE NOT NULL,
    order_quantity VARCHAR(20) NOT NULL,
    CONSTRAINT order_no_FK_file_order FOREIGN KEY (order_no) REFERENCES orders (order_no)
);

ALTER TABLE orders
ADD CONSTRAINT file_order_FK_orders FOREIGN KEY (file_order_id) REFERENCES file_order (file_order_id);

CREATE TABLE part (
	part_no VARCHAR(10) NOT NULL PRIMARY KEY,
    part_name VARCHAR(10) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity DECIMAL(10,2) NOT NULL
);

CREATE TABLE part_time (
	part_no VARCHAR(10) NOT NULL PRIMARY KEY,
    time_date DATE NOT NULL		-- FOREIGN KEY
);

CREATE TABLE part_order_time (
	time_date DATE NOT NULL PRIMARY KEY,
    part_no VARCHAR(10) NOT NULL,	-- FOREIGN KEY
    order_no VARCHAR(10) NOT NULL,	-- FOREIGN KEY
    CONSTRAINT part_no_FK_part_orderTime FOREIGN KEY (part_no) REFERENCES part (part_no),
    CONSTRAINT order_no_FK_part_orderTime FOREIGN KEY (order_no) REFERENCES orders (order_no)
);

ALTER TABLE part_time
ADD CONSTRAINT time_date_FK_part_time FOREIGN KEY (time_date) REFERENCES part_order_time (time_date);

ALTER TABLE orders
ADD CONSTRAINT time_date_FK_orders FOREIGN KEY (time_date) REFERENCES part_order_time (time_date);

show columns from customer 
