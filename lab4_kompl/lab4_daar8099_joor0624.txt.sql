use lab4;

# Uppgift 1

# Departments
ALTER TABLE departments
# Nanngivning av referensintegretitesvillkor
ADD CONSTRAINT fk_department_managers 
FOREIGN KEY (manager) REFERENCES employees(id)
# Uppdateras PK så ändras FK från departments. Vid borttagning stannar denna kvar då detta kan vara bra att veta.
ON UPDATE CASCADE
ON DELETE restrict;

# Projects
ALTER TABLE projects
ADD CONSTRAINT fk_project_supervisor 
FOREIGN KEY (supervisor) REFERENCES employees(id)
# Om den anställda tas bort kan det fortfarande vara bra att veta vem som var projektets ledare.
ON UPDATE CASCADE
ON DELETE RESTRICT;

# Project_members
ALTER TABLE project_members
ADD CONSTRAINT fk_projectmember
FOREIGN KEY (e_id) REFERENCES employees(id)
ON UPDATE CASCADE
ON DELETE RESTRICT,
ADD CONSTRAINT fk_project
FOREIGN KEY (p_id) REFERENCES projects (id)
ON UPDATE CASCADE
ON DELETE CASCADE;

# Uppgift 2

ALTER TABLE projects DROP CONSTRAINT check_project_sv;
ALTER TABLE projects DROP CONSTRAINT check_project_name;

ALTER TABLE projects
ADD CONSTRAINT check_project_sv
	CHECK(supervisor IS NOT NULL),
ADD CONSTRAINT check_project_name
	check(name is not null),
ADD UNIQUE(name);
    
# Demonstration att constraints fungerar   
INSERT INTO projects (name, description, supervisor, start_date, end_date) VALUES ('newname', 'asd', null, '2015-12-24', null);
INSERT INTO projects (name, description, supervisor, start_date, end_date) VALUES (null, 'whoo', 3, '2015-12-24', null);
INSERT INTO projects (name, description, supervisor, start_date, end_date) VALUES ("Sql4life", 'whoo', 3, '2015-12-24', null);


# Uppgift 3
ALTER TABLE employees
ADD CONSTRAINT check_employee_department
	CHECK(department is not null),
    ALTER department
	SET DEFAULT 4;

# Demonstration för constraint
SELECT department FROM employees;
INSERT INTO employees (title, first_name, last_name, login, birth_date, email, salary,
phone_work, start_date, phone_home, phone_mobile) values ('mr', 'noDepTest', 'nope', 'noDep1',
'1972-08-21', 'mail@mail.com', 43268, '760-02-0962', '2011-07-23', '734-91-2778', '734-91-2778');
SELECT department FROM employees WHERE first_name = 'noDepTest';
    
ALTER TABLE departments
DROP CONSTRAINT check_department_name, DROP CONSTRAINT check_department_manager;

ALTER TABLE departments 
ADD CONSTRAINT check_department_name
	check(department is not null),
ADD CONSTRAINT check_department_manager
	check(manager is not null),
ADD UNIQUE(department);

# Uppgift 4

ALTER TABLE employees
ADD INDEX idx_lname (last_name),
ADD UNIQUE (login);

# Uppgift 5

#a)

ALTER TABLE projects
MODIFY COLUMN name VARCHAR(25);

#b)

ALTER TABLE departments
MODIFY COLUMN id TINYINT;

#c)

ALTER TABLE employees
MODIFY COLUMN title ENUM ("dr", "mr", "ms", "mrs", "rev", "honorable");

#d)

ALTER TABLE employees
ADD CONSTRAINT check_employee_birth_date
	CHECK(birth_date IS NOT NULL),
ADD CONSTRAINT check_employee_start_date
	CHECK(start_date IS NOT NULL);
    
# Demonstration för enum och constraints

INSERT INTO  employees (title, first_name, last_name, login, department, birth_date, email, salary,
phone_work, start_date, phone_home, phone_mobile, hr_notes) values ('test', 'Creighton', 'Trowl', 'ctrowl4',
7, '1972-08-21', 'ctrowl4@ifeng.com', 43268, '760-02-0962', '2011-07-23', '734-91-2778', '734-91-2778', null);
INSERT INTO  employees (title, first_name, last_name, login, department, birth_date, email, salary,
phone_work, start_date, phone_home, phone_mobile, hr_notes) values ('Ms', 'Creighton', 'Trowl', 'ctrowl4',
7, null, 'ctrowl4@ifeng.com', 43268, '760-02-0962', '2011-07-23', null, '734-91-2778', null);
INSERT INTO  employees (title, first_name, last_name, login, department, birth_date, email, salary,	
phone_work, start_date, phone_home, phone_mobile, hr_notes) values ('Ms', 'Creighton', 'Trowl', 'ctrowl4',
7, '1972-08-21', 'ctrowl4@ifeng.com', 43268, '760-02-0962', null, '734-91-2778', '734-91-2778', null);

#e)

ALTER TABLE  employees
ADD CONSTRAINT check_employee_mail
	CHECK(email is not null);

# Demonstration för constraint av mail 
INSERT INTO employees (title, first_name, last_name, login, department, birth_date, email, salary,
phone_work, start_date, phone_home, phone_mobile, hr_notes) values ('mr', 'Creighton', 'Trowl', 'ctrowl4',
7, '1972-08-21', null, 43268, '760-02-0962', '2011-07-23', '734-91-2778', '734-91-2778', null);

