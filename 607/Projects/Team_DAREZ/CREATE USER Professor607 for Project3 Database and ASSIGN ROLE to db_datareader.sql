USE [Project3]

CREATE USER [Professor607] FOR LOGIN [Professor607] WITH DEFAULT_SCHEMA=[dbo];  
GO  

ALTER ROLE [db_datareader] ADD MEMBER [Professor607] ;  
GO  