USE [master]
GO
/****** 对象:  Database [THRecordDB]    脚本日期: 07/29/2014 16:14:26 ******/
CREATE DATABASE [THRecordDB] ON  PRIMARY 
( NAME = N'THRecordDB', FILENAME = N'D:\数据库\THRecordDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'THRecordDB_log', FILENAME = N'D:\数据库\THRecordDB_log.LDF' , SIZE = 4096KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 COLLATE Chinese_PRC_CI_AS
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'THRecordDB', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [THRecordDB].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [THRecordDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [THRecordDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [THRecordDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [THRecordDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [THRecordDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [THRecordDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [THRecordDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [THRecordDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [THRecordDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [THRecordDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [THRecordDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [THRecordDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [THRecordDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [THRecordDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [THRecordDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [THRecordDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [THRecordDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [THRecordDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [THRecordDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [THRecordDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [THRecordDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [THRecordDB] SET  READ_WRITE 
GO
ALTER DATABASE [THRecordDB] SET RECOVERY FULL 
GO
ALTER DATABASE [THRecordDB] SET  MULTI_USER 
GO
ALTER DATABASE [THRecordDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [THRecordDB] SET DB_CHAINING OFF 