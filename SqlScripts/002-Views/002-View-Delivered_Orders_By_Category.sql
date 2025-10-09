USE [GlobalGadgets]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| View: vw_DeliveredOrdersByCategory |===============--
-- Purpose: Summarize delivered orders per category.
-----------------------------------------------------------

CREATE VIEW vw_DeliveredOrdersByCategory
AS
SELECT 
    pc.category_name AS ProductCategory,
    COUNT(o.order_id) AS DeliveredOrderCount
FROM dbo.Orders o
INNER JOIN dbo.OrderDetails od ON o.order_id = od.order_id
INNER JOIN dbo.Products p ON od.product_id = p.product_id
INNER JOIN dbo.ProductCategory pc ON p.category_id = pc.category_id
WHERE o.order_status = 'Delivered'
GROUP BY pc.category_name;
GO

SELECT * FROM vw_DeliveredOrdersByCategory;
