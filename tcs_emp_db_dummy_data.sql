USE tcs_emp_db;
--------------------------------------------------
-- 1. Lookup tables: office_location, role_type, skill_master
--------------------------------------------------

-- Add more office locations (we already have 1 & 2)
INSERT INTO office_location (office_id, city, state, country, tz) VALUES
(3,'Pune','Maharashtra','India','Asia/Kolkata'),
(4,'Hyderabad','Telangana','India','Asia/Kolkata'),
(5,'Chennai','Tamil Nadu','India','Asia/Kolkata'),
(6,'New Delhi','Delhi','India','Asia/Kolkata'),
(7,'Noida','Uttar Pradesh','India','Asia/Kolkata'),
(8,'Kolkata','West Bengal','India','Asia/Kolkata'),
(9,'Gurugram','Haryana','India','Asia/Kolkata'),
(10,'Nagpur','Maharashtra','India','Asia/Kolkata');

-- Add more role types (existing 1–5)
INSERT INTO role_type (role_id, role_name) VALUES
(6,'IT Support'),
(7,'Solution Architect'),
(8,'Consultant'),
(9,'Trainee'),
(10,'Database Admin');

-- Add more skills (existing 1–5)
INSERT INTO skill_master (skill_id, name) VALUES
(6,'Kubernetes'),
(7,'Python'),
(8,'Microservices'),
(9,'Azure'),
(10,'DevOps');

--------------------------------------------------
-- 2. Departments & Clients & Vendors
--------------------------------------------------

-- Departments (already 10,20,30)
INSERT INTO department (dept_id, name, manager_emp_id, business_unit) VALUES
(40,'Sales',NULL,'Sales & BD'),
(50,'Operations',NULL,'Delivery'),
(60,'Quality Assurance',NULL,'QA'),
(70,'DevOps',NULL,'Platform'),
(80,'Legal',NULL,'Compliance'),
(90,'Marketing',NULL,'Branding'),
(100,'Analytics',NULL,'Data & Insights');

-- Clients (already 1,2)
INSERT INTO client (client_id, name, industry, country) VALUES
(3,'FinTrust Bank','Banking','UK'),
(4,'ShopEase','E-commerce','USA'),
(5,'Sunrise Health','Healthcare','India'),
(6,'Metro Rail Corp','Transportation','India'),
(7,'EduSmart','EdTech','Singapore'),
(8,'GreenGrid Energy','Energy','Germany'),
(9,'SkyNet Logistics','Logistics','UAE'),
(10,'NeoRetail','Retail','India');

-- Vendors (already 1)
INSERT INTO vendor (vendor_id, name, service_type, country) VALUES
(2,'CloudWare Solutions','Cloud Services','India'),
(3,'SecureNet Pvt Ltd','Security','India'),
(4,'SoftLine','Software Licenses','USA'),
(5,'TechHire','Staffing','India'),
(6,'OfficeBasics','Stationery','India'),
(7,'DataDrives','Storage Hardware','Singapore'),
(8,'PrintWorks','Printing','India'),
(9,'TravelBuddy','Corporate Travel','India'),
(10,'CleanIt','Facility Management','India');

--------------------------------------------------
-- 3. Employees (we have emp_id 1 & 2)
--------------------------------------------------

INSERT INTO employee
(emp_id, emp_code, first_name, last_name, dob, gender, hire_date,
 dept_id, office_id, role_id, email, phone, status)
VALUES
(3,'TCS1003','Rahul','Mehta','1991-02-10','M','2017-01-10',10,3,1,'rahul.mehta@tcs.com','+91-9810000003','active'),
(4,'TCS1004','Priya','Singh','1993-07-22','F','2019-04-01',20,1,3,'priya.singh@tcs.com','+91-9810000004','active'),
(5,'TCS1005','Karan','Gupta','1989-12-05','M','2015-09-20',30,2,4,'karan.gupta@tcs.com','+91-9810000005','active'),
(6,'TCS1006','Ananya','Iyer','1994-03-18','F','2020-02-15',10,4,7,'ananya.iyer@tcs.com','+91-9810000006','active'),
(7,'TCS1007','Suresh','Kumar','1988-10-30','M','2014-06-10',40,5,2,'suresh.kumar@tcs.com','+91-9810000007','active'),
(8,'TCS1008','Meera','Nair','1995-01-25','F','2021-08-05',50,6,6,'meera.nair@tcs.com','+91-9810000008','active'),
(9,'TCS1009','Arjun','Das','1990-09-12','M','2016-03-12',60,7,1,'arjun.das@tcs.com','+91-9810000009','active'),
(10,'TCS1010','Divya','Rao','1992-06-17','F','2018-11-01',70,8,8,'divya.rao@tcs.com','+91-9810000010','active');

-- Optionally set some managers
UPDATE department SET manager_emp_id = 3 WHERE dept_id = 20;
UPDATE department SET manager_emp_id = 5 WHERE dept_id = 30;
UPDATE department SET manager_emp_id = 7 WHERE dept_id = 40;

--------------------------------------------------
-- 4. Service Catalog & SLA
--------------------------------------------------

-- More services (already 1,2)
INSERT INTO service_catalog (service_id, name, category, default_sla_days) VALUES
(3,'Email Support','IT',2),
(4,'Desktop Support','IT',3),
(5,'Network Monitoring','Network',1),
(6,'Database Support','DBA',3),
(7,'Security Review','Security',7),
(8,'Onboarding Support','HR',5),
(9,'Offboarding Support','HR',3),
(10,'Reporting Support','BI',4);

-- SLA entries (already sla_id 1)
INSERT INTO sla (sla_id, service_id, priority, response_time_hrs, resolution_time_hrs) VALUES
(2,1,2,2,48),
(3,2,1,4,72),
(4,3,1,1,24),
(5,4,2,4,48),
(6,5,1,1,12),
(7,6,2,4,72),
(8,7,1,2,168),
(9,8,3,8,120),
(10,9,2,4,72);

--------------------------------------------------
-- 5. Projects & Contracts
--------------------------------------------------

-- More projects (already project_id 1)
INSERT INTO project
(project_id, project_code, name, client_id, start_date, end_date,
 budget, project_manager, status, visibility)
VALUES
(2,'PRJ-FIN-002','Core Banking Upgrade',3,'2024-04-01',NULL,15000000.00,5,'active','internal'),
(3,'PRJ-SHOP-003','E-commerce Revamp',4,'2025-02-10',NULL,9000000.00,3,'planning','client'),
(4,'PRJ-HEALTH-004','Patient Portal',5,'2025-01-01',NULL,6000000.00,6,'active','client'),
(5,'PRJ-METRO-005','Ticketing System',6,'2024-09-15',NULL,11000000.00,7,'active','internal'),
(6,'PRJ-EDU-006','LMS Migration',7,'2025-03-20',NULL,5000000.00,4,'planning','client'),
(7,'PRJ-ENERGY-007','IoT Meter Rollout',8,'2024-11-01',NULL,8000000.00,1,'active','internal'),
(8,'PRJ-LOG-008','Fleet Optimization',9,'2025-05-01',NULL,7000000.00,2,'active','internal'),
(9,'PRJ-RETAIL-009','POS Modernization',10,'2024-08-01',NULL,6500000.00,3,'active','client'),
(10,'PRJ-ANL-010','Customer Analytics Platform',3,'2025-04-10',NULL,12000000.00,10,'planning','confidential');

-- More contracts (already contract_id 1)
INSERT INTO contract
(contract_id, client_id, project_id, signed_date, value, contract_type, status)
VALUES
(2,3,2,'2024-03-15',14500000.00,'Time & Material','active'),
(3,4,3,'2025-01-20',8800000.00,'Fixed Price','signed'),
(4,5,4,'2024-12-10',5800000.00,'Fixed Price','active'),
(5,6,5,'2024-08-25',10500000.00,'Time & Material','active'),
(6,7,6,'2025-03-01',4800000.00,'Fixed Price','draft'),
(7,8,7,'2024-10-10',7900000.00,'Fixed Price','active'),
(8,9,8,'2025-04-05',6900000.00,'Fixed Price','active'),
(9,10,9,'2024-07-10',6300000.00,'Time & Material','closed'),
(10,3,10,'2025-04-01',11800000.00,'Fixed Price','negotiation');

--------------------------------------------------
-- 6. Project Assignments & Timesheets
--------------------------------------------------

-- More project assignments (already (1,1) & (1,2))
INSERT INTO project_assignment
(project_id, emp_id, role_on_project, allocation_percent, start_date, end_date)
VALUES
(2,3,'Backend Developer',70,'2024-04-01',NULL),
(2,5,'Tech Lead',50,'2024-04-01',NULL),
(3,6,'Solution Architect',60,'2025-02-10',NULL),
(3,4,'Business Analyst',50,'2025-02-10',NULL),
(4,8,'QA Engineer',80,'2025-01-01',NULL),
(5,7,'Project Manager',70,'2024-09-15',NULL),
(7,1,'Senior Developer',40,'2024-11-01',NULL),
(8,2,'Frontend Developer',60,'2025-05-01',NULL);

-- More timesheet entries (already ts_id 1)
INSERT INTO timesheet_entry
(ts_id, emp_id, work_date, hours_worked, project_id, description)
VALUES
(2,3,'2025-11-11',7.50,2,'Module design'),
(3,4,'2025-11-11',8.00,3,'Requirement workshop'),
(4,5,'2025-11-12',6.00,2,'Code review'),
(5,6,'2025-11-12',8.00,3,'Architecture discussion'),
(6,7,'2025-11-13',7.00,5,'Client demo prep'),
(7,8,'2025-11-13',8.00,4,'Test case execution'),
(8,9,'2025-11-14',7.50,8,'Data analysis'),
(9,10,'2025-11-14',8.00,10,'Dashboard POC'),
(10,2,'2025-11-15',4.00,1,'Bug fixes');

--------------------------------------------------
-- 7. Assets, Inventory, Procurement
--------------------------------------------------

-- More assets (already asset_id 1)
INSERT INTO asset
(asset_id, tag, asset_type, model, purchased_on, current_holder, value, status)
VALUES
(2,'AS-0002','Laptop','HP EliteBook','2023-11-10',2,120000.00,'in-use'),
(3,'AS-0003','Monitor','Dell 24\"','2024-01-20',3,20000.00,'in-use'),
(4,'AS-0004','Phone','iPhone 13','2023-09-05',4,80000.00,'in-use'),
(5,'AS-0005','Laptop','Lenovo ThinkPad','2024-02-15',5,110000.00,'in-use'),
(6,'AS-0006','Server','HP ProLiant','2022-08-01',NULL,300000.00,'in-storage'),
(7,'AS-0007','Router','Cisco 2900','2021-06-12',NULL,90000.00,'in-use'),
(8,'AS-0008','Headset','Logitech Pro','2024-05-19',6,5000.00,'in-use'),
(9,'AS-0009','Docking Station','Dell WD19','2024-03-08',7,9000.00,'in-use'),
(10,'AS-0010','Printer','HP LaserJet','2022-10-25',NULL,25000.00,'in-use');

-- More inventory items (already item_id 1)
INSERT INTO inventory_item
(item_id, name, quantity, unit, location_id, min_reorder)
VALUES
(2,'HDMI Cable',50,'pcs',1,10),
(3,'Mouse',40,'pcs',2,10),
(4,'Keyboard',30,'pcs',3,5),
(5,'LAN Switch',10,'pcs',4,2),
(6,'SSD 1TB',15,'pcs',5,3),
(7,'UPS 1KVA',5,'pcs',6,1),
(8,'Office Chair',20,'pcs',7,5),
(9,'Desk Phones',12,'pcs',8,3),
(10,'Whiteboard Markers',100,'pcs',9,20);

-- More procurement orders (already po_id 1)
INSERT INTO procurement_order
(po_id, vendor_id, raised_by, created_date, total_amount, status)
VALUES
(2,2,3,'2025-10-01 10:00:00',500000.00,'approved'),
(3,3,4,'2025-09-15 11:30:00',200000.00,'open'),
(4,4,5,'2025-08-20 14:10:00',350000.00,'received'),
(5,5,6,'2025-07-05 16:45:00',150000.00,'approved'),
(6,6,7,'2025-06-18 09:15:00',75000.00,'open'),
(7,7,8,'2025-05-10 13:20:00',420000.00,'approved'),
(8,8,9,'2025-04-03 15:00:00',90000.00,'cancelled'),
(9,9,10,'2025-03-12 11:05:00',180000.00,'approved'),
(10,10,2,'2025-02-22 10:10:00',60000.00,'received');

--------------------------------------------------
-- 8. Candidates, Interviews, Offers
--------------------------------------------------

-- More candidates (already 1)
INSERT INTO candidate
(candidate_id, full_name, email, applied_for, source, applied_on)
VALUES
(2,'Aditi Sharma','aditi.sharma@example.com','Business Analyst','Naukri','2025-10-12'),
(3,'Vikram Rao','vikram.rao@example.com','Project Manager','Referral','2025-10-15'),
(4,'Sneha Kulkarni','sneha.k@example.com','QA Engineer','LinkedIn','2025-10-18'),
(5,'Rohan Patil','rohan.patil@example.com','DevOps Engineer','Company Website','2025-10-20'),
(6,'Isha Jain','isha.jain@example.com','Data Analyst','Campus','2025-10-22'),
(7,'Nikhil Arora','nikhil.arora@example.com','Software Engineer','Referral','2025-10-25'),
(8,'Pooja Desai','pooja.desai@example.com','HR Executive','LinkedIn','2025-10-27'),
(9,'Tarun Verma','tarun.verma@example.com','Cloud Architect','Naukri','2025-10-29'),
(10,'Kriti Malhotra','kriti.m@example.com','Product Manager','Company Website','2025-11-01');

-- More interviews (already interview_id 1)
INSERT INTO interview
(interview_id, candidate_id, interviewer_id, interview_date, mode, score, notes)
VALUES
(2,2,3,'2025-10-22','online',82,'Good analytical skills'),
(3,3,7,'2025-10-25','on-site',75,'Strong leadership'),
(4,4,6,'2025-10-26','online',80,'Solid QA fundamentals'),
(5,5,7,'2025-10-27','online',78,'Strong DevOps basics'),
(6,6,5,'2025-10-28','online',85,'Excellent SQL and Excel'),
(7,7,1,'2025-10-29','on-site',88,'Very good coding skills'),
(8,8,4,'2025-10-30','online',76,'Good communication'),
(9,9,6,'2025-11-01','on-site',82,'Good design thinking'),
(10,10,3,'2025-11-02','online',79,'Product mindset');

-- More offers (already offer_id 1)
INSERT INTO offer_letter
(offer_id, candidate_id, offered_role, offered_ctc, offer_date, accepted, joining_date)
VALUES
(2,2,'Business Analyst',750000.00,'2025-10-28',1,'2025-12-01'),
(3,3,'Project Manager',1500000.00,'2025-10-30',0,NULL),
(4,4,'QA Engineer',650000.00,'2025-10-31',1,'2025-12-05'),
(5,5,'DevOps Engineer',900000.00,'2025-11-01',1,'2025-12-10'),
(6,6,'Data Analyst',800000.00,'2025-11-02',1,'2025-12-15'),
(7,7,'Software Engineer',850000.00,'2025-11-03',0,NULL),
(8,8,'HR Executive',600000.00,'2025-11-04',1,'2025-12-20'),
(9,9,'Cloud Architect',1600000.00,'2025-11-05',0,NULL),
(10,10,'Product Manager',1400000.00,'2025-11-06',1,'2026-01-02');

--------------------------------------------------
-- 9. Training & Employee Training
--------------------------------------------------

-- More training sessions (already training_id 1)
INSERT INTO training_session
(training_id, title, start_date, end_date, trainer, location_id)
VALUES
(2,'Advanced Java','2025-06-01','2025-06-03','A. Sharma',1),
(3,'React Deep Dive','2025-06-10','2025-06-12','N. Roy',2),
(4,'SQL Performance Tuning','2025-06-15','2025-06-16','K. Gupta',3),
(5,'Cloud Fundamentals','2025-06-20','2025-06-22','R. Patel',4),
(6,'DevOps Practices','2025-06-25','2025-06-27','S. Kumar',5),
(7,'Soft Skills Workshop','2025-07-01','2025-07-01','P. Singh',6),
(8,'Leadership Essentials','2025-07-05','2025-07-06','A. Iyer',7),
(9,'Data Analytics Intro','2025-07-10','2025-07-11','D. Rao',8),
(10,'Information Security Basics','2025-07-15','2025-07-16','M. Nair',9);

-- More employee training records (already (1,1))
INSERT INTO employee_training
(emp_id, training_id, status, score)
VALUES
(2,2,'completed',88),
(3,3,'completed',90),
(4,4,'completed',86),
(5,5,'completed',80),
(6,6,'completed',92),
(7,7,'completed',85),
(8,8,'completed',87),
(9,9,'completed',89),
(10,10,'registered',NULL);

--------------------------------------------------
-- 10. Skills for employees
--------------------------------------------------

-- More employee_skill rows (already 3 rows)
INSERT INTO employee_skill (emp_id, skill_id, proficiency, last_used_year) VALUES
(3,1,8,2025),
(3,2,7,2025),
(4,3,8,2025),
(5,2,9,2025),
(6,4,9,2025),
(7,5,7,2024),
(8,7,8,2025),
(9,8,7,2024),
(10,9,8,2025),
(10,10,9,2025);

--------------------------------------------------
-- 11. Payroll, Expense Reports, Travel
--------------------------------------------------

-- More payroll rows (already payroll_id 1 for emp 1)
INSERT INTO payroll
(payroll_id, emp_id, pay_period_start, pay_period_end, gross_amount, tax_deduction, net_amount, paid_date)
VALUES
(2,2,'2025-10-01','2025-10-31',220000.00,44000.00,176000.00,'2025-11-01'),
(3,3,'2025-10-01','2025-10-31',210000.00,42000.00,168000.00,'2025-11-01'),
(4,4,'2025-10-01','2025-10-31',180000.00,36000.00,144000.00,'2025-11-01'),
(5,5,'2025-10-01','2025-10-31',250000.00,50000.00,200000.00,'2025-11-01'),
(6,6,'2025-10-01','2025-10-31',190000.00,38000.00,152000.00,'2025-11-01'),
(7,7,'2025-10-01','2025-10-31',260000.00,52000.00,208000.00,'2025-11-01'),
(8,8,'2025-10-01','2025-10-31',170000.00,34000.00,136000.00,'2025-11-01'),
(9,9,'2025-10-01','2025-10-31',200000.00,40000.00,160000.00,'2025-11-01'),
(10,10,'2025-10-01','2025-10-31',230000.00,46000.00,184000.00,'2025-11-01');

-- More expense reports (already expense_id 1)
INSERT INTO expense_report
(expense_id, emp_id, submitted_date, amount, currency, status, project_id)
VALUES
(2,2,'2025-11-10 09:00:00',2500.00,'INR','submitted',1),
(3,3,'2025-11-11 10:15:00',3200.00,'INR','approved',2),
(4,4,'2025-11-11 11:45:00',1800.00,'INR','rejected',3),
(5,5,'2025-11-12 12:30:00',4500.00,'INR','submitted',2),
(6,6,'2025-11-12 14:00:00',6000.00,'INR','approved',3),
(7,7,'2025-11-13 15:10:00',2200.00,'INR','submitted',5),
(8,8,'2025-11-13 16:20:00',3000.00,'INR','approved',4),
(9,9,'2025-11-14 17:30:00',2750.00,'INR','submitted',8),
(10,10,'2025-11-15 18:45:00',5000.00,'INR','approved',10);

-- More travel requests (already travel_id 1)
INSERT INTO travel_request
(travel_id, emp_id, from_city, to_city, start_date, end_date, purpose, approved_by, status)
VALUES
(2,3,'Mumbai','Pune','2025-12-05','2025-12-06','Project workshop',1,'approved'),
(3,4,'Bengaluru','Hyderabad','2025-12-08','2025-12-09','Client visit',3,'pending'),
(4,5,'Chennai','Mumbai','2025-12-10','2025-12-12','Steering committee',7,'approved'),
(5,6,'Delhi','Kolkata','2025-12-15','2025-12-17','Architecture review',5,'pending'),
(6,7,'Mumbai','Dubai','2025-12-18','2025-12-20','Vendor meeting',1,'approved'),
(7,8,'Bengaluru','Singapore','2025-12-22','2025-12-25','Training',2,'approved'),
(8,9,'Pune','Delhi','2025-12-26','2025-12-27','Internal workshop',4,'pending'),
(9,10,'Hyderabad','Chennai','2025-12-28','2025-12-29','KT session',6,'approved'),
(10,2,'Mumbai','Jaipur','2025-12-30','2026-01-02','Team offsite',7,'approved');

--------------------------------------------------
-- 12. Helpdesk Tickets
--------------------------------------------------

-- More helpdesk tickets (already ticket_id 1)
INSERT INTO helpdesk_ticket
(ticket_id, created_by, assigned_to, created_at, closed_at, priority, status, category, subject, sla_id)
VALUES
(2,3,6,'2025-11-20 10:00:00',NULL,1,'open','Network','Internet down on floor 3',6),
(3,4,8,'2025-11-20 11:15:00',NULL,2,'open','Hardware','Keyboard not working',2),
(4,5,6,'2025-11-20 12:30:00',NULL,3,'open','Software','Outlook crash',3),
(5,6,7,'2025-11-21 09:45:00',NULL,1,'open','Security','Suspicious email reported',7),
(6,7,2,'2025-11-21 10:10:00',NULL,2,'open','Access','VPN access required',2),
(7,8,3,'2025-11-21 11:20:00',NULL,3,'open','HR','Payslip not visible',9),
(8,9,4,'2025-11-22 09:00:00',NULL,2,'open','IT','Laptop slow',4),
(9,10,5,'2025-11-22 09:30:00',NULL,1,'open','DB','Slow query reported',6),
(10,2,1,'2025-11-22 10:00:00',NULL,2,'open','Reporting','BI dashboard issue',10);

--------------------------------------------------
-- 13. Invoices & Line Items
--------------------------------------------------

-- More invoices (already invoice_id 1)
INSERT INTO invoice
(invoice_id, client_id, project_id, issued_date, due_date, currency, total_amount, status)
VALUES
(2,3,2,'2025-11-05','2025-12-05','INR',14500000.00,'issued'),
(3,4,3,'2025-11-10','2025-12-10','USD',8800000.00,'draft'),
(4,5,4,'2025-11-15','2025-12-15','INR',5800000.00,'issued'),
(5,6,5,'2025-11-18','2025-12-18','INR',10500000.00,'issued'),
(6,7,6,'2025-11-20','2025-12-20','INR',4800000.00,'draft'),
(7,8,7,'2025-11-22','2025-12-22','EUR',7900000.00,'issued'),
(8,9,8,'2025-11-25','2025-12-25','AED',6900000.00,'issued'),
(9,10,9,'2025-11-26','2025-12-26','INR',6300000.00,'issued'),
(10,3,10,'2025-11-27','2025-12-27','GBP',11800000.00,'draft');

-- More invoice line items (already line_id 1)
INSERT INTO invoice_line_item
(line_id, invoice_id, description, qty, unit_price)
VALUES
(2,2,'Core Banking Dev Services',1,14500000.00),
(3,3,'E-commerce Consulting',1,8800000.00),
(4,4,'Patient Portal Implementation',1,5800000.00),
(5,5,'Ticketing System Development',1,10500000.00),
(6,6,'LMS Migration',1,4800000.00),
(7,7,'IoT Implementation',1,7900000.00),
(8,8,'Fleet Optimization Solution',1,6900000.00),
(9,9,'POS Modernization',1,6300000.00),
(10,10,'Analytics Platform Build',1,11800000.00);

--------------------------------------------------
-- 14. Performance reviews & User accounts
--------------------------------------------------

-- More performance reviews (already review_id 1)
INSERT INTO performance_review
(review_id, emp_id, review_period_start, review_period_end, reviewer_id, rating, comments)
VALUES
(2,2,'2024-04-01','2025-03-31',1,4,'Consistent performer'),
(3,3,'2024-04-01','2025-03-31',1,5,'High potential'),
(4,4,'2024-04-01','2025-03-31',2,3,'Needs improvement in documentation'),
(5,5,'2024-04-01','2025-03-31',3,4,'Strong domain knowledge'),
(6,6,'2024-04-01','2025-03-31',5,5,'Excellent architecture skills'),
(7,7,'2024-04-01','2025-03-31',2,4,'Good leadership on metro project'),
(8,8,'2024-04-01','2025-03-31',4,4,'Very good QA coverage'),
(9,9,'2024-04-01','2025-03-31',3,4,'Analytical and proactive'),
(10,10,'2024-04-01','2025-03-31',1,5,'Key contributor to analytics initiative');

-- More user accounts (already user_id 1 for emp 1)
INSERT INTO user_account
(user_id, emp_id, username, password_hash, role_id, last_login, active)
VALUES
(2,2,'neha.roy','{HASHED_PW_PLACEHOLDER}',1,'2025-11-25 09:00:00',1),
(3,3,'rahul.mehta','{HASHED_PW_PLACEHOLDER}',1,'2025-11-25 09:10:00',1),
(4,4,'priya.singh','{HASHED_PW_PLACEHOLDER}',3,'2025-11-25 09:20:00',1),
(5,5,'karan.gupta','{HASHED_PW_PLACEHOLDER}',4,'2025-11-25 09:30:00',1),
(6,6,'ananya.iyer','{HASHED_PW_PLACEHOLDER}',7,'2025-11-25 09:40:00',1),
(7,7,'suresh.kumar','{HASHED_PW_PLACEHOLDER}',2,'2025-11-25 09:50:00',1),
(8,8,'meera.nair','{HASHED_PW_PLACEHOLDER}',6,'2025-11-25 10:00:00',1),
(9,9,'arjun.das','{HASHED_PW_PLACEHOLDER}',1,'2025-11-25 10:10:00',1),
(10,10,'divya.rao','{HASHED_PW_PLACEHOLDER}',8,'2025-11-25 10:20:00',1);