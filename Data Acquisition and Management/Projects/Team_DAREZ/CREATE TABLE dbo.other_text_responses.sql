SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Project3].[dbo].[other_text_responses]', N'U') IS NOT NULL   
	DROP TABLE [Project3].[dbo].[other_text_responses];  
GO

CREATE TABLE [dbo].[other_text_responses] (
[Q12_OTHER_TEXT] varchar(max),
[Q13_OTHER_TEXT] varchar(max),
[Q14_OTHER_TEXT] varchar(max),
[Q14_Part_1_TEXT] varchar(max),
[Q14_Part_2_TEXT] varchar(max),
[Q14_Part_3_TEXT] varchar(max),
[Q14_Part_4_TEXT] varchar(max),
[Q14_Part_5_TEXT] varchar(max),
[Q16_OTHER_TEXT] varchar(max),
[Q17_OTHER_TEXT] varchar(max),
[Q18_OTHER_TEXT] varchar(max),
[Q19_OTHER_TEXT] varchar(max),
[Q20_OTHER_TEXT] varchar(max),
[Q21_OTHER_TEXT] varchar(max),
[Q24_OTHER_TEXT] varchar(max),
[Q25_OTHER_TEXT] varchar(max),
[Q26_OTHER_TEXT] varchar(max),
[Q27_OTHER_TEXT] varchar(max),
[Q28_OTHER_TEXT] varchar(max),
[Q29_OTHER_TEXT] varchar(max),
[Q2_OTHER_TEXT] varchar(max),
[Q30_OTHER_TEXT] varchar(max),
[Q31_OTHER_TEXT] varchar(max),
[Q32_OTHER_TEXT] varchar(max),
[Q33_OTHER_TEXT] varchar(max),
[Q34_OTHER_TEXT] varchar(max),
[Q5_OTHER_TEXT] varchar(max),
[Q9_OTHER_TEXT] varchar(max)
)