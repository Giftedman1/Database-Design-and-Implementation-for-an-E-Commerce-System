USE [GlobalGadgets]
GO

/****** Object:  Table [dbo].[Reviews]   Purpose: Stores product reviews from customers **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Create Reviews Table |===============--

CREATE TABLE [dbo].[Reviews](
	[review_id]		[int] IDENTITY (1,1)	NOT NULL,
	[customer_id]	[int]					NOT NULL,
	[product_id]	[int]					NOT NULL,
	[rating]		[int]					NOT NULL CHECK (Rating BETWEEN 1 AND 5),
	[comment]		[nvarchar](MAX)			NULL,
	[review_date]	[datetime]				NOT NULL DEFAULT SYSUTCDATETIME(),

	-- PK
	CONSTRAINT [PK_Reviews_reviewID] PRIMARY KEY CLUSTERED 
		([review_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY],
	
	-- FK
	CONSTRAINT [FK_Reviews_customer] FOREIGN KEY([customer_id])
		REFERENCES [dbo].[Customers] ([customer_id]),

	-- FK
	CONSTRAINT [FK_Reviews_Product] FOREIGN KEY([product_id])
		REFERENCES [dbo].[Products] ([product_id])
	
) ON [PRIMARY] 
GO


--------------------------------------------------------------------------
--===============| Create Nonclustered Index for product_id |===============--

CREATE NONCLUSTERED INDEX [IX_Review_product] 
	ON [dbo].[Reviews]
	([product_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO


-- Fix check constraint by dropping and recreating
ALTER TABLE [dbo].[Reviews]
DROP CONSTRAINT [PK_Reviews_reviewID]; -- drop only if needed for dependency
ALTER TABLE [dbo].[Reviews]
ADD CONSTRAINT CK_Reviews_Rating CHECK (rating BETWEEN 1 AND 5);
GO

