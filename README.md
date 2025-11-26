README - TCS Employee Database (DBMS Project)
---------------------------------------------

Thank you for reviewing this project. Please follow the steps below to
execute and explore the database.

=====================================================
1. EXECUTE THE SCHEMA FILE FIRST
=====================================================
File: tcs_emp_db_schema.sql

This file contains:
- Creation of the database (tcs_emp_db)
- All tables with full constraints (PK, FK, checks, indexes)
- Initial seed data (employees, projects, clients, assets, etc.)
- Views, stored procedures, triggers, archive tables
- High-complexity relational structure

Instructions:
1. Open MySQL Workbench
2. Go to File → Open SQL Script
3. Select **tcs_emp_db_schema.sql**
4. Press the lightning bolt (Run)

This will create the complete database structure along with basic initial data.

=====================================================
2. ADD ADDITIONAL DUMMY DATA
=====================================================
File: tcs_emp_db_dummy_data.sql

This file contains:
- Additional employees, vendors, clients, departments
- More projects & project assignments
- Expanded timesheets, assets, inventory, invoices, skills, payroll rows
- Recruitment workflows (candidates → interviews → offers)
- Large realistic TCS-like sample data volume

Instructions:
1. Ensure the schema file has already been executed.
2. Open **tcs_emp_db_dummy_data.sql** in MySQL Workbench.
3. Run the entire script.

This will populate the database with full-scale sample data for testing queries.

=====================================================
3. ER DIAGRAM REVIEW
=====================================================
File: tcs_emp_db_er_diagram.pdf

This PDF contains:
- The complete Entity-Relationship diagram
- Showing all key entities such as Employee, Project, Client, Vendor,
  Payroll, Timesheets, Procurement, Helpdesk, Training, Recruitment, Billing
- All foreign key relationships, cardinalities, and attribute types

Use this diagram to verify:
- Schema correctness
- Table relationships
- Normalization level
- Overall project complexity

=====================================================
ABOUT THE PROJECT
=====================================================

This DBMS project represents a full-scale 
TCS Employee & Operations Management System.

Included modules:

-Employee master data  
-Departments, roles, skills  
-Projects, assignments & contracts  
-Payroll, expenses, travel, performance reviews  
-Recruitment lifecycle (candidates → interviews → offers)  
-IT helpdesk & SLA tracking  
-Procurement, vendors, inventory & asset management  
-Billing (invoices + line items)  
-Training & employee development  
-Security (user accounts, roles, audit logs)  
-Archive tables and history logs  

The project demonstrates:
- High normalization
- Multiple interlinked modules
- Complex joins across business functions
- Practical real-world relevance (TCS/IT industry)

This satisfies the evaluation parameters:
A. Complexity of organization  
B. Total entities in the design  
C. Depth of attributes per table  
D. Memory-efficient datatype selection  

=====================================================
STUDENT DETAILS
=====================================================


Group 2  
Yash Bhardwaj (341169)
Aviral Bansal (341148)    
Shreya Wadhwa (341171)

Presented to:
Prof. Ashok K Harnal

