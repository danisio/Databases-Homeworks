USE TelerikAcademy

--1. Write a SQL query to find the names and salaries of the employees that take the minimal salary in the company.Use a nested SELECT statement.
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary = 
		(SELECT MIN(Salary) FROM Employees)

--2. Write a SQL query to find the names and salaries of the employees that have a salary that is up to 10% higher than the minimal salary for the company.
SELECT FirstName, LastName, Salary 
FROM Employees
WHERE Salary < 
		(SELECT MIN(Salary)*1.1 FROM Employees)

--3. Write a SQL query to find the full name, salary and department of the employees that take the minimal salary in their department.
SELECT d.Name AS [Department name], e.FirstName + ' ' + e.LastName AS Fullname, e.Salary 
FROM Employees e, Departments d
WHERE Salary = 
		(SELECT MIN(Salary) 
		FROM Employees s
		WHERE s.DepartmentID = d.DepartmentID)
ORDER BY d.Name

--4. Write a SQL query to find the average salary in the department #1.
SELECT AVG(Salary) AS [Average salary]
FROM Employees
WHERE DepartmentID = 1

--5. Write a SQL query to find the average salary in the "Sales" department.
SELECT AVG(Salary) AS [Average salary]
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	WHERE d.Name = 'Sales'

--6. Write a SQL query to find the number of employees in the "Sales" department.
SELECT COUNT(*) AS [Number of employees]
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	WHERE d.Name = 'Sales'

--7. Write a SQL query to find the number of all employees that have manager.
SELECT COUNT(ManagerId) AS [Employees with manager]
FROM Employees

--8. Write a SQL query to find the number of all employees that have no manager.
SELECT COUNT(*) AS [Employees without manager]
FROM Employees
WHERE ManagerID IS NULL

--9. Write a SQL query to find all departments and the average salary for each of them.
SELECT d.Name, AVG(e.Salary) AS [Average salary]
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	GROUP BY d.Name

--10. Write a SQL query to find the count of all employees in each department and for each town.
SELECT COUNT(*) AS [Count of employees], d.Name AS [Department], t.Name AS [Town]
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	JOIN Addresses a
		ON e.AddressID = a.AddressID
	JOIN Towns t
		ON a.TownID = t.TownID
	GROUP BY t.Name, d.Name
	ORDER BY t.Name

--11. Write a SQL query to find all managers that have exactly 5 employees. Display their first name and last name.
SELECT e.FirstName, e.LastName
FROM Employees e
	JOIN Employees emp
		ON e.ManagerID = emp.ManagerID
	GROUP BY e.EmployeeID, e.FirstName, e.LastName
	HAVING COUNT(e.EmployeeID) = 5 

--12. Write a SQL query to find all employees along with their managers. For employees that do not have manager display the value "(no manager)".
SELECT e.FirstName + ' ' + e.LastName AS [Employee name], ISNULL(emp.FirstName + ' ' + emp.LastName, '(no manager)') AS [Manager name]
FROM Employees e
	LEFT JOIN Employees emp
		ON e.ManagerID = emp.EmployeeID
	ORDER BY [Manager name]

--13. Write a SQL query to find the names of all employees whose last name is exactly 5 characters long. Use the built-in LEN(str) function.
SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName) = 5

--14. Write a SQL query to display the current date and time in the following format "day.month.year hour:minutes:seconds:milliseconds".
SELECT FORMAT(GETDATE(), 'dd.MM.yyyy HH:mm:ss:fff')

--15. Write a SQL statement to create a table Users. Users should have username, password, full name and last login time.
--Choose appropriate data types for the table fields. Define a primary key column with a primary key constraint.
--Define the primary key column as identity to facilitate inserting records.
--Define unique constraint to avoid repeating usernames.
--Define a check constraint to ensure the password is at least 5 characters long.
CREATE TABLE Users (
	UserId int IDENTITY PRIMARY KEY,
	Username nvarchar(50) NOT NULL UNIQUE,
	Password nvarchar(30) NOT NULL CHECK(LEN(Password) > 5),
	FullName nvarchar(150) NOT NULL,
	LastLoginTime datetime
)
GO

--16. Write a SQL statement to create a view that displays the users from the Users table that have been in the system today.
GO
CREATE VIEW LoggedToday AS 
SELECT Username
FROM Users
WHERE DATEDIFF(DAY, LastLoginTime, GETDATE()) = 0
GO

