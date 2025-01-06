use lastversion;


CREATE TABLE project_dataset (
    TransactionID INT,
    Date DATE,
    CustomerID INT,
    CustomerName VARCHAR(255),
    AccountNumber VARCHAR(255),
    TransactionType VARCHAR(50),
    Amount DECIMAL(10, 2),
    BranchID INT,
    BranchName VARCHAR(255),
    EmployeeID INT,
    EmployeeName VARCHAR(255)
);

CREATE VIEW TransactionsView AS
SELECT * FROM project_dataset;

CREATE VIEW Customers AS
SELECT CustomerID, CustomerName, AccountNumber FROM project_dataset;

CREATE VIEW Branches AS
SELECT BranchID, BranchName FROM project_dataset;

CREATE VIEW Employees AS
SELECT EmployeeID, EmployeeName FROM project_dataset;

CREATE VIEW CustomerTransactions AS
SELECT t.*, c.CustomerName AS CustomerNames
FROM project_dataset t
JOIN Customers c ON t.CustomerID = c.CustomerID;

CREATE VIEW BranchTransactions AS
SELECT BranchID,
       SUM(CASE WHEN TransactionType = 'Deposit' THEN Amount ELSE 0 END) AS TotalDeposits,
       SUM(CASE WHEN TransactionType = 'Withdrawal' THEN Amount ELSE 0 END) AS TotalWithdrawals,
       SUM(CASE WHEN TransactionType = 'Transfer' THEN Amount ELSE 0 END) AS TotalTransfers
FROM project_dataset
GROUP BY BranchID;


CREATE VIEW EmployeeTransactions AS
SELECT EmployeeID, TransactionID, TransactionType, Amount
FROM project_dataset;


CREATE VIEW DailyTransactions AS
SELECT Date,
       SUM(CASE WHEN TransactionType = 'Deposit' THEN Amount ELSE 0 END) AS TotalDeposits,
       SUM(CASE WHEN TransactionType = 'Withdrawal' THEN Amount ELSE 0 END) AS TotalWithdrawals,
       SUM(CASE WHEN TransactionType = 'Transfer' THEN Amount ELSE 0 END) AS TotalTransfers
FROM project_dataset
GROUP BY Date;


CREATE VIEW HighValueTransactions AS
SELECT *
FROM project_dataset
WHERE Amount > 1000;