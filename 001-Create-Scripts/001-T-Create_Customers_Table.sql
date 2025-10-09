USE [GlobalGadgets]
GO

/****** Object:  Table [dbo].[Customers]  Purpose: Stores customer personal details  **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Create Customers Table |===============--


 CREATE TABLE [dbo].[Customers](
	[customer_id]				[int] IDENTITY(1,1)		NOT NULL, 
	[full_name]					[nvarchar] (100)		NOT NULL, 
	[date_of_birth]				[date]					NOT NULL,
	[address_id]				[int]					NOT NULL,
	[preferred_payment_method]	[int]					NULL,
	[email]						[nvarchar](100)			NULL,
	[phone_number]				[varchar](20)			NULL,
	[created_at]				[datetime]				NOT NULL	DEFAULT (getdate()),
	[deactivate_at]				[datetime]				NULL,
	
	-- PK
	CONSTRAINT [PK_Customers_customer_id] PRIMARY KEY CLUSTERED 
		([customer_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY],
	
	-- FK
	CONSTRAINT [FK_Customers_AddressID] FOREIGN KEY([address_id])
		REFERENCES [dbo].[Addresses] ([address_id]),

	-- FK
	CONSTRAINT [FK_Customers_PreferredPaymentMethod] FOREIGN KEY([preferred_payment_method])
		REFERENCES [dbo].[PaymentMethod] ([payment_method_id])
	
) ON [PRIMARY] 
GO



--------------------------------------------------------------------------
--===============| Create Nonclustered Index for Email |===============--

CREATE NONCLUSTERED INDEX [IX_Customers_email] 
	ON [dbo].[Customers]
	([email] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO

-----------------------------------------------------------
-- phone number validation
-----------------------------------------------------------
ALTER TABLE dbo.Customers
ADD CONSTRAINT CK_Customers_PhoneFormat
CHECK (
    phone_number IS NULL 
    OR (phone_number LIKE '+[0-9]%' AND LEN(phone_number) BETWEEN 7 AND 20)
);
GO
