CREATE TABLE customers (
    customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(120) UNIQUE
);

CREATE TABLE orders (
    order_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL
        CHECK (status IN (
            'Pending', 'Processing', 'Delivered', 'Cancelled'
        )),
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER NOT NULL,
    perfume_name VARCHAR(100) NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price > 0),
    CONSTRAINT fk_items_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

INSERT INTO customers (full_name, phone, email) VALUES
('Ahmed Ali', '0781000001', 'ahmed@example.com'),
('Sara Hassan', '0781000002', 'sara@example.com'),
('Omar Adam', '0781000003', 'omar@example.com'),
('Mariam Yusuf', '0781000004', 'mariam@example.com'),
('Khalid Musa', '0781000005', 'khalid@example.com');

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2026-10-20', 'Pending'),
(2, '2026-10-21', 'Delivered'),
(3, '2026-10-21', 'Pending'),
(1, '2026-10-22', 'Processing'),
(5, '2026-10-23', 'Delivered');

INSERT INTO order_items
(order_id, perfume_name, quantity, unit_price) VALUES
(1, 'Oud Royal', 2, 45.00),
(2, 'Rose Elegance', 1, 30.00),
(3, 'Amber Night', 3, 55.00),
(4, 'Golden Musk', 2, 40.00),
(5, 'Blue Ocean', 1, 25.00);

SELECT 'customers' AS table_name, COUNT(*) AS total
FROM customers

UNION ALL

SELECT 'orders', COUNT(*)
FROM orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM order_items;

SELECT full_name, email
FROM customers;

-- Q1.2: Find pending orders
SELECT *
FROM orders
WHERE status = 'Pending';

-- Q1.3: Show perfume items from highest to lowest price
SELECT *
FROM order_items
ORDER BY unit_price DESC;

-- Q2.1: Show orders with customer names
SELECT o.order_id, c.full_name, o.order_date, o.status
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id;

-- Q2.2: Show all customers, including those without orders
SELECT c.full_name, o.order_id, o.status
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;

-- Q2.3: Show customers, orders and perfume items
SELECT
    c.full_name,
    o.order_id,
    i.perfume_name,
    i.quantity,
    i.unit_price,
    i.quantity * i.unit_price AS line_total
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items i ON o.order_id = i.order_id;

-- Q3.1
UPDATE customers
SET email = 'ahmed.ali@example.com'
WHERE customer_id = 1;

-- Q3.2
UPDATE orders
SET status = 'Processing'
WHERE status = 'Pending';

-- Q3.3
UPDATE order_items
SET unit_price = ROUND(unit_price * 1.10, 2)
WHERE quantity >= 2;

-- Q4.1
ALTER TABLE customers
RENAME COLUMN phone TO phone_number;

-- Q4.2
ALTER TABLE order_items
ALTER COLUMN perfume_name TYPE VARCHAR(150);

-- Q4.3
ALTER TABLE customers
ADD COLUMN notes VARCHAR(200);

-- Q5.1: Insert one new customer
INSERT INTO customers
    (full_name, phone_number, email, notes)
VALUES
    ('Layla Ibrahim', '0781000006',
     'layla@example.com', 'New customer');

-- Q5.2: Insert three new customers
INSERT INTO customers
    (full_name, phone_number, email, notes)
VALUES
    ('Yasir Ahmed', '0781000007',
     'yasir@example.com', 'Regular customer'),
    ('Huda Osman', '0781000008',
     'huda@example.com', 'New customer'),
    ('Bilal Hassan', '0781000009',
     'bilal@example.com', 'Regular customer');

-- Q5.3: Insert a perfume item into an existing order
INSERT INTO order_items
    (order_id, perfume_name, quantity, unit_price)
VALUES
    (1, 'Silver Oud', 1, 60.00);
	
SELECT 'customers' AS table_name, COUNT(*) AS total
FROM customers
UNION ALL
SELECT 'orders', COUNT(*)
FROM orders
UNION ALL
SELECT 'order_items', COUNT(*)
FROM order_items;