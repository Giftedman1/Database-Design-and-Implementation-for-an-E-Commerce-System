USE [GlobalGadgets]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

USE [GlobalGadgets];
GO

/*************************************************************
 Purpose: Returns the total purchase value of all orders 
 placed by a specific customer.
*************************************************************/
CREATE OR ALTER FUNCTION dbo.SF_Get_Total_Sales_By_Customer
(
    @CustomerID INT
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalSales DECIMAL(18,2);

    SELECT @TotalSales = SUM(p.payment_amount)
    FROM dbo.Payments p
    INNER JOIN dbo.Orders o ON p.order_id = o.order_id
    WHERE o.customer_id = @CustomerID
      AND p.payment_status = 'Success';

    RETURN ISNULL(@TotalSales, 0);
END;
GO

-- Example Usage:
SELECT dbo.SF_Get_Total_Sales_By_Customer(3) AS TotalSales;
