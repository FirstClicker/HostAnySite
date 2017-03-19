USE [master]
GO
CREATE LOGIN [DatabaseUserName] WITH PASSWORD=N'DatabaseUserpassword'
GO 
USE [DatabaseName]
GO
CREATE USER [DatabaseUserName] FOR LOGIN [DatabaseUserName] 
GO
EXEC sp_addrolemember 'db_owner', [DatabaseUserName] 