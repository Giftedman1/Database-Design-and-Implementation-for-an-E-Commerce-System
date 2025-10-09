USE [GlobalGadgets]
GO

/****** Object:  Table [dbo].[Addresses]   Purpose: Stores normalized addresses for Customers, Suppliers, and Orders  **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Create Addresses Table |===============--

CREATE TABLE [dbo].[Addresses] (
	[address_id]		[int] IDENTITY(10,10)		NOT NULL,
	[line1]				[nvarchar](100)				NOT NULL,
	[line2]				[nvarchar](100)				NULL,
	[city]				[nvarchar](50)				NOT NULL,
	[state]				[nvarchar](50)				NULL,
	[postal_code]		[nvarchar](20)				NOT NULL,
	[country]			[nvarchar](50)				NOT NULL,


	-- PK
	CONSTRAINT [PK_Addresses_AddressID] PRIMARY KEY CLUSTERED 
		([address_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY]
)ON [PRIMARY]
GO


--------------------------------------------------------------------------
--===============| Create Nonclustered Index for postalcode |===============--

CREATE NONCLUSTERED INDEX [IX_Addresses_PostalCode] 
	ON [dbo].[Addresses]
	([postal_code] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO




