-- Create Customers Table
CREATE TABLE Customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100),
    customer_city VARCHAR(50)
);

-- Create Sales Reps Table
CREATE TABLE SalesReps (
    sales_rep_id VARCHAR(50) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100),
    office_address TEXT
);

-- Create Products Table
CREATE TABLE Products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10, 2) NOT NULL
);

-- Create Orders Table
CREATE TABLE Orders (
    order_id VARCHAR(50) PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id VARCHAR(50),
    sales_rep_id VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES SalesReps(sales_rep_id)
);

-- Create Order Items (Linking Table for Many-to-Many)
CREATE TABLE OrderItems (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Populate Customers
INSERT INTO Customers (customer_id, customer_name, customer_email, customer_city) VALUES
('C001', 'Rohan Mehta', 'rohan@gmail.com', 'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com', 'Delhi'),
('C003', 'Amit Verma', 'amit@gmail.com', 'Bangalore'),
('C006', 'Neha Gupta', 'neha@gmail.com', 'Delhi'),
('C008', 'Kavya Rao', 'kavya@gmail.com', 'Hyderabad');

-- Populate Sales Reps
INSERT INTO SalesReps (sales_rep_id, sales_rep_name, sales_rep_email, office_address) VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02', 'Anita Desai', 'anita@corp.com', 'Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03', 'Ravi Kumar', 'ravi@corp.com', 'South Zone, MG Road, Bangalore - 560001'),
('SR04', 'Sneha Patel', 'sneha@corp.com', 'Pune Branch'),
('SR05', 'Vikram Singh', 'vikram@corp.com', 'Chennai Branch');

-- Populate Products
INSERT INTO Products (product_id, product_name, category, unit_price) VALUES
('P001', 'Laptop', 'Electronics', 55000),
('P002', 'Mouse', 'Electronics', 800),
('P004', 'Notebook', 'Stationery', 120),
('P005', 'Headphones', 'Electronics', 3200),
('P007', 'Pen Set', 'Stationery', 250);

-- Populate Orders
INSERT INTO Orders (order_id, order_date, customer_id, sales_rep_id) VALUES
('ORD1027', '2023-11-02', 'C002', 'SR02'),
('ORD1114', '2023-08-06', 'C001', 'SR01'),
('ORD1153', '2023-02-14', 'C006', 'SR01'),
('ORD1002', '2023-01-17', 'C002', 'SR02'),
('ORD1176', '2023-03-18', 'C001', 'SR01');

-- Populate Order Items
INSERT INTO OrderItems (order_id, product_id, quantity) VALUES
('ORD1027', 'P004', 4),
('ORD1114', 'P007', 2),
('ORD1153', 'P007', 3),
('ORD1002', 'P005', 1),
('ORD1176', 'P002', 3);
