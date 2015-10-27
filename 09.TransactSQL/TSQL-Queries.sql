--1. Create a database with two tables: Persons(Id(PK), FirstName, LastName, SSN) and Accounts(Id(PK), PersonId(FK), Balance).
--Insert few records for testing.
--Write a stored procedure that selects the full names of all persons.

CREATE DATABASE BankAcconts
GO

Use BankAcconts

-- create tables --
CREATE TABLE Persons (
	PersonId int IDENTITY PRIMARY KEY,
	FirstName nvarchar(30) NOT NULL,
	LastName nvarchar(30) NOT NULL,
	SSN varchar(11) NOT NULL
)
GO

CREATE TABLE Accounts (
	AccountId int IDENTITY PRIMARY KEY,
	PersonId int FOREIGN KEY REFERENCES Persons(PersonId) NOT NULL,
	Balance money NOT NULL
)
GO

-- insert data --
INSERT INTO Persons ([FirstName], [LastName], [SSN])
VALUES
	('Howard','Head', '519-51-6820'),
	('Teegan','Murphy', '401-62-5620'),
	('Yoshi','Rollins', '255-25-0562'),
	('Mia','Cardenas', '260-93-9769'),
	('Ivor','Blake', '371-34-9753'),
	('Chiquita','Anderson', '517-84-3446'),
	('Jada','Pope', '487-86-2238'),
	('Irma','Aguilar', '770-18-4905'),
	('Leslie','Burton', '481-19-5630'),
	('Jasper','Jones', '315-10-6217')

INSERT INTO Accounts([PersonId],[Balance]) 
VALUES
	(1, 25148),
	(2, 51611),
	(3, 45201),
	(4, 68880),
	(5, 72285),
	(6, 64281),
	(7, 55203),
	(8, 16462),
	(9, 54248),
	(10, 56234)
GO	

CREATE PROC usp_SelectPersonsFullName
AS
	SELECT CONCAT([FirstName], ' ', [LastName]) AS [FullName]
	FROM Persons
GO

EXEC usp_SelectPersonsFullName

--2. Create a stored procedure that accepts a number as a parameter and returns all persons who have more money in their accounts than the supplied number.
GO
CREATE PROC usp_SelectPersonsWithMinBalance(@amount money)
AS
	SELECT p.FirstName + ' ' + p.LastName AS [Fullname], a.Balance
	FROM Persons p
		JOIN Accounts a
			ON p.PersonId = a.PersonId
	WHERE a.Balance > @amount
GO

EXEC usp_SelectPersonsWithMinBalance 22000

--3. Create a function that accepts as parameters – sum, yearly interest rate and number of months.
--It should calculate and return the new sum.
--Write a SELECT to test whether the function works as expected.
GO
CREATE FUNCTION ufn_CalculateInterestRate(@sum money, @yearlyInterestRate decimal, @months int)
RETURNS money
AS
	BEGIN
	RETURN @sum * (1 + (@months/12.0) * (@yearlyInterestRate/100.0))
	END
GO

SELECT [LastName], dbo.ufn_CalculateInterestRate(a.Balance, 11, 12) AS [New balance]
FROM Persons p
	JOIN Accounts a
		ON p.PersonId = a.PersonId
ORDER BY [LastName]

--4. Create a stored procedure that uses the function from the previous example to give an interest to a person's account for one month.
--It should take the AccountId and the interest rate as parameters.
GO
CREATE PROC usp_AddInterestRateToAccount(@accountId int, @interestRate money)
AS
	DECLARE @balance money
		SELECT @balance = [Balance] FROM Accounts WHERE [AccountId] = @accountId
	DECLARE @newBalance money
		SELECT @newBalance = dbo.ufn_CalculateInterestRate(@balance, @interestRate, 1)
	
	UPDATE Accounts
	SET [Balance] = @newBalance
	WHERE [AccountId] = @accountId
GO

-- add 10%rate to balance of account 4
EXEC usp_AddInterestRateToAccount 4, 10.0
SELECT [Balance] FROM Accounts WHERE [AccountId] = 4

--5. Add two more stored procedures WithdrawMoney(AccountId, money) and DepositMoney(AccountId, money) that operate in transactions.
GO
CREATE PROC usp_WithdrawMoney(@accountId int, @amount money)
AS
	BEGIN TRAN
	DECLARE @currentBalance money = (SELECT [Balance] FROM Accounts WHERE [AccountId] = @accountId)
	IF (@currentBalance >= @amount)
		BEGIN
			UPDATE Accounts
			SET [Balance] -= @amount
			WHERE [AccountId] = @accountId
		END
	ELSE
		BEGIN
			PRINT 'Not enough money'
		END
	COMMIT TRAN

EXEC usp_WithdrawMoney 2, 51610
EXEC usp_WithdrawMoney 2, 1111111111111111

GO
CREATE PROC usp_DepositMoney(@accountId int, @amount money)
AS
	BEGIN TRAN
		UPDATE Accounts
		SET [Balance] += @amount
		WHERE [AccountId] = @accountId
	COMMIT TRAN
GO

EXEC usp_DepositMoney 2, 1000000

--6. Create another table – Logs(LogID, AccountID, OldSum, NewSum).
--Add a trigger to the Accounts table that enters a new entry into the Logs table every time the sum on an account changes.
GO
CREATE TABLE Logs (
	LogID int IDENTITY PRIMARY KEY,
	AccountID int FOREIGN KEY REFERENCES Accounts(AccountId) NOT NULL,
	OldSum money NOT NULL,
	NewSum money NOT NULL
)
GO

CREATE TRIGGER tr_UpdateBalance ON Accounts FOR UPDATE
AS
    INSERT INTO Logs(AccountId, OldSum, NewSum)
        SELECT i.AccountId, d.Balance, i.Balance
        FROM inserted i, deleted d
GO

EXEC usp_DepositMoney 2, 1000000
EXEC usp_WithdrawMoney 2, 2000000

--7. Define a function in the database TelerikAcademy that returns all Employee's names (first or middle or last name) and all town's names that are comprised of given set of letters.
--Example: 'oistmiahf' will return 'Sofia', 'Smith', … but not 'Rob' and 'Guy'.
Use TelerikAcademy
GO
CREATE FUNCTION ufn_SearchPattern(@pattern nvarchar(255))
RETURNS @result TABLE 
	(Name varchar(50))
AS
BEGIN
	INSERT @result
	SELECT * 
	FROM
		(SELECT e.FirstName FROM Employees e
		UNION
        SELECT e.MiddleName FROM Employees e
		UNION
        SELECT e.LastName FROM Employees e
        UNION 
        SELECT t.Name FROM Towns t) 
	AS temp(match)
    WHERE PATINDEX('%^[' + @pattern + ']', match) > 0
	RETURN
END
GO

SELECT * FROM dbo.ufn_SearchPattern('oistmiahf')

--8. Using database cursor write a T-SQL script that scans all employees and their addresses and prints all pairs of employees that live in the same town.
DECLARE empCursor CURSOR READ_ONLY FOR
    SELECT emp1.FirstName, emp1.LastName, emp2.FirstName, emp2.LastName, t1.Name
    FROM Employees emp1
		JOIN Addresses a1
			ON emp1.AddressID = a1.AddressID
		JOIN Towns t1
			ON a1.TownID = t1.TownID,
			Employees emp2
		JOIN Addresses a2
			ON emp2.AddressID = a2.AddressID
		JOIN Towns t2
			ON a2.TownID = t2.TownID
    WHERE t1.TownID = t2.TownID AND emp1.EmployeeID != emp2.EmployeeID
    ORDER BY t1.Name

OPEN empCursor
DECLARE @firstName1 nvarchar(50), 
        @lastName1 nvarchar(50),
        @firstName2 nvarchar(50),
        @lastName2 nvarchar(50),
		@townName nvarchar(50)
FETCH NEXT FROM empCursor INTO @firstName1, @lastName1, @firstName2, @lastName2, @townName

DECLARE @counter int = 0

WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @counter = @counter + 1;
		PRINT 'Town: ' + @townName + ' - ' + @firstName1 + ' ' + @lastName1 + ', ' + @firstName2 + ' ' + @lastName2;

		FETCH NEXT FROM empCursor INTO @firstName1, @lastName1, @firstName2, @lastName2, @townName
	END

CLOSE empCursor
DEALLOCATE empCursor
