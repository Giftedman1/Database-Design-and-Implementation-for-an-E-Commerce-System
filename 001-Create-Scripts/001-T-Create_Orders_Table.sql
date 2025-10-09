USE [GlobalGadgets]
GO

/****** Object:  Table [dbo].[Orders]		Purpose: Stores customer orders   **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Create Orders Table |===============--


CREATE TABLE [dbo].[Orders](
	[order_id]				[int] IDENTITY(100,100)		NOT NULL, 
	[customer_id]			[int]						NOT NULL,
	[address_id]			[int]						NOT NULL,
	[order_date]			[datetime]					NOT NULL,
	[order_status]			[nvarchar](20)				NOT NULL,
	[shipping_method_id]	[nvarchar](30)				NOT NULL,

	-- PK
	CONSTRAINT [PK_Orders_order_id] PRIMARY KEY CLUSTERED 
		([order_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY],
	
	-- FK
	CONSTRAINT [FK_Orders_customer_id] FOREIGN KEY([customer_id])
		REFERENCES [dbo].[Customers] ([customer_id]) ON DELETE NO ACTION
		ON UPDATE CASCADE,
	
	-- FK
	CONSTRAINT [FK_Orders_address] FOREIGN KEY([address_id])
		REFERENCES [dbo].[Addresses] ([address_id]),

	-- FK
	CONSTRAINT [FK_Order_shipping_method_id] FOREIGN KEY([shipping_method_id])
		REFERENCES [dbo].[ShippingMethod] ([Shpping_method_id])
	
) ON [PRIMARY] 
GO

--------------------------------------------------------------------------
--===============| Create Nonclustered Index for Order |===============--

CREATE NONCLUSTERED INDEX [IX_Orders_Status] 
	ON [dbo].[Orders]
	([order_status] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX IX_Orders_CustomerID 
    ON dbo.Orders(customer_id);
GO

CREATE NONCLUSTERED INDEX IX_Orders_ShippingMethodID 
    ON dbo.Orders(shipping_method_id);
GO

-- Constraint: Only allow certain values

ALTER TABLE dbo.Orders 
ADD CONSTRAINT CK_OrderStatus_Allowed 
    CHECK (order_status IN ('Pending','Processing','Shipped','Delivered', 'Cancelled'));
GO

-- Add default value to order_date
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT DF_Orders_OrderDate DEFAULT (GETDATE()) FOR [order_date];
GO
