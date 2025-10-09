# E-CommerceSystemDB
---
Project Overview
---
E-CommerceSystemDB is an SQL-based database designed for a Global Gadgets, a digital retailer. The system manages customers, products, suppliers, orders, payments, reviews, and inventory, ensuring data consistency, referential integrity, and operational automation via T-SQL triggers, views, and stored procedures. The database was designed for a retailer who wants a scalable backend to track sales, manage inventory, and automate stock updates when orders are placed, delivered, or cancelled.

Features
---
- **Customer Management**: Stores customer profiles, billing details, and login credentials with account deactivation tracking.
- **Supplier Management**: Records supplier company and contact details for product sourcing.
- **Product & Category Management**: Organizes products by category (Premium, Standard, Budget) and enforces valid pricing.
- **Order & Payment Tracking**: Handles customer orders, order details, and payment records with status updates.
- **Inventory Control**: Automatically updates stock levels via triggers and prevents negative inventory.
- **Shipping Methods**: Normalized lookup for delivery types (Air, Sea, Land, Courier).
- **Reviews & Ratings**: Enables customers to rate and review delivered products.
- **Stored Procedures & Functions**: Automate tasks like searching products, viewing today’s orders, and updating supplier data.
- **Triggers**: Maintain stock accuracy when orders are cancelled or restocked.
- **Views**: Provide order summaries combining customer, product, and supplier data for easy reporting.

Database Schema
---
The database consists of 13 tables that form the core functionality of e-commerce system. Below is a visual representation of the database schema:
![ERD Diagram SSMS](images/ERD-Diagram-SSMS.jpg)



  