--17. Write a SQL statement to create a table Groups. Groups should have unique name (use unique constraint). Define primary key and identity column.
CREATE TABLE Groups (
	GroupId int IDENTITY,
	Name nvarchar(100) NOT NULL UNIQUE,
	CONSTRAINT PK_Groups PRIMARY KEY(GroupId)
)
GO

--18. Write a SQL statement to add a column GroupID to the table Users.
--Fill some data in this new column and as well in the `Groups table.
--Write a SQL statement to add a foreign key constraint between tables Users and Groups tables.
ALTER TABLE Users
ADD GroupId int

ALTER TABLE Users
ADD CONSTRAINT FK_Users_Groups
	FOREIGN KEY (GroupId)
	REFERENCES Groups(GroupId)

--19. Write SQL statements to insert several records in the Users and Groups tables.
INSERT INTO Groups
VALUES
	('Superheros'),
	('Villains'),
	('Others')

INSERT INTO Users
VALUES
	('Batman'
	,'bat123'
	,'Bruce Wayne'
	,'01.01.2015'
	,1),
	('Catwoman'
	,'cat123'
	,'Selina Kyle'
	,'02.02.2015'
	,2),
	('Two-Face'
	,'tface123'
	,'Harvey Dent'
	,'03.03.2015'
	,2)

--20. Write SQL statements to update some of the records in the Users and Groups tables.
UPDATE Users
SET Password='batman123'
WHERE UserId = 1
	
UPDATE Groups
SET Name='SUPERHEROES'
WHERE GroupId = 1

--21. Write SQL statements to delete some of the records from the Users and Groups tables.
DELETE FROM Groups
WHERE Name='Others'

--22. Write SQL statements to insert in the Users table the names of all employees from the Employees table.
--Combine the first and last names as a full name.
--For username use the first letter of the first name + the last name (in lowercase).
--Use the same for the password, and NULL for last login time.
--I use the first 3 letters of FirstName, because of the constraints for password (to be > 5).
INSERT INTO Users ([Username],[Password],[FullName])
	(SELECT LOWER(CONCAT(LEFT(FirstName,3), '_', LastName)),
		   LOWER(CONCAT(LEFT(FirstName,3), '_', LastName)),
		   CONCAT(FirstName, ' ', LastName)
	FROM Employees)

--23. Write a SQL statement that changes the password to NULL for all users that have not been in the system since 10.03.2010.
UPDATE Users
SET Password = NULL
WHERE DATEDIFF(DAY, LastLoginTime, '2010-3-10 00:00:00') > 0

--24. Write a SQL statement that deletes all users without passwords (NULL password).
DELETE FROM Users
WHERE [Password] IS NULL

--25. Write a SQL query to display the average employee salary by department and job title.
SELECT d.Name AS [Department], e.JobTitle, AVG(e.Salary) AS [Average salary]
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	GROUP BY d.Name, e.JobTitle
	ORDER BY d.Name

--26. Write a SQL query to display the minimal employee salary by department and job title along with the name of some of the employees that take it.
SELECT d.Name AS [Department], e.JobTitle, MIN(e.FirstName + ' ' + e.LastName), MIN(e.Salary) AS [Minimal salary]
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
GROUP BY e.JobTitle, d.Name
ORDER BY d.Name

--27. Write a SQL query to display the town where maximal number of employees work.
SELECT TOP 1 t.Name AS [Town name], COUNT(e.EmployeeID) AS [Count of employees]
FROM Employees e
	JOIN Addresses a
		ON e.AddressID = a.AddressID
	JOIN Towns t
		ON a.TownID = t.TownID
GROUP BY t.Name
ORDER BY [Count of employees] DESC
	
--28. Write a SQL query to display the number of managers from each town.
SELECT t.Name AS [Town name], COUNT(DISTINCT e.ManagerID) AS [Count of managers]
FROM Employees e
	JOIN Employees m
		ON e.ManagerID = m.EmployeeID
	JOIN Addresses a
		ON e.AddressID = a.AddressID
	JOIN Towns t
		ON a.TownID = t.TownID
GROUP BY t.Name
ORDER BY [Count of managers] DESC

--29. Write a SQL to create table WorkHours to store work reports for each employee (employee id, date, task, hours, comments).
--Don't forget to define identity, primary key and appropriate foreign key.
--Issue few SQL statements to insert, update and delete of some data in the table.
--Define a table WorkHoursLogs to track all changes in the WorkHours table with triggers.
--For each change keep the old record data, the new record data and the command (insert / update / delete).
CREATE TABLE WorkHours(
	Id int PRIMARY KEY IDENTITY,
	EmployeeId int NOT NULL FOREIGN KEY REFERENCES Employees(EmployeeID),
	DateOfReport DATETIME,
	Task nvarchar(500),
	HoursOfWork int,
	Comments nvarchar(500)
)

--Insert data--
DECLARE @counter int
SET @counter = 0

WHILE @counter < 10
BEGIN
	INSERT INTO WorkHours(EmployeeId, DateOfReport, Task, HoursOfWork, Comments)
	VALUES (@counter, GETDATE(), 'task' + CONVERT(VARCHAR(5), @counter), 8, 'comment' + CONVERT(VARCHAR(5), @counter))
	SET @counter = @counter + 1
END
GO

--WorkLogs--
CREATE TABLE WorkHoursLog(
	Id int PRIMARY KEY IDENTITY,
	WorkHoursId int,
	EmployeeId int FOREIGN KEY REFERENCES Employees(EmployeeId),
	DateOfReport DATETIME,
	Task nvarchar(50),
	HoursOfWork int,
	Comments nvarchar(500),
	[Action] varchar(25) NOT NULL
)
GO
-- triggers --

--INSERT--
CREATE TRIGGER trg_WorkHours_Insert 
	ON WorkHours
	FOR INSERT 
	AS
	INSERT INTO WorkHoursLog(WorkHoursId, EmployeeId, DateOfReport, Task, HoursOfWork, Comments, [Action])
		SELECT Id, EmployeeID, DateOfReport, Task, HoursOfWork, Comments, 'Insert'
		FROM inserted
GO

--DELTETE--
CREATE TRIGGER trg_WorkHours_Delete 
	ON WorkHours
	FOR DELETE 
	AS
	INSERT INTO WorkHoursLog(WorkHoursId,EmployeeId, DateOfReport, Task, HoursOfWork, Comments, [Action])
		SELECT Id, EmployeeId, DateOfReport, Task, HoursOfWork, Comments, 'Delete'
		FROM deleted
GO

--UPDATE--
CREATE TRIGGER trg_WorkHours_Update ON WorkHours
	FOR UPDATE 
	AS
	INSERT INTO WorkHoursLog(WorkHoursId, EmployeeId, DateOfReport, Task, HoursOfWork, Comments, [Action])
		SELECT Id, EmployeeId, DateOfReport, Task, HoursOfWork, Comments, 'UPDATE'
		FROM inserted
GO


--Trigers tests--

--DELETE--
DELETE FROM  WorkHours 
WHERE EmployeeId = 2


--INSERT--
DECLARE @counter INT
SET @counter = 11

INSERT INTO WorkHours(EmployeeId, DateOfReport, Task, HoursOfWork, Comments)
VALUES (@counter, GETDATE(), 'task' + CONVERT(VARCHAR(5), @counter), 8, 'comment' + CONVERT(VARCHAR(5), @counter))

--UPDATE--
UPDATE WorkHours
SET HoursOfWork = 9 
WHERE HoursOfWork = 8

--30. Start a database transaction, delete all employees from the 'Sales' department along with all dependent records from the pother tables.
--At the end rollback the transaction.
BEGIN TRAN
ALTER TABLE Departments
	DROP CONSTRAINT FK_Departments_Employees
GO

DELETE e 
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	WHERE d.Name='Sales'
ROLLBACK TRAN

--31. Start a database transaction and drop the table EmployeesProjects. Now how you could restore back the lost table data?
BEGIN TRAN
	DROP TABLE EmployeesProjects
ROLLBACK TRAN

--32. Find how to use temporary tables in SQL Server.
--Using temporary tables backup all records from EmployeesProjects and restore them back after dropping and re-creating the table.
BEGIN TRAN
    SELECT * 
        INTO #TempEmployeesProjects
        FROM EmployeesProjects

    DROP TABLE EmployeesProjects

    SELECT * 
        INTO EmployeesProjects
        FROM #TempEmployeesProjects

    DROP TABLE #TempEmployeesProjects
ROLLBACK TRAN