USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_ClearOnlineUser]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_ClearOnlineUser]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 清理在线玩家
CREATE PROC [dbo].[GSP_GR_ClearOnlineUser]
	@dwKindID INT,								
	@dwServerID INT						
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	-- 清理在线玩家
	DELETE FROM GameScoreLocker WHERE (KindID=@dwKindID AND ServerID=@dwServerID)
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------