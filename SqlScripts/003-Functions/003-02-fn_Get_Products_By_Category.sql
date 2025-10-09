USE [GlobalGadgets]
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| fn_GetProductsByCategory |===============--
-- Purpose: Return all products that belong to a specific category.
-----------------------------------------------------------

CREATE FUNCTION fn_GetProductsByCategory(@CategoryName NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.product_id,
        p.product_name,
        p.price,
        pc.category_name
    FROM dbo.Products p
    INNER JOIN dbo.ProductCategory pc 
        ON p.category_id = pc.category_id
    WHERE pc.category_name = @CategoryName
);
GO




SELECT * FROM dbo.fn_GetProductsByCategory('Premium');
GO
