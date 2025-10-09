USE [GlobalGadgets]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Stored Procedure: sp_GetOrdersByCustomer |===============--
-- Purpose: Show all orders placed by a specific customer.
-----------------------------------------------------------

CREATE OR ALTER PROCEDURE sp_GetOrdersByCustomer
    @CustomerID INT
AS
BEGIN
    SELECT 
        o.order_id,
        o.order_date,
        o.order_status,
        p.payment_amount
    FROM dbo.Orders o
    LEFT JOIN dbo.Payments p ON o.order_id = p.order_id
    WHERE o.customer_id = @CustomerID
    ORDER BY o.order_date DESC;
END;
GO

-- To execute
EXEC sp_GetOrdersByCustomer @CustomerID = 3;
