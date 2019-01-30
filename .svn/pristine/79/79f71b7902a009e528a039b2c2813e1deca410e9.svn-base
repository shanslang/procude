----------------------------------------------------------------------------------------------------

USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_MachineChannel]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_MachineChannel]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 渠道查询
CREATE PROC GSP_GR_MachineChannel
	@dwUserID INT								-- 用户 I D
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @Money BIGINT
	SET @Money = 0
	SELECT @Money=SUM(c.PayAmount) FROM THTreasureDB.dbo.ShareDetailInfo c WHERE c.UserID=@dwUserID
	IF @Money IS NULL SET @Money = 0
	SELECT TOP 1 a.[UserID],a.[SpreaderID] AS ChannelID,a.[LastLogonMachine] AS MachineIDLogin,a.[RegisterMachine] AS MachineIDReg,b.Score AS Score, b.InsureScore AS Insure, @Money AS Money FROM [THAccountsDB].[dbo].[AccountsInfo] a LEFT JOIN THTreasureDB.dbo.GameScoreInfo b ON a.UserID=b.UserID WHERE a.UserID=@dwUserID
END

RETURN 0

GO
