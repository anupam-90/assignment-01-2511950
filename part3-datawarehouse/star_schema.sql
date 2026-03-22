-- DDL for Star Schema

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE NOT NULL,
    month INT,
    year INT,
    quarter INT
);

CREATE TABLE dim_store (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(100),
    store_city VARCHAR(50)
);

CREATE TABLE dim_product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);

CREATE TABLE fact_sales (
    transaction_id VARCHAR(50) PRIMARY KEY,
    date_id INT,
    store_id INT,
    product_id INT,
    customer_id VARCHAR(50),
    units_sold INT,
    total_revenue DECIMAL(15,2),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- DML to insert Sample Cleaned Data

INSERT INTO dim_date (date_id, full_date, month, year, quarter) VALUES 
(20230829, '2023-08-29', 8, 2023, 3),
(20231212, '2023-12-12', 12, 2023, 4),
(20230205, '2023-02-05', 2, 2023, 1),
(20230220, '2023-02-20', 2, 2023, 1),
(20230115, '2023-01-15', 1, 2023, 1);

INSERT INTO dim_store (store_id, store_name, store_city) VALUES 
(1, 'Chennai Anna', 'Chennai'),
(2, 'Delhi South', 'Delhi'),
(3, 'Bangalore MG', 'Bangalore'),
(4, 'Pune FC Road', 'Pune'),
(5, 'Mumbai Central', 'Mumbai');

-- Standardized Category casing during insert
INSERT INTO dim_product (product_id, product_name, category, unit_price) VALUES 
(1, 'Speaker', 'Electronics', 49262.78),
(2, 'Tablet', 'Electronics', 23226.12),
(3, 'Phone', 'Electronics', 48703.39),
(4, 'Smartwatch', 'Electronics', 58851.01),
(5, 'Atta 10kg', 'Groceries', 52464.00);

-- Fact table calculating total_revenue (units_sold * unit_price) and resolving foreign keys
INSERT INTO fact_sales (transaction_id, date_id, store_id, product_id, customer_id, units_sold, total_revenue) VALUES 
('TXN5000', 20230829, 1, 1, 'CUST045', 3, 147788.34),
('TXN5001', 20231212, 1, 2, 'CUST021', 11, 255487.32),
('TXN5002', 20230205, 1, 3, 'CUST019', 20, 974067.80),
('TXN5003', 20230220, 2, 2, 'CUST007', 14, 325165.68),
('TXN5004', 20230115, 1, 4, 'CUST004', 10, 588510.10),
('TXN5005', 20230829, 3, 5, 'CUST027', 12, 629568.00),
('TXN5006', 20230220, 4, 4, 'CUST025', 6, 353106.06),
('TXN5007', 20231212, 4, 1, 'CUST011', 2, 98525.56),
('TXN5008', 20230205, 5, 5, 'CUST009', 5, 262320.00),
('TXN5009', 20230115, 2, 3, 'CUST033', 1, 48703.39);
