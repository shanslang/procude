
----------------------------------------------------------------------------------------------------

USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteGamePackage]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteGamePackage]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 写入背包
CREATE PROC GSP_GR_WriteGamePackage
	@dwUserID INT,								-- 用户 I D
	@dwGoodsID INT,								-- 物品 I D
	@dwGoodsCount INT							-- 物品数量
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	-- 更新物品
	UPDATE THAccountsDBLink.THAccountsDB.dbo.AccountsPackage SET GoodsCount=GoodsCount+@dwGoodsCount WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- 插入物品
	IF @@ROWCOUNT=0
	BEGIN
		INSERT THAccountsDBLink.THAccountsDB.dbo.AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@dwGoodsID,@dwGoodsCount)
	END

	-- 背包记录
	INSERT THAccountsDBLink.THAccountsDB.dbo.PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) 
	VALUES (@dwUserID,2,@dwGoodsID,@dwGoodsCount,N'游戏获得')
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------