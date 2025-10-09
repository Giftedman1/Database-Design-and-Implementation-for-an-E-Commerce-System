USE [GlobalGadgets]
GO

/****** Object:  Table [dbo].[Suppliers]     Purpose: Stores supplier information **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Create Suppliers Table |===============--

CREATE TABLE [dbo].[Suppliers] (
	[supplier_id]	[int] IDENTITY(100,100)		NOT NULL,
	[email]			[nvarchar] (200)			NOT NULL,
	[phone_number]	[nvarchar] (20)				NOT NULL,
	[address_id]	[int]						NOT NULL,
	[company_name]  [nvarchar] (50)				NOT NULL,
	[contact_name]	[nvarchar] (50)				NOT NULL,
	[contact_title]	[nvarchar] (30)				NOT NULL,


-- PK
	CONSTRAINT [PK_Suppliers_supplier_id] PRIMARY KEY CLUSTERED 
		([supplier_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY],

-- FK
	CONSTRAINT [FK_Suppliers_Addresses] FOREIGN KEY([address_id])
		REFERENCES [dbo].[Addresses] ([address_id])
)
GO

--------------------------------------------------------------------------
--===============| Create Nonclustered Index for supplier email |===============--

CREATE NONCLUSTERED INDEX [IX_Supplier_supplierEmail] 
	ON [dbo].[Suppliers]
	([email] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Indx for Supplier_Email |===============--
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX IX_Suppliers_Email
    ON [dbo].[Suppliers]([email])
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

-----------------------------------------------------------
-- phone number validation for Suppliers
-----------------------------------------------------------
ALTER TABLE dbo.Suppliers
ADD CONSTRAINT CK_Suppliers_PhoneFormat
CHECK (
    phone_number LIKE '+[0-9]%' 
    AND LEN(phone_number) BETWEEN 7 AND 20
);
GO




