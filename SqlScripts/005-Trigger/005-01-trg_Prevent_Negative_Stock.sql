USE [GlobalGadgets]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| TRIGGER: trg_PreventNegativeStock |===============--
-- Prevent inventory stock levels from becoming negative.
-- Works only on the rows being updated using the INSERTED table.
-----------------------------------------------------------

CREATE TRIGGER trg_PreventNegativeStock
ON dbo.Inventory
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if any of the updated rows have negative stock
    IF EXISTS (
        SELECT 1 
        FROM INSERTED 
        WHERE StockLevel < 0
    )
    BEGIN
        -- Roll back the transaction and show an error
        ROLLBACK TRANSACTION;
        RAISERROR ('❌ Stock level cannot be negative. Please review your update.', 16, 1);
    END
END;
GO
