----------------------------------------------------------------------
-- 版权：2017
-- 时间：2017-06-09
-- 用途：充值记录
----------------------------------------------------------------------

USE [THTreasureDB]
GO

-- 充值记录
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_RechargeRecord') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_RechargeRecord
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

---------------------------------------------------------------------------------------
-- 充值记录
CREATE PROCEDURE NET_PW_RechargeRecord
	@strOrderID			NVARCHAR(50),			--	订单编号
	@strIPAddress		NVARCHAR(31),			--	请求地址
	@strErrorDescribe	NVARCHAR(127) OUTPUT	--	输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 记录信息
DECLARE @Accounts NVARCHAR(31)
DECLARE @PayAmount DECIMAL(18,2)
DECLARE @ShareName NVARCHAR(32)
DECLARE @PlatformID INT

-- 执行逻辑
BEGIN

	-- 记录查询
	DECLARE @ShareID INT
	DECLARE @UserID INT
	SELECT @ShareID=ShareID, @UserID=UserID, @PayAmount=PayAmount FROM ShareDetailInfo WHERE OrderID=@strOrderID
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值记录不存在。'
		RETURN 1
	END

	-- 用户信息
	SELECT @Accounts=Accounts, @PlatformID=PlatformID FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@UserID
	IF @Accounts IS NULL
	BEGIN
		SET @strErrorDescribe=N'用户信息有误，请重试！'
		RETURN 2
	END

	-- 充值平台
	SELECT @ShareName=ShareName FROM GlobalShareInfo WHERE ShareID=@ShareID
	IF @ShareName IS NULL
	BEGIN
		SET @strErrorDescribe=N'充值平台信息有误，请重试！'
		RETURN 3
	END

	-- 输出数据
	SELECT @Accounts AS Accounts, @PayAmount AS PayAmount, @ShareName AS ShareName, @PlatformID AS PlatformID

END

RETURN 0

GO