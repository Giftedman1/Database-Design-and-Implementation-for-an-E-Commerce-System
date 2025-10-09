USE [GlobalGadgets]
GO

/****** Object:  Table [dbo].[Payments]  Purpose: Stores payment transactions for orders **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Create Payments Table |===============--

CREATE TABLE [dbo].[Payments] (
	[payment_id]		[int] IDENTITY (1,1)	NOT NULL,
	[order_id]			[int]					NOT NULL,
	[payment_method_id] [int]					NOT NULL,
	[payment_amount]	[decimal] (10,2)		NOT NULL CHECK (payment_amount > 0),
	[payment_status]	[nvarchar] (20)			NOT NULL, 

	-- PK
	CONSTRAINT [PK_Payments_PaymentID] PRIMARY KEY CLUSTERED 
		([payment_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY],
	
	-- FK
	CONSTRAINT [FK_Payments_order_id] FOREIGN KEY([order_id])
		REFERENCES [dbo].[Orders] ([order_id]) ON DELETE CASCADE
		ON UPDATE CASCADE,

		-- FK
	CONSTRAINT [FK_Payments_method_id] FOREIGN KEY([payment_method_id])
		REFERENCES [dbo].[PaymentMethod] ([payment_method_id]) ON DELETE NO ACTION
		ON UPDATE CASCADE,

	
) ON [PRIMARY] 
GO


--------------------------------------------------------------------------
--===============| Create Nonclustered Index for payment|===============--

CREATE NONCLUSTERED INDEX [IX_Payments_status] 
	ON [dbo].[Payments]
	([payment_status] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX IX_Payments_OrderID 
    ON dbo.Payments(order_id);
GO

CREATE NONCLUSTERED INDEX IX_Payments_PaymentMethodID 
    ON dbo.Payments(payment_method_id);
GO

--=========| Adding CHECK Constraints |===============--
ALTER TABLE dbo.Payments
ADD CONSTRAINT CK_PaymentStatus_Allowed 
    CHECK(payment_status IN ('Pending', 'Success','Failed','Refunded'))
GO


-- Add index for payment_method_id
CREATE NONCLUSTERED INDEX IX_Payments_MethodID
    ON [dbo].[Payments]([payment_method_id]);
GO
