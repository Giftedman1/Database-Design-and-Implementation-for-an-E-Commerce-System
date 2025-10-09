USE [GlobalGadgets]
GO

/****** Object:  Table [dbo].[ProductCategory]   Purpose: predefined tiers for Products **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Create Product Category Table |===============--

CREATE TABLE [dbo].[ProductCategory] (
	[category_id]		[int] IDENTITY(100,100)		NOT NULL,
	[category_name]				[nvarchar](100)		NOT NULL,
	

	-- PK
	CONSTRAINT [PK_ProductCategory_CategoryID] PRIMARY KEY CLUSTERED 
		([category_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY]
)ON [PRIMARY]
GO


--------------------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Indx for catergory_name |===============--
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductCategory_Name] 
	ON [dbo].[ProductCategory]
	([category_name] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

------------- Rule 1: CategoryName must not be empty--------------
ALTER TABLE dbo.ProductCategory 
ADD CONSTRAINT CK_ProductCategory_NotEmpty
    CHECK (LEN(LTRIM(RTRIM(category_nameCategoryName))) > 0);
GO

---------- Rule 2: Only allow specific values---------------
ALTER TABLE dbo.ProductCategory 
ADD CONSTRAINT CK_ProductCategory_Allowed
    CHECK (category_name IN ('Premium', 'Standard', 'Budget'));
GO
