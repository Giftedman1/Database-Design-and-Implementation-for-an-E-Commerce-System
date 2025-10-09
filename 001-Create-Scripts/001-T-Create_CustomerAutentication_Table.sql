USE [GlobalGadgets]
GO

/****** Object:  Table [dbo].[CustomerAuth]   purpose: Stores login/authentication details for customers **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Create CustomerAuth Table |===============--

CREATE TABLE [dbo].[CustomerAuth](
	[auth_id]		[int] IDENTITY (10,1)	NOT NULL,
	[customer_id]	[int]					NOT NULL,
	[username]		[nvarchar](50)			NOT NULL,
	[password]		[nvarchar](50)			NOT NULL,
	
	-- PK
	CONSTRAINT [PK_CustomerAuth_ID] PRIMARY KEY CLUSTERED 
		([auth_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY],
	
	-- FK
	CONSTRAINT [FK_CustomerAuth_customer] FOREIGN KEY([customer_id])
		REFERENCES [dbo].[Customers] ([customer_id])

	
) ON [PRIMARY] 
GO

-- Enforce unique username
ALTER TABLE [dbo].[CustomerAuth] 
ADD CONSTRAINT UQ_CustomerAuth_Username UNIQUE ([username]);
GO