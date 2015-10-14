Use TelerikAcademy

--4. Write a SQL query to find all information about all departments (use "TelerikAcademy" database).
SELECT *
FROM dbo.Departments

--5. Write a SQL query to find all department names.
SELECT Name
FROM dbo.Departments

--6. Write a SQL query to find the salary of each employee.
SELECT Salary
FROM dbo.Employees

--7. Write a SQL to find the full name of each employee.
SELECT FirstName + ' ' + LastName AS Fullname
FROM dbo.Employees

--8. Write a SQL query to find the email addresses of each employee (by his first and last name). Consider that the mail domain is telerik.com. Emails should look like “John.Doe@telerik.com". The produced column should be named "Full Email Addresses".
SELECT FirstName + '.' + LastName + '@telerik.com' AS [Full Email Addresses]
FROM dbo.Employees

--9. Write a SQL query to find all different employee salaries.
SELECT DISTINCT Salary 
FROM dbo.Employees

--10. Write a SQL query to find all information about the employees whose job title is “Sales Representative“.
SELECT *
FROM dbo.Employees
WHERE JobTitle = 'Sales Representative'

--11. Write a SQL query to find the names of all employees whose first name starts with "SA".
SELECT FirstName + ' ' + LastName AS Name
FROM dbo.Employees
WHERE FirstName LIKE 'SA%'

--12. Write a SQL query to find the names of all employees whose last name contains "ei".
SELECT FirstName + ' ' + LastName AS Name
FROM dbo.Employees
WHERE LastName LIKE '%ei%'

--13. Write a SQL query to find the salary of all employees whose salary is in the range [20000…30000].
SELECT FirstName + ' ' + LastName AS Name, Salary
FROM dbo.Employees
WHERE Salary BETWEEN 20000 AND 30000

--14. Write a SQL query to find the names of all employees whose salary is 25000, 14000, 12500 or 23600.
SELECT FirstName + ' ' + LastName AS Name, Salary
FROM dbo.Employees
WHERE Salary IN (25000, 14000, 12500,23600)

--15. Write a SQL query to find all employees that do not have manager.
SELECT FirstName + ' ' + LastName AS Name
FROM dbo.Employees
WHERE ManagerID IS NULL

--16. Write a SQL query to find all employees that have salary more than 50000. Order them in decreasing order by salary.
SELECT FirstName + ' ' + LastName AS Name, Salary
FROM dbo.Employees
WHERE Salary > 50000
ORDER BY Salary DESC

--17. Write a SQL query to find the top 5 best paid employees.
SELECT TOP 5 FirstName + ' ' + LastName AS Name, Salary
FROM dbo.Employees
WHERE Salary > 50000
ORDER BY Salary DESC

--18. Write a SQL query to find all employees along with their address. Use inner join with ON clause.
SELECT e.FirstName + ' ' + e.LastName AS Name, a.AddressText AS 'Address'
FROM dbo.Employees e
	INNER JOIN dbo.Addresses a
	ON e.AddressID = a.AddressID

--19. Write a SQL query to find all employees and their address. Use equijoins (conditions in the WHERE clause).
SELECT e.FirstName + ' ' + e.LastName AS Name, a.AddressText AS 'Address'
FROM Employees e, Addresses a
WHERE e.AddressID = a.AddressID

--20. Write a SQL query to find all employees along with their manager.
SELECT e.FirstName + ' ' + e.LastName AS 'Employee Name', m.FirstName + ' ' + m.LastName AS 'Manager Name'
FROM dbo.Employees e
	INNER JOIN dbo.Employees m
	ON e.ManagerID = m.EmployeeID

--21. Write a SQL query to find all employees, along with their manager and their address. Join the 3 tables: Employees e, Employees m and Addresses a.
SELECT e.FirstName + ' ' + e.LastName AS 'Employee Name', a.AddressText AS 'Address', m.FirstName + ' ' + m.LastName AS 'Manager Name'
FROM dbo.Employees e
	INNER JOIN dbo.Employees m
		ON e.ManagerID = m.EmployeeID
	INNER JOIN dbo.Addresses a
		ON e.AddressID = a.AddressID

--22. Write a SQL query to find all departments and all town names as a single list. Use UNION.
SELECT Name + ' department'AS 'Name'
FROM dbo.Departments
UNION 
SELECT Name + ' town' AS 'Name'
FROM dbo.Towns

--23. Write a SQL query to find all the employees and the manager for each of them along with the employees that do not have manager. Use right outer join. Rewrite the query to use left outer join.
SELECT e.FirstName + ' ' + e.LastName AS 'Employee Name', m.FirstName + ' ' + m.LastName AS 'Manager Name'
FROM dbo.Employees e
	RIGHT OUTER JOIN dbo.Employees m
	ON e.ManagerID = m.EmployeeID

SELECT e.FirstName + ' ' + e.LastName AS 'Employee Name', m.FirstName + ' ' + m.LastName AS 'Manager Name'
FROM dbo.Employees e
	LEFT OUTER JOIN dbo.Employees m
	ON e.ManagerID = m.EmployeeID

--24. Write a SQL query to find the names of all employees from the departments "Sales" and "Finance" whose hire year is between 1995 and 2005.
SELECT e.FirstName + ' ' + e.LastName AS Name, d.Name AS Department, e.HireDate AS 'Hire date'
FROM dbo.Employees e
	JOIN dbo.Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE DATEPART(year,e.HireDate) BETWEEN 1996 AND 2004 /*WHERE (1995 <= DATEPART(year,e.HireDate) AND DATEPART(year,e.HireDate)<2005)*/
AND (d.Name = 'Sales' OR d.Name = 'Finance')
ORDER BY e.FirstName, e.LastName