USE [GlobalGadgets]
GO

/****** Object:  Table [dbo].[OrderDetails]   Purpose: records for each product purchased within an order **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Orderdetails Table |===============--

CREATE TABLE [dbo].[OrderDetails] (
	[order_details_id]	[int] IDENTITY(10,10)		NOT NULL,
	[order_id]			[int]						NOT NULL,
	[product_id]		[int]						NOT NULL,
	[quantity]			[int]						NOT NULL CHECK(Quantity > 0),
	[unitPrice]			[decimal](10,2)				NOT NULL CHECK (UnitPrice>= 0),

	-- PK
	CONSTRAINT [PK_OrderDetails_OrderDetailsID] PRIMARY KEY CLUSTERED 
		([order_details_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY],
	
	-- FK
	CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([order_id])
		REFERENCES [dbo].[Orders] ([order_id]) ON DELETE CASCADE
		ON UPDATE CASCADE,
	
	-- FK
	CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([product_id])
		REFERENCES [dbo].[Products] ([product_id]) ON DELETE NO ACTION
		ON UPDATE CASCADE

) ON [PRIMARY] 
GO


--------------------------------------------------------------------------
--===============| Create Nonclustered Index for OrderID |===============--

CREATE NONCLUSTERED INDEX [IX_OrderDetails_OrderID] 
	ON [dbo].[OrderDetails]
	([order_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO

--------------------------------------------------------------------------
--===============| Create Nonclustered Index for ProductID |===============--

CREATE NONCLUSTERED INDEX [IX_OrderDetails_ProductID] 
	ON [dbo].[OrderDetails]
	([product_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO


-- Prevent duplicate product rows in the same order
ALTER TABLE [dbo].[OrderDetails]
ADD CONSTRAINT UQ_OrderDetails_Order_Product UNIQUE ([order_id], [product_id]);
GO

