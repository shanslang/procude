
USE master
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'THAccountsDB')
DROP DATABASE [THAccountsDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'THGameMatchDB')
DROP DATABASE [THGameMatchDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'THGameScoreDB')
DROP DATABASE [THGameScoreDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'THPlatformDB')
DROP DATABASE [THPlatformDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'THRecordDB')
DROP DATABASE [THRecordDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'THTreasureDB')
DROP DATABASE [THTreasureDB]
GO


