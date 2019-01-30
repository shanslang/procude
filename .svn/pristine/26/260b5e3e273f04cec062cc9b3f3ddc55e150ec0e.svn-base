
----------------------------------------------------------------------------------------------------

USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_StoneToGold]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_StoneToGold]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 丢弃物品
CREATE PROC GSP_GP_StoneToGold
	@dwUserID INT,								-- 用户 I D
	@stoneCount INT								-- 物品 I D
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	UPDATE UserCurrencyInfo SET Currency=Currency-@stoneCount WHERE UserID=@dwUserID AND Currency>=@stoneCount;
	IF (SELECT COUNT(*) FROM GameScoreInfo WHERE UserID=@dwUserID)=0
	BEGIN
		INSERT INTO GameScoreInfo(UserID) VALUES(@dwUserID);
	END
	IF @stoneCount=60
	BEGIN
		UPDATE GameScoreInfo SET score=score+60000 WHERE UserID=@dwUserID;
	END
	ELSE IF @stoneCount=180
	BEGIN
		UPDATE GameScoreInfo SET score=score+210000 WHERE UserID=@dwUserID;
	END
	ELSE IF @stoneCount=500
	BEGIN
		UPDATE GameScoreInfo SET score=score+600000 WHERE UserID=@dwUserID;
	END
	ELSE IF @stoneCount=980
	BEGIN
		UPDATE GameScoreInfo SET score=score+1250000 WHERE UserID=@dwUserID;
	END
	ELSE IF @stoneCount=1880
	BEGIN
		UPDATE GameScoreInfo SET score=score+2500000 WHERE UserID=@dwUserID;
	END
	ELSE IF @stoneCount=3280
	BEGIN
		UPDATE GameScoreInfo SET score=score+4580000 WHERE UserID=@dwUserID;
	END
	ELSE IF @stoneCount=5180
	BEGIN
		UPDATE GameScoreInfo SET score=score+7580000 WHERE UserID=@dwUserID;
	END
	ELSE IF @stoneCount=6980
	BEGIN
		UPDATE GameScoreInfo SET score=score+10900000 WHERE UserID=@dwUserID;
	END
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------