USE [GlobalGadgets]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| TRIGGER 3: trg_Update Inventory On OrderStatus |===============--
-- Automatically update product stock levels when an order’s status changes.
          -- When order is "Shipped" - Decrease stock
           --When order is "Cancelled" - Increase stock
-----------------------------------------------------------

CREATE TRIGGER trg_UpdateInventoryOnOrderStatus
ON dbo.Orders
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Only act if the order status actually changed
    IF UPDATE(order_status)
    BEGIN
        -- When order is marked as SHIPPED, reduce stock
        UPDATE inv
        SET inv.StockLevel = inv.StockLevel - od.Quantity
        FROM dbo.Inventory inv
        INNER JOIN dbo.OrderDetails od ON inv.product_id = od.product_id
        INNER JOIN INSERTED i ON od.order_id = i.order_id
        WHERE i.order_status = 'Shipped';

        -- When order is CANCELLED, restore stock
        UPDATE inv
        SET inv.StockLevel = inv.StockLevel + od.Quantity
        FROM dbo.Inventory inv
        INNER JOIN dbo.OrderDetails od ON inv.product_id = od.product_id
        INNER JOIN INSERTED i ON od.order_id = i.order_id
        WHERE i.order_status = 'Cancelled';
