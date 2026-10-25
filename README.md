Perfume Store Management System

Assignment III: SQL Practical Exercise – Table Manipulation

Student ID: 202512517
DBMS: PostgreSQL

1. Project Overview

This project manages customers, orders, and perfume items using PostgreSQL.

2. Database Tables

- customers: Stores customer information.
- orders: Stores customer orders.
- order_items: Stores perfume names, quantities, and prices.

3. Relationships

- One customer can have multiple orders.
- One order can contain multiple perfume items.

4. Entity Relationship Diagram (ERD)

"Database ERD" (erd.png)

5. Practical Tasks

The assignment covers SELECT, JOIN, UPDATE, ALTER TABLE, and INSERT statements.

6. Execution Evidence

Screenshots of the SQL statements and their actual execution results will be included in the "screenshots" folder.

7. Conclusion

This project demonstrates database creation, table relationships, data retrieval, data modification, and table structure changes using PostgreSQL.
### Task: Data Verification Count
```sql
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items;
```
![1_Data Verification Count qoury](1_Data Verification Count.jpg)
