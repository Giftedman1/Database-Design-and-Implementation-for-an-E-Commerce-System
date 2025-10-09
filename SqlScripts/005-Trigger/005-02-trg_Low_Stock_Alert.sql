USE [GlobalGadgets]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| TRIGGER 2: Low Stock Alert |===============--
-- Raise a warning when stock levels reach 0 (out of stock).
-----------------------------------------------------------

CREATE TRIGGER trg_LowStockAlert
ON dbo.Inventory
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Find products that have reached zero stock
    IF EXISTS (
        SELECT 1
        FROM INSERTED i
        WHERE i.StockLevel = 0
    )
    BEGIN
        DECLARE @productCount INT;
        SELECT @productCount = COUNT(*) FROM INSERTED WHERE StockLevel = 0;

        PRINT 'ALERT: ' + CAST(@productCount AS NVARCHAR(10)) + 
              ' product(s) have reached zero stock. Please restock soon.';
    END
END;
GO