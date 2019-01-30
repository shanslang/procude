
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_GiftQuery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_GiftQuery]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_GiftQuery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_GiftQuery]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 渠道查询
CREATE PROC GSP_MB_GiftQuery
	@dwUserID INT,								-- 用户 I D
	@currencyType INT,								-- 用户 I D
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	SELECT PayAmount FROM THTreasureDBLink.THTreasureDB.dbo.ShareDetailInfo WHERE UserID=@dwUserID AND CurrencyType=@currencyType
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 渠道查询
CREATE PROC GSP_MB_FirstChargeQuery
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @res INT
	SET @res=0
	SELECT TOP 1 @res=FirstChargeQuery FROM THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	SELECT @res AS TakeStatus
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------