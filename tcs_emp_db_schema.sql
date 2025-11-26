-- Below is the Database File for TCS Employee as part of DBMS project
-- Made By Group- 2 
-- Yash Bhardwaj (341169) , Aviral Bansal (341148), Shreya Wadhwa (341171)
-- Submitted to Prof. Ashok K Harnal


CREATE DATABASE IF NOT EXISTS tcs_emp_db;
USE tcs_emp_db;


-- ===== Lookup tables =====
CREATE TABLE `role_type` (
  `role_id` SMALLINT UNSIGNED PRIMARY KEY,
  `role_name` VARCHAR(40) NOT NULL
) ENGINE=InnoDB;

INSERT INTO role_type VALUES
(1,'Employee'),(2,'Manager'),(3,'HR'),(4,'Finance'),(5,'Admin');

CREATE TABLE `office_location` (
  `office_id` SMALLINT UNSIGNED PRIMARY KEY,
  `city` VARCHAR(50) NOT NULL,
  `state` VARCHAR(50),
  `country` VARCHAR(50) NOT NULL,
  `tz` VARCHAR(50) DEFAULT 'Asia/Kolkata'
) ENGINE=InnoDB;

INSERT INTO office_location VALUES
(1,'Mumbai','Maharashtra','India','Asia/Kolkata'),
(2,'Bengaluru','Karnataka','India','Asia/Kolkata');

CREATE TABLE `skill_master` (
  `skill_id` SMALLINT UNSIGNED PRIMARY KEY,
  `name` VARCHAR(80) NOT NULL
) ENGINE=InnoDB;

INSERT INTO skill_master VALUES
(1,'Java'),(2,'SQL'),(3,'React'),(4,'AWS'),(5,'Docker');

-- ===== Core HR / Employee =====
CREATE TABLE `department` (
  `dept_id` SMALLINT UNSIGNED PRIMARY KEY,
  `name` VARCHAR(80) NOT NULL,
  `manager_emp_id` INT NULL,
  `business_unit` VARCHAR(80)
) ENGINE=InnoDB;

CREATE TABLE `employee` (
  `emp_id` INT AUTO_INCREMENT PRIMARY KEY,
  `emp_code` VARCHAR(16) UNIQUE NOT NULL,
  `first_name` VARCHAR(40) NOT NULL,
  `last_name` VARCHAR(40),
  `dob` DATE,
  `gender` ENUM('M','F','O') DEFAULT 'O',
  `hire_date` DATE NOT NULL,
  `dept_id` SMALLINT UNSIGNED NOT NULL,
  `office_id` SMALLINT UNSIGNED NOT NULL,
  `role_id` SMALLINT UNSIGNED NOT NULL,
  `email` VARCHAR(120) UNIQUE,
  `phone` VARCHAR(20),
  `status` ENUM('active','on-leave','resigned','terminated') DEFAULT 'active',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (dept_id) REFERENCES department(dept_id) ON DELETE RESTRICT,
  FOREIGN KEY (office_id) REFERENCES office_location(office_id) ON DELETE RESTRICT,
  FOREIGN KEY (role_id) REFERENCES role_type(role_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- set department.manager_emp_id after employee creation using Foreign Key
ALTER TABLE department ADD CONSTRAINT fk_manager_emp FOREIGN KEY (manager_emp_id) REFERENCES employee(emp_id) ON DELETE SET NULL;

INSERT INTO department (dept_id, name, business_unit) VALUES (10,'Engineering','Products'),(20,'Human Resources','People Ops'),(30,'Finance','Finance & Accounts');

INSERT INTO employee (emp_code, first_name, last_name, dob, hire_date, dept_id, office_id, role_id, email, phone)
VALUES
('TCS1001','Amit','Shah','1990-05-14','2016-07-01',10,1,2,'amit.shah@tcs.com','+91-9810000001'),
('TCS1002','Neha','Roy','1992-11-03','2018-09-15',10,2,1,'neha.roy@tcs.com','+91-9810000002');

UPDATE department SET manager_emp_id = 1 WHERE dept_id = 10;

CREATE TABLE `employee_skill` (
  `emp_id` INT NOT NULL,
  `skill_id` SMALLINT UNSIGNED NOT NULL,
  `proficiency` TINYINT UNSIGNED CHECK (proficiency BETWEEN 1 AND 10),
  `last_used_year` SMALLINT,
  PRIMARY KEY (emp_id, skill_id),
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY (skill_id) REFERENCES skill_master(skill_id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO employee_skill VALUES (1,1,9,2024),(1,4,7,2025),(2,3,8,2025);

CREATE TABLE `certification` (
  `cert_id` INT AUTO_INCREMENT PRIMARY KEY,
  `emp_id` INT NOT NULL,
  `cert_name` VARCHAR(120) NOT NULL,
  `provider` VARCHAR(80),
  `obtained_date` DATE,
  `expiry_date` DATE,
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO certification (emp_id, cert_name, provider, obtained_date, expiry_date)
VALUES (1,'AWS Solutions Architect','AWS','2021-10-10','2024-10-09'),(2,'Oracle SQL Certified','Oracle','2019-06-01',NULL);

CREATE TABLE `training_session` (
  `training_id` INT AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(160) NOT NULL,
  `start_date` DATE,
  `end_date` DATE,
  `trainer` VARCHAR(80),
  `location_id` SMALLINT UNSIGNED,
  FOREIGN KEY (location_id) REFERENCES office_location(office_id)
) ENGINE=InnoDB;

INSERT INTO training_session (title, start_date, end_date, trainer, location_id)
VALUES ('Cloud Upskilling','2025-05-01','2025-05-03','R. Patel',2);

CREATE TABLE `employee_training` (
  `emp_id` INT NOT NULL,
  `training_id` INT NOT NULL,
  `status` VARCHAR(20) DEFAULT 'completed',
  `score` SMALLINT,
  PRIMARY KEY (emp_id, training_id),
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY (training_id) REFERENCES training_session(training_id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO employee_training VALUES (1,1,'completed',85);

-- Timesheets with project link
CREATE TABLE `timesheet_entry` (
  `ts_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `emp_id` INT NOT NULL,
  `work_date` DATE NOT NULL,
  `hours_worked` DECIMAL(4,2) CHECK (hours_worked >= 0 AND hours_worked <= 24),
  `project_id` INT NULL,
  `description` TEXT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO timesheet_entry (emp_id, work_date, hours_worked, description) VALUES (1,'2025-11-10',8.00,'Feature development');

-- ===== Projects / Clients / Contracts =====
CREATE TABLE `client` (
  `client_id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(120) NOT NULL,
  `industry` VARCHAR(80),
  `country` VARCHAR(60)
) ENGINE=InnoDB;

INSERT INTO client (name, industry, country) VALUES ('ACME Corp','Oil & Gas','USA'),('MedLife','Healthcare','India');

CREATE TABLE `project` (
  `project_id` INT AUTO_INCREMENT PRIMARY KEY,
  `project_code` VARCHAR(40) UNIQUE NOT NULL,
  `name` VARCHAR(140) NOT NULL,
  `client_id` INT NOT NULL,
  `start_date` DATE,
  `end_date` DATE,
  `budget` DECIMAL(14,2),
  `project_manager` INT,
  `status` VARCHAR(20) DEFAULT 'planning',
  `visibility` ENUM('internal','client','confidential') DEFAULT 'internal',
  FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE RESTRICT,
  FOREIGN KEY (project_manager) REFERENCES employee(emp_id) ON DELETE SET NULL
) ENGINE=InnoDB;

INSERT INTO project (project_code, name, client_id, start_date, budget, project_manager, status)
VALUES ('PRJ-ACME-001','Refinery Migration',1,'2025-01-15',12500000.00,1,'active');

CREATE TABLE `project_assignment` (
  `project_id` INT NOT NULL,
  `emp_id` INT NOT NULL,
  `role_on_project` VARCHAR(60),
  `allocation_percent` TINYINT UNSIGNED CHECK (allocation_percent BETWEEN 0 AND 100),
  `start_date` DATE,
  `end_date` DATE,
  PRIMARY KEY (project_id, emp_id),
  FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE,
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO project_assignment VALUES (1,1,'Lead Developer',60,'2025-01-15',NULL),(1,2,'Frontend Developer',40,'2025-01-15',NULL);

CREATE TABLE `contract` (
  `contract_id` INT AUTO_INCREMENT PRIMARY KEY,
  `client_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  `signed_date` DATE,
  `value` DECIMAL(15,2),
  `contract_type` VARCHAR(40),
  `status` VARCHAR(20),
  FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE CASCADE,
  FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO contract (client_id, project_id, signed_date, value, contract_type, status)
VALUES (1,1,'2025-01-10',12000000.00,'Fixed Price','active');

-- ===== Vendors, Procurement, Inventory & Assets =====
CREATE TABLE `vendor` (
  `vendor_id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(120) NOT NULL,
  `service_type` VARCHAR(80),
  `country` VARCHAR(60)
) ENGINE=InnoDB;

INSERT INTO vendor (name, service_type, country) VALUES ('Global Infra Ltd','Hardware','India');

CREATE TABLE `procurement_order` (
  `po_id` INT AUTO_INCREMENT PRIMARY KEY,
  `vendor_id` INT NOT NULL,
  `raised_by` INT NOT NULL,
  `created_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `total_amount` DECIMAL(13,2),
  `status` VARCHAR(20) DEFAULT 'open',
  FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id),
  FOREIGN KEY (raised_by) REFERENCES employee(emp_id)
) ENGINE=InnoDB;

INSERT INTO procurement_order (vendor_id, raised_by, total_amount, status) VALUES (1,2,250000.00,'approved');

CREATE TABLE `asset` (
  `asset_id` INT AUTO_INCREMENT PRIMARY KEY,
  `tag` VARCHAR(40) UNIQUE,
  `asset_type` VARCHAR(60),
  `model` VARCHAR(80),
  `purchased_on` DATE,
  `current_holder` INT,
  `value` DECIMAL(12,2),
  `status` VARCHAR(30) DEFAULT 'in-use',
  FOREIGN KEY (current_holder) REFERENCES employee(emp_id)
) ENGINE=InnoDB;

INSERT INTO asset (tag, asset_type, model, purchased_on, current_holder, value) VALUES ('AS-0001','Laptop','Dell XPS 15','2024-02-01',1,150000.00);

CREATE TABLE `inventory_item` (
  `item_id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(120) NOT NULL,
  `quantity` INT DEFAULT 0,
  `unit` VARCHAR(20) DEFAULT 'pcs',
  `location_id` SMALLINT UNSIGNED,
  `min_reorder` INT DEFAULT 1,
  FOREIGN KEY (location_id) REFERENCES office_location(office_id)
) ENGINE=InnoDB;

INSERT INTO inventory_item (name, quantity, unit, location_id, min_reorder) VALUES ('Ethernet Cable',100,'pcs',1,10);

-- ===== Helpdesk / Tickets =====
CREATE TABLE `helpdesk_ticket` (
  `ticket_id` INT AUTO_INCREMENT PRIMARY KEY,
  `created_by` INT NOT NULL,
  `assigned_to` INT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `closed_at` DATETIME,
  `priority` TINYINT DEFAULT 3,
  `status` VARCHAR(20) DEFAULT 'open',
  `category` VARCHAR(80),
  `subject` VARCHAR(160),
  `sla_id` INT,
  FOREIGN KEY (created_by) REFERENCES employee(emp_id),
  FOREIGN KEY (assigned_to) REFERENCES employee(emp_id)
) ENGINE=InnoDB;

INSERT INTO helpdesk_ticket (created_by, assigned_to, priority, category, subject) VALUES (2,1,2,'IT','VPN not connecting');

-- ===== Finance / Payroll / Expense / Billing =====
CREATE TABLE `payroll` (
  `payroll_id` INT AUTO_INCREMENT PRIMARY KEY,
  `emp_id` INT NOT NULL,
  `pay_period_start` DATE,
  `pay_period_end` DATE,
  `gross_amount` DECIMAL(12,2),
  `tax_deduction` DECIMAL(12,2),
  `net_amount` DECIMAL(12,2),
  `paid_date` DATE,
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO payroll (emp_id, pay_period_start, pay_period_end, gross_amount, tax_deduction, net_amount, paid_date)
VALUES (1,'2025-10-01','2025-10-31',250000.00,50000.00,200000.00,'2025-11-01');

CREATE TABLE `expense_report` (
  `expense_id` INT AUTO_INCREMENT PRIMARY KEY,
  `emp_id` INT NOT NULL,
  `submitted_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `amount` DECIMAL(12,2),
  `currency` VARCHAR(6) DEFAULT 'INR',
  `status` VARCHAR(20) DEFAULT 'submitted',
  `project_id` INT,
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id),
  FOREIGN KEY (project_id) REFERENCES project(project_id)
) ENGINE=InnoDB;

INSERT INTO expense_report (emp_id, amount, status, project_id) VALUES (1,1500.00,'approved',1);

-- Billing: invoices and line items (adds complexity)
CREATE TABLE `invoice` (
  `invoice_id` INT AUTO_INCREMENT PRIMARY KEY,
  `client_id` INT NOT NULL,
  `project_id` INT,
  `issued_date` DATE,
  `due_date` DATE,
  `currency` VARCHAR(6) DEFAULT 'INR',
  `total_amount` DECIMAL(15,2),
  `status` ENUM('draft','issued','paid','overdue') DEFAULT 'draft',
  FOREIGN KEY (client_id) REFERENCES client(client_id),
  FOREIGN KEY (project_id) REFERENCES project(project_id)
) ENGINE=InnoDB;

CREATE TABLE `invoice_line_item` (
  `line_id` INT AUTO_INCREMENT PRIMARY KEY,
  `invoice_id` INT NOT NULL,
  `description` VARCHAR(255),
  `qty` INT DEFAULT 1,
  `unit_price` DECIMAL(12,2),
  `amount` DECIMAL(15,2) GENERATED ALWAYS AS (qty * unit_price) STORED,
  FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO invoice (client_id, project_id, issued_date, due_date, total_amount, status) VALUES (1,1,'2025-11-01','2025-11-30',12000000.00,'issued');
INSERT INTO invoice_line_item (invoice_id, description, qty, unit_price) VALUES (1,'Professional services - Migration',1,12000000.00);

-- ===== Travel & Approvals =====
CREATE TABLE `travel_request` (
  `travel_id` INT AUTO_INCREMENT PRIMARY KEY,
  `emp_id` INT NOT NULL,
  `from_city` VARCHAR(60),
  `to_city` VARCHAR(60),
  `start_date` DATE,
  `end_date` DATE,
  `purpose` TEXT,
  `approved_by` INT,
  `status` VARCHAR(20) DEFAULT 'pending',
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id),
  FOREIGN KEY (approved_by) REFERENCES employee(emp_id)
) ENGINE=InnoDB;

INSERT INTO travel_request (emp_id, from_city, to_city, start_date, end_date, purpose, approved_by, status) VALUES (2,'Bengaluru','Mumbai','2025-12-01','2025-12-03','Client meeting',1,'approved');

-- ===== Recruitment =====
CREATE TABLE `candidate` (
  `candidate_id` INT AUTO_INCREMENT PRIMARY KEY,
  `full_name` VARCHAR(120) NOT NULL,
  `email` VARCHAR(120),
  `applied_for` VARCHAR(80),
  `source` VARCHAR(80),
  `applied_on` DATE
) ENGINE=InnoDB;

INSERT INTO candidate (full_name, email, applied_for, source, applied_on) VALUES ('Rohit Verma','rohit.v@example.com','Software Engineer','LinkedIn','2025-10-10');

CREATE TABLE `interview` (
  `interview_id` INT AUTO_INCREMENT PRIMARY KEY,
  `candidate_id` INT NOT NULL,
  `interviewer_id` INT,
  `interview_date` DATE,
  `mode` VARCHAR(20),
  `score` TINYINT,
  `notes` TEXT,
  FOREIGN KEY (candidate_id) REFERENCES candidate(candidate_id),
  FOREIGN KEY (interviewer_id) REFERENCES employee(emp_id)
) ENGINE=InnoDB;

INSERT INTO interview (candidate_id, interviewer_id, interview_date, mode, score) VALUES (1,1,'2025-10-20','on-site',78);

CREATE TABLE `offer_letter` (
  `offer_id` INT AUTO_INCREMENT PRIMARY KEY,
  `candidate_id` INT NOT NULL,
  `offered_role` VARCHAR(80),
  `offered_ctc` DECIMAL(12,2),
  `offer_date` DATE,
  `accepted` BOOLEAN DEFAULT FALSE,
  `joining_date` DATE,
  FOREIGN KEY (candidate_id) REFERENCES candidate(candidate_id)
) ENGINE=InnoDB;

INSERT INTO offer_letter (candidate_id, offered_role, offered_ctc, offer_date, accepted) VALUES (1,'Software Engineer',900000.00,'2025-10-25',FALSE);

-- ===== Performance & Reviews =====
CREATE TABLE `performance_review` (
  `review_id` INT AUTO_INCREMENT PRIMARY KEY,
  `emp_id` INT NOT NULL,
  `review_period_start` DATE,
  `review_period_end` DATE,
  `reviewer_id` INT,
  `rating` TINYINT CHECK (rating BETWEEN 1 AND 5),
  `comments` TEXT,
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id),
  FOREIGN KEY (reviewer_id) REFERENCES employee(emp_id)
) ENGINE=InnoDB;

INSERT INTO performance_review (emp_id, review_period_start, review_period_end, reviewer_id, rating, comments) VALUES (1,'2024-04-01','2025-03-31',2,5,'Outstanding contribution to migration project');

-- ===== Security / Accounts =====
CREATE TABLE `user_account` (
  `user_id` INT AUTO_INCREMENT PRIMARY KEY,
  `emp_id` INT UNIQUE,
  `username` VARCHAR(80) UNIQUE NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `role_id` SMALLINT UNSIGNED NOT NULL,
  `last_login` DATETIME,
  `active` BOOLEAN DEFAULT TRUE,
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id),
  FOREIGN KEY (role_id) REFERENCES role_type(role_id)
) ENGINE=InnoDB;

INSERT INTO user_account (emp_id, username, password_hash, role_id, last_login) VALUES (1,'amit.shah','{HASHED_PW_PLACEHOLDER}',2,NOW());

-- ===== Additional complexity: SLA, Service Catalog, RACI, Audit trail, Archive =====
CREATE TABLE `service_catalog` (
  `service_id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(120) NOT NULL,
  `category` VARCHAR(80),
  `default_sla_days` TINYINT UNSIGNED
) ENGINE=InnoDB;

INSERT INTO service_catalog (name, category, default_sla_days) VALUES ('VPN Support','IT',2),('Cloud Provisioning','Cloud',7);

CREATE TABLE `sla` (
  `sla_id` INT AUTO_INCREMENT PRIMARY KEY,
  `service_id` INT NOT NULL,
  `priority` TINYINT NOT NULL,
  `response_time_hrs` INT,
  `resolution_time_hrs` INT,
  FOREIGN KEY (service_id) REFERENCES service_catalog(service_id)
) ENGINE=InnoDB;

INSERT INTO sla (service_id, priority, response_time_hrs, resolution_time_hrs) VALUES (1,1,1,24);

-- link SLA to tickets
ALTER TABLE helpdesk_ticket ADD COLUMN `sla_id` INT NULL, ADD FOREIGN KEY (`sla_id`) REFERENCES sla(sla_id);

-- RACI matrix for projects (adds cross-linking complexity)
CREATE TABLE `raci` (
  `raci_id` INT AUTO_INCREMENT PRIMARY KEY,
  `project_id` INT NOT NULL,
  `task` VARCHAR(200) NOT NULL,
  `responsible` INT,
  `accountable` INT,
  `consulted` INT,
  `informed` INT,
  FOREIGN KEY (project_id) REFERENCES project(project_id),
  FOREIGN KEY (responsible) REFERENCES employee(emp_id),
  FOREIGN KEY (accountable) REFERENCES employee(emp_id),
  FOREIGN KEY (consulted) REFERENCES employee(emp_id),
  FOREIGN KEY (informed) REFERENCES employee(emp_id)
) ENGINE=InnoDB;

-- Audit trail using triggers
CREATE TABLE `audit_log` (
  `audit_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `table_name` VARCHAR(100),
  `operation` VARCHAR(10),
  `changed_by` INT,
  `changed_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `row_data` JSON
) ENGINE=InnoDB;

-- Generic trigger examples for INSERT/UPDATE/DELETE on employee table
DELIMITER $$
CREATE TRIGGER trg_employee_insert AFTER INSERT ON employee
FOR EACH ROW
BEGIN
  INSERT INTO audit_log (`table_name`, `operation`, `changed_by`, `row_data`) VALUES ('employee','INSERT',NEW.emp_id,JSON_OBJECT('emp_id',NEW.emp_id,'emp_code',NEW.emp_code));
END$$

CREATE TRIGGER trg_employee_update AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
  INSERT INTO audit_log (`table_name`, `operation`, `changed_by`, `row_data`) VALUES ('employee','UPDATE',NEW.emp_id,JSON_OBJECT('emp_id',NEW.emp_id,'changed_fields',CONCAT(OLD.updated_at,'->',NEW.updated_at)));
END$$

CREATE TRIGGER trg_employee_delete AFTER DELETE ON employee
FOR EACH ROW
BEGIN
  INSERT INTO audit_log (`table_name`, `operation`, `changed_by`, `row_data`) VALUES ('employee','DELETE',OLD.emp_id,JSON_OBJECT('emp_id',OLD.emp_id,'emp_code',OLD.emp_code));
END$$
DELIMITER ;

-- Archive tables for GDPR / retention: move old timesheets older than X years
CREATE TABLE `timesheet_entry_archive` LIKE timesheet_entry;

-- Resource allocation history (keeps snapshots)
CREATE TABLE `resource_allocation_history` (
  `rah_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `project_id` INT,
  `emp_id` INT,
  `allocation_percent` TINYINT,
  `effective_from` DATE,
  `effective_to` DATE,
  `changed_on` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (project_id) REFERENCES project(project_id),
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
) ENGINE=InnoDB;

-- Stored procedure: simple payroll calculation summarizer
DELIMITER $$
CREATE PROCEDURE sp_generate_payroll_summary(IN p_start DATE, IN p_end DATE)
BEGIN
  SELECT emp_id, SUM(gross_amount) AS total_gross, SUM(net_amount) AS total_net FROM payroll
  WHERE pay_period_start >= p_start AND pay_period_end <= p_end
  GROUP BY emp_id;
END$$
DELIMITER ;

-- Views for common reports
CREATE VIEW vw_active_project_resources AS
SELECT p.project_code, p.name AS project_name, e.emp_code, CONCAT(e.first_name,' ',e.last_name) AS employee, pa.allocation_percent
FROM project p
JOIN project_assignment pa ON p.project_id = pa.project_id
JOIN employee e ON pa.emp_id = e.emp_id
WHERE p.status = 'active';

-- Materialized-like summary table (maintained via scheduled job or trigger; sample populate)
CREATE TABLE `summary_project_alloc` (
  `project_id` INT PRIMARY KEY,
  `total_alloc_percent` INT,
  `last_updated` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

INSERT INTO summary_project_alloc (project_id, total_alloc_percent) VALUES (1,100)
ON DUPLICATE KEY UPDATE total_alloc_percent = VALUES(total_alloc_percent), last_updated = CURRENT_TIMESTAMP;

-- Indexes
CREATE INDEX idx_emp_dept ON employee(dept_id);
CREATE INDEX idx_emp_office ON employee(office_id);
CREATE INDEX idx_proj_client ON project(client_id);
CREATE INDEX idx_timesheet_emp_date ON timesheet_entry(emp_id, work_date);



