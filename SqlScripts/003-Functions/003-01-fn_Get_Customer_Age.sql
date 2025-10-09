USE [GlobalGadgets]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------------------------
--===============| fn_GetCustomerAge |===============--
-- Purpose: Calculate a customer's age from their date of birth.
-----------------------------------------------------------

CREATE FUNCTION fn_GetCustomerAge(@CustomerID INT)
RETURNS INT
AS
BEGIN
    DECLARE @DOB DATE, @Age INT;

    SELECT @DOB = date_of_birth 
    FROM dbo.Customers
    WHERE customer_id = @CustomerID;

    SET @Age = DATEDIFF(YEAR, @DOB, GETDATE());

    RETURN @Age;
END;
GO

--  To get the age
SELECT dbo.fn_GetCustomerAge(3) AS CustomerAge;
GO