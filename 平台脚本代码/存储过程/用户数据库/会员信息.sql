
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_GetVIPInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_GetVIPInfo]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_SetVIPInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_SetVIPInfo]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_DelVIPInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_DelVIPInfo]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 获取会员信息
CREATE PROC GSP_GP_GetVIPInfo
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	SELECT NickName,QQNumber,DescribeString FROM GameVIPInfo
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 设置会员信息
CREATE PROC GSP_GP_SetVIPInfo
	@dwUserID INT,
	@strPassword NCHAR(32),
	@strNickName NVARCHAR(31),
	@strQQNumber NVARCHAR(15),
	@strDescribeString NVARCHAR(127),
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @MemberOrder AS TINYINT
	
	SELECT @LogonPass=LogonPass, @MemberOrder=MemberOrder FROM AccountsInfo WHERE UserID=@dwUserID
	
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的账户信息有误，请查证后再次尝试！'
		RETURN 1
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的密码输入有误，请查证后再次尝试！'
		RETURN 2
	END

	-- 会员判断
	IF @MemberOrder<>10
	BEGIN
		SET @strErrorDescribe=N'抱歉，您不是超级会员，没有此功能权限！'
		RETURN 3
	END
	
	IF EXISTS(SELECT * FROM GameVIPInfo WHERE UserID=@dwUserID)
	BEGIN
		UPDATE GameVIPInfo SET NickName=@strNickName,QQNumber=@strQQNumber,DescribeString=@strDescribeString WHERE UserID=@dwUserID
	END
	ELSE
	BEGIN
		INSERT INTO GameVIPInfo(UserID, NickName, QQNumber, DescribeString) VALUES(@dwUserID, @strNickName, @strQQNumber, @strDescribeString)
	END
	
	SELECT NickName,QQNumber,DescribeString FROM GameVIPInfo
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 删除会员信息
CREATE PROC GSP_GP_DelVIPInfo
	@dwUserID INT,
	@strPassword NCHAR(32),
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID
	
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的账户信息有误，请查证后再次尝试！'
		RETURN 1
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的密码输入有误，请查证后再次尝试！'
		RETURN 2
	END
	
	IF EXISTS(SELECT * FROM GameVIPInfo WHERE UserID=@dwUserID)
	BEGIN
		DELETE FROM GameVIPInfo WHERE UserID=@dwUserID
	END
	ELSE
	BEGIN
		SET @strErrorDescribe=N'您要删除的信息不存在，请查证后再次尝试！'
		RETURN 3
	END
	
	SELECT NickName,QQNumber,DescribeString FROM GameVIPInfo
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
