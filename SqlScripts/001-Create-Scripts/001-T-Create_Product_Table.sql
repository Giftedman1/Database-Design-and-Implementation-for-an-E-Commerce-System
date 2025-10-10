USE [GlobalGadgets]
GO

/****** Object:  Table [dbo].[Products]     Purpose: Stores product details **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Create Products Table |===============--

CREATE TABLE [dbo].[Products](
	[product_id]	[int] IDENTITY (10,1)	NOT NULL,
	[Product_name]	[nvarchar](150)			NOT NULL,
	[price]			[decimal](10,2)			NOT NULL,
	[category_id]	[int]					NOT NULL,
	[supplier_id]	[int]					NOT NULL,

-- PK
	CONSTRAINT [PK_Products_product_id] PRIMARY KEY CLUSTERED 
		([product_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY],
	
	-- FK
	CONSTRAINT [FK_Products_Productcategory] FOREIGN KEY([category_id])
		REFERENCES [dbo].[ProductCategory] ([category_id]),
	
	-- FK
	CONSTRAINT [FK_Products_suppliers] FOREIGN KEY([supplier_id])
		REFERENCES [dbo].[Suppliers] ([supplier_id]) ON DELETE NO ACTION
		ON UPDATE CASCAD

) ON [PRIMARY] 
GO


--------------------------------------------------------------------------
--===============| Create Nonclustered Index for product |===============--

CREATE NONCLUSTERED INDEX [IX_Products_CategoryID] 
	ON [dbo].[Products]
	([category_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX IX_Products_SupplierID
    ON [dbo].[Products]([supplier_id]);
GO

--=========|Clean, consistent constraint for Product Price |===============--

-- Constraint: The price of a product must be greater than zero

ALTER TABLE dbo.Products
ADD CONSTRAINT CK_Products_Price_Positive
CHECK (price > 0);
GO





