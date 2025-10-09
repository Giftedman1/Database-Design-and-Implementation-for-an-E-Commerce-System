USE [GlobalGadgets]
GO

/** Object:  Table [dbo].[PaymentMethod]  Purpose: Lookup table for valid payment methods  **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------
--===============| Create  PaymentMethod Table |===============--


CREATE TABLE [dbo].[PaymentMethod] (

	[payment_method_id]		[int] IDENTITY(100,100) NOT NULL, 
	[payment_method]		[varchar](20)			NOT NULL,

	-- PK
	CONSTRAINT [PK_PaymentMethod_PaymentMethodID] PRIMARY KEY CLUSTERED
		([payment_method_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Indx for PaymentMethod |===============--
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_PaymentMethod_paymentmethod] 
	ON [dbo].[PaymentMethod]
	([Payment_method] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--=========| Adding CHECK Constraints |===============--

-- Constraint: Payment_method must not be empty
ALTER TABLE dbo.PaymentMethod 
ADD CONSTRAINT CK_PaymentMethod_Name_NotEmpty 
    CHECK (LEN(LTRIM(RTRIM(payment_method))) > 0);
GO

-- Constraint: Only allow certain values
ALTER TABLE dbo.PaymentMethod 
ADD CONSTRAINT CK_PaymentMethod_Allowed 
    CHECK (payment_method IN ('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer'));
GO
