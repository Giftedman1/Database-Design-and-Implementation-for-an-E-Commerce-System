USE [GlobalGadgets]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/*************************************************************
 Purpose: Returns the average rating for a specific product.
 This helps identify top-rated or low-performing products.
*************************************************************/
CREATE OR ALTER FUNCTION dbo.SF_Get_Average_Rating_By_Product
(
    @ProductID INT
)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @AvgRating DECIMAL(5,2);

    SELECT @AvgRating = AVG(CAST(rating AS DECIMAL(5,2)))
    FROM dbo.Reviews
    WHERE product_id = @ProductID;

    RETURN ISNULL(@AvgRating, 0);
END;
GO

-- Example Usage:
SELECT dbo.SF_Get_Average_Rating_By_Product(10) AS AvgRating;