# Uppgift 6

CREATE VIEW department_info AS
SELECT d.department,
MIN(e.salary) AS lowest_salary,
MAX(e.salary) AS highest_salary,
AVG(e.salary) AS average_salary,
COUNT(e.id) AS employee_amount
FROM
departments AS d
JOIN
 employees AS e ON d.id = e.department
GROUP BY e.department;

# Demonstration, visar vyn.

SELECT * FROM department_info;

# Uppgift 7

DELIMITER //
CREATE FUNCTION retirement_check (
	birth_date DATE)
    RETURNS TEXT DETERMINISTIC
    BEGIN
		DECLARE age	INT;
		DECLARE returnText TEXT;
        SET age = (TIMESTAMPDIFF(YEAR,birth_date, now()));
        CASE 
        WHEN 65 - age > 5
        THEN SET returnText = 'More than 5 years';
        WHEN 65 - age = 5
        THEN SET returnText = '5 years';
        WHEN 65 - age 
        THEN SET returnText = '4 years';
        WHEN 65 - age = 3
        THEN SET returnText = '3 years';
		WHEN 65 - age = 2
        THEN SET returnText = '2 years';
        WHEN 65 - age = 1
        THEN SET returnText = '1 year';
		WHEN 65 - age < 1
        THEN SET returnText = 'Up for retirement';
		WHEN age > 65
        THEN SET returntext = 'Retired';
        END CASE;
        RETURN returnText;
	END //
    DELIMITER ;

CREATE VIEW retirement_info AS
    SELECT 
        e.title,
        e.first_name,
        e.last_name,
        e.birth_date,
        (TIMESTAMPDIFF(YEAR, e.birth_date, NOW())) AS age,
        d.department,
        RETIREMENT_CHECK(birth_date) AS retirement_status
    FROM
        employees AS e
            JOIN
        departments AS d ON e.department = d.id
    WHERE
        (TIMESTAMPDIFF(YEAR, e.birth_date, NOW())) > 55
    ORDER BY department , birth_date;
   
# Demonstration, visar vyn.

SELECT  * FROM retirement_info;

# Uppgift 8

CREATE TABLE total_salary (
    id INT PRIMARY KEY AUTO_INCREMENT,
    last_update DATETIME
) AS SELECT SUM(salary) tot_salary FROM
    employees;

DROP TRIGGER employee_insert_trigger;

DELIMITER //
CREATE TRIGGER employee_insert_trigger
AFTER INSERT
ON employees
FOR EACH ROW
BEGIN
DECLARE totalsalary INT;
SET totalsalary = (SELECT SUM(salary) FROM employees);
UPDATE total_salary SET tot_salary = totalsalary WHERE total_salary.id=1;
UPDATE total_salary SET last_update = NOW() WHERE total_salary.id=1;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER employee_update_trigger
AFTER UPDATE
ON employees
FOR EACH ROW
BEGIN
DECLARE totalsalary INT;
SET totalsalary = (SELECT SUM(salary) FROM employees);
UPDATE total_salary SET tot_salary = totalsalary WHERE total_salary.id=1;
UPDATE total_salary SET last_update = NOW() WHERE total_salary.id=1;
END//
DELIMITER ;

# Demonstration, lägger till en ny först till en ny anställd och uppdaterar total_salary
  
INSERT INTO employees (title, first_name, last_name, login, department, birth_date, email, salary, phone_work, start_date, phone_home, phone_mobile, hr_notes) values ('Dr', 'Giueestino', 'Loraaeit', 'gloredasdaitpq', 3, '1976-11-16', 'gloeadaareitpq@mayoclinic.com', 1, '814-50-2305', '2002-11-04', '177-81-6156', null, "adwa");
  
 SELECT  * FROM total_salary;
 UPDATE employees 
SET salary = 2
WHERE login = 'gloredasdaitpq';
  
SELECT * FROM total_salary;

# Uppgift 9

CREATE TABLE hr_notes (
    id INT PRIMARY KEY AUTO_INCREMENT
) AS SELECT hr_notes AS notes, id AS employee FROM
    employees;

ALTER TABLE hr_notes
ADD CONSTRAINT fk_employee
FOREIGN KEY (employee) REFERENCES employees (id)
ON UPDATE CASCADE
ON DELETE Restrict;

ALTER TABLE employees
DROP hr_notes;

# Demonstration

SELECT * FROM hr_notes;
  
SELECT e.first_name, e.last_name, h.notes
FROM employees AS e LEFT JOIN
hr_notes AS h ON e.id = h.employee;

# Uppgift 10

DROP TRIGGER IF EXISTS salary_check_trigger

DELIMITER //
CREATE TRIGGER salary_check_trigger
BEFORE UPDATE
ON employees
FOR EACH ROW
BEGIN
CASE
WHEN NEW.salary < OLD.salary
THEN
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = "Lönen kan inte sänkas";
WHEN NEW.salary > OLD.salary * 1.1
THEN
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = "Lönen kan inte höjas mer än 10 %";
END CASE;
END//
DELIMITER ;

# Demo, kan inte sänka lön eller höja högre än 10 %

UPDATE employees 
SET salary = 1
WHERE login = 'gloredasdaitpq';

UPDATE employees 
SET salary = 4
WHERE login = 'gloredasdaitpq';

