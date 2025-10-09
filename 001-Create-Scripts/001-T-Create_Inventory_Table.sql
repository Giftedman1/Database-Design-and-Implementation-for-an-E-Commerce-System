USE [GlobalGadgets]
GO

/****** Object:  Table [dbo].[Inventory]   Purpose: Tracks stock levels for products  **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Create Inventory Table |===============--

CREATE TABLE [dbo].[Inventory](
	[product_id]	[int]			NOT NULL,
	[StockLevel]	[int]			NOT NULL CHECK(StockLevel >=0),
	[Lastupdated]	[datetime]		NOT NULL DEFAULT GETDATE(),

	-- FK
	CONSTRAINT [FK_Inventory_Product] FOREIGN KEY([product_id])
		REFERENCES [dbo].[Products] ([product_id])ON DELETE CASCADE
		ON UPDATE CASCADE
	
) ON [PRIMARY] 
GO


--------------------------------------------------------------------------
--===============| Create Nonclustered Index for product_id |===============--
CREATE NONCLUSTERED INDEX IX_Inventory_ProductID
    ON [dbo].[Inventory] ([product_id]);
GO

-- Add primary key
ALTER TABLE [dbo].[Inventory]
ADD CONSTRAINT PK_Inventory_Product PRIMARY KEY CLUSTERED ([product_id]);
GO

