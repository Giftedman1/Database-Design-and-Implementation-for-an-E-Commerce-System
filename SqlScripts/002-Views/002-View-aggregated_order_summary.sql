USE [GlobalGadgets]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------------------
--===============| View: aggregated order summary --------------
--                 Purpose: Provide aggregated order totals per order
------------------------------------------------------------------------------------------------

CREATE VIEW dbo.vw_OrderSummary
AS
SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    o.customer_id,
    c.full_name AS customer_name,
    SUM(od.quantity * od.unitPrice) AS order_total
FROM dbo.Orders o
INNER JOIN dbo.OrderDetails od ON o.order_id = od.order_id
LEFT JOIN dbo.Customers c ON o.customer_id = c.customer_id
GROUP BY o.order_id, o.order_date, o.order_status, o.customer_id, c.full_name;
GO

SELECT * FROM vw_CustomerOrderSummary;