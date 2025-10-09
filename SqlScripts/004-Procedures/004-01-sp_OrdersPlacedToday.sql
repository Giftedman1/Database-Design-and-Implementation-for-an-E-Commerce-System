USE [GlobalGadgets]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-------------------------------------------------------------------------
---------------- Stored Procedure: OrdersPlacedToday ----------------- 
-------------- To check Orders placed today -------------------------
-------------------------------------------------------------------
-----------------------------------------------------

CREATE OR ALTER PROCEDURE sp_OrdersPlacedToday
    @Status NVARCHAR(20) = NULL
AS
BEGIN
    SELECT 
        COUNT(*) AS OrdersPlacedToday
    FROM dbo.Orders
    WHERE CAST(order_date AS DATE) = CAST(GETDATE() AS DATE)
      AND (@Status IS NULL OR order_status = @Status);
END;
GO

-- To execute the store procedure
EXEC sp_OrdersPlacedToday;               -- All orders placed today
EXEC sp_OrdersPlacedToday @Status='Delivered'; -- Only delivered ones


USE [GlobalGadgets];
GO
