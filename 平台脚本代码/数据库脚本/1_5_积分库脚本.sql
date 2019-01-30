USE [master]
GO
/****** 对象:  Database [THGameScoreDB]    脚本日期: 07/29/2014 16:13:35 ******/
CREATE DATABASE [THGameScoreDB] ON  PRIMARY 
( NAME = N'THGameScoreDB', FILENAME = N'D:\数据库\THGameScoreDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'THGameScoreDB_log', FILENAME = N'D:\数据库\THGameScoreDB_log.LDF' , SIZE = 4096KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 COLLATE Chinese_PRC_CI_AS
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'THGameScoreDB', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [THGameScoreDB].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [THGameScoreDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [THGameScoreDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [THGameScoreDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [THGameScoreDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [THGameScoreDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [THGameScoreDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [THGameScoreDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [THGameScoreDB] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [THGameScoreDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [THGameScoreDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [THGameScoreDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [THGameScoreDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [THGameScoreDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [THGameScoreDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [THGameScoreDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [THGameScoreDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [THGameScoreDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [THGameScoreDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [THGameScoreDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [THGameScoreDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [THGameScoreDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [THGameScoreDB] SET  READ_WRITE 
GO
ALTER DATABASE [THGameScoreDB] SET RECOVERY FULL 
GO
ALTER DATABASE [THGameScoreDB] SET  MULTI_USER 
GO
ALTER DATABASE [THGameScoreDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [THGameScoreDB] SET DB_CHAINING OFF 