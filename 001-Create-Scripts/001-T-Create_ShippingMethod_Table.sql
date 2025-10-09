USE [GlobalGadgets]
GO

/****** Object:  Table [dbo].ShippingMethod]		Purpose: Looking up table to choose shipment method  **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* ============================================================
    Lookup Table for Shipping Methods
   ============================================================ */

CREATE TABLE [dbo].[shippingMethod] (
    [shipping_method_id]    [int] IDENTITY(1,1)     NOT NULL,
    [method_name]           [NVARCHAR](100)         NOT NULL,

    -- PK
	CONSTRAINT [PK_ShippingMethod_shippingmethodID] PRIMARY KEY CLUSTERED
		([shipping_method_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Indx for ShippingMethod |===============--
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_ShippingMethod_methodname] 
	ON [dbo].[ShippingMethod]
	([method_name] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--=========| Adding CHECK Constraints |===============--

-- Constraint: Method_name must not be empty
ALTER TABLE dbo.ShippingMethod 
ADD CONSTRAINT CK_Method_Name_NotEmpty 
    CHECK (LEN(LTRIM(RTRIM(method_name))) > 0);
GO

-- Constraint: Only allow certain values
ALTER TABLE dbo.ShippingMethod 
ADD CONSTRAINT CK_Method_Name_Allowed 
    CHECK (payment_method IN ('Air Freight', 'Sea Freight', 'Land Freight', 'Courier'));
GO
