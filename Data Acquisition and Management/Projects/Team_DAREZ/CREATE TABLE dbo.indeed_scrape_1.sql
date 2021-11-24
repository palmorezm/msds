SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Project3].[dbo].[indeed_scrape_1]', N'U') IS NOT NULL   
	DROP TABLE [Project3].[dbo].[indeed_scrape_1];  
GO

CREATE TABLE [dbo].[indeed_scrape_1] (
	[SurveyID] INT IDENTITY(1,1) NOT NULL,
	[source] [nvarchar](255) NULL,
	[title] nvarchar(4000) NULL,
	[company] nvarchar(255) NULL,
	[location] nvarchar(255) NULL,
	[summary] nvarchar(MAX) NULL,
	[link] nvarchar(MAX) NULL,
PRIMARY KEY CLUSTERED
(
	[SurveyID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
