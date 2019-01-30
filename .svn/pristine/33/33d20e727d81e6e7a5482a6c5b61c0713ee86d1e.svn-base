
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_RankList]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_RankList]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_RankSelf]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_RankSelf]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 排行榜查询
CREATE PROC GSP_MB_RankList
	@dwUserID INT,								-- 用户 I D
	@dwType INT,								-- 1财富榜 2赢金榜
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @sec INT
	DECLARE @dwUserIDMax INT
	SET @sec=90000000
	IF @dwType=1
	BEGIN
		SELECT TOP 1 @sec = DATEDIFF(SECOND,InsertTime,GETDATE()) FROM THTreasureDB.dbo.GameScoreInfoRank1
		IF @sec>7200
		BEGIN
		DELETE FROM THTreasureDB.dbo.GameScoreInfoRank1;
		INSERT INTO THTreasureDB.dbo.GameScoreInfoRank1(NickName, UserID, FaceID, Score) SELECT TOP 80 b.NickName,b.UserID,b.FaceID,a.Score+a.InsureScore AS Score FROM THTreasureDB.dbo.GameScoreInfo a LEFT JOIN AccountsInfo b ON a.UserID=b.UserID WHERE b.NickName IS NOT NULL AND b.IsAndroid=1 ORDER BY a.Score DESC
		UPDATE THTreasureDB.dbo.GameScoreInfoRank1 SET Score=FLOOR(RAND((checksum(newid())))*DATEDIFF(SECOND,'2018-01-01',GETDATE()))+500000
		UPDATE THTreasureDB.dbo.GameScoreInfoRank1 SET Score=FLOOR(RAND((checksum(newid())))*DATEDIFF(SECOND,'2010-01-01',GETDATE()))+100000000 WHERE UserID IN(SELECT UserID FROM (SELECT TOP 3 UserID FROM THTreasureDB.dbo.GameScoreInfoRank1 WHERE Score<100000000 ORDER BY Score) t)
		INSERT INTO THTreasureDB.dbo.GameScoreInfoRank1(NickName, UserID, FaceID, Score) SELECT TOP 20 b.NickName,b.UserID,b.FaceID,a.Score+a.InsureScore AS Score FROM THTreasureDB.dbo.GameScoreInfo a LEFT JOIN AccountsInfo b ON a.UserID=b.UserID WHERE b.GameID NOT IN(127085,127086,127087) AND b.NickName IS NOT NULL AND b.IsAndroid=0 ORDER BY a.Score+a.InsureScore DESC
--		UPDATE THTreasureDB.dbo.GameScoreInfoRank1 SET Score=FLOOR(RAND((checksum(newid())))*DATEDIFF(SECOND,'1970-01-01',GETDATE()))+500000 WHERE THTreasureDB.dbo.GameScoreInfoRank1.Score<5000000 AND EXISTS(SELECT 1 FROM THAccountsDB.dbo.AccountsInfo WHERE UserID=THTreasureDB.dbo.GameScoreInfoRank1.UserID AND IsAndroid=1)
--		UPDATE THTreasureDB.dbo.GameScoreInfoRank1 SET Score=FLOOR(RAND((checksum(newid())))*DATEDIFF(SECOND,'2018-01-01',GETDATE()))+130000000 WHERE UserID=@dwUserIDMax
		END
		SELECT NickName,UserID,FaceID,Score FROM THTreasureDB.dbo.GameScoreInfoRank1 ORDER BY Score DESC
--		SELECT TOP 100 b.NickName,b.UserID,b.FaceID,a.Score+a.InsureScore AS Score FROM THTreasureDB.dbo.GameScoreInfo a LEFT JOIN AccountsInfo b ON a.UserID=b.UserID ORDER BY a.Score+a.InsureScore DESC
	END
	ELSE
	BEGIN
		SELECT TOP 1 @sec = DATEDIFF(SECOND,InsertTime,GETDATE()) FROM THTreasureDB.dbo.GameScoreInfoRank2
		IF @sec>7200
		BEGIN
		DELETE FROM THTreasureDB.dbo.GameScoreInfoRank2;
		INSERT INTO THTreasureDB.dbo.GameScoreInfoRank2(NickName, UserID, FaceID, Score) SELECT TOP 80 b.NickName,b.UserID,b.FaceID,a.GameSum AS Score from THRecordDB.[dbo].[RecordUserCountInfo] a LEFT JOIN THAccountsDB.dbo.AccountsInfo b ON a.UserID=b.UserID WHERE b.NickName IS NOT NULL AND b.IsAndroid=1 order by [GameSum] desc
		UPDATE THTreasureDB.dbo.GameScoreInfoRank2 SET Score=FLOOR(RAND((checksum(newid())))*DATEDIFF(SECOND,'2018-01-01',GETDATE()))+100000
		UPDATE THTreasureDB.dbo.GameScoreInfoRank2 SET Score=FLOOR(RAND((checksum(newid())))*DATEDIFF(SECOND,'2010-01-01',GETDATE()))+100000000 WHERE UserID IN(SELECT UserID FROM (SELECT TOP 5 UserID FROM THTreasureDB.dbo.GameScoreInfoRank2 WHERE Score<100000000 ORDER BY Score) t)
		INSERT INTO THTreasureDB.dbo.GameScoreInfoRank2(NickName, UserID, FaceID, Score) SELECT TOP 20 b.NickName,b.UserID,b.FaceID,a.GameSum AS Score from THRecordDB.[dbo].[RecordUserCountInfo] a LEFT JOIN THAccountsDB.dbo.AccountsInfo b ON a.UserID=b.UserID WHERE b.GameID NOT IN(127085,127086,127087) AND b.NickName IS NOT NULL AND b.IsAndroid=0 order by [GameSum] desc
--		UPDATE THTreasureDB.dbo.GameScoreInfoRank2 SET Score=FLOOR(RAND((checksum(newid())))*DATEDIFF(SECOND,'2018-01-01',GETDATE()))+100000 WHERE THTreasureDB.dbo.GameScoreInfoRank2.Score<100000 AND EXISTS(SELECT 1 FROM THAccountsDB.dbo.AccountsInfo WHERE UserID=THTreasureDB.dbo.GameScoreInfoRank2.UserID AND IsAndroid=1)
--		UPDATE THTreasureDB.dbo.GameScoreInfoRank2 SET Score=FLOOR(RAND((checksum(newid())))*DATEDIFF(SECOND,'2018-01-01',GETDATE()))+130000000 WHERE UserID=@dwUserIDMax
		END
		SELECT NickName,UserID,FaceID,Score FROM THTreasureDB.dbo.GameScoreInfoRank2 ORDER BY Score DESC
--		select top 100 b.NickName,b.UserID,b.FaceID,a.GameSum AS Score from THRecordDB.[dbo].[RecordUserCountInfo] a LEFT JOIN THAccountsDB.dbo.AccountsInfo b ON a.UserID=b.UserID order by [GameSum] desc
	END
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 排行榜查询
CREATE PROC GSP_MB_RankSelf
	@dwUserID INT,								-- 用户 I D
	@dwType INT,							-- 用户 I D
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @Score BIGINT
	SET @Score=0
	IF @dwType=1
	BEGIN
		UPDATE THTreasureDB.dbo.GameScoreInfoRank1 SET score=(SELECT score+InsureScore FROM THTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID) WHERE UserID=@dwUserID
		SELECT @Score=Score FROM THTreasureDB.dbo.GameScoreInfoRank1 WHERE UserID=@dwUserID
		IF @Score>0
		BEGIN
			SELECT @Score AS 'Score',COUNT(*)+1 AS 'Rank' FROM THTreasureDB.dbo.GameScoreInfoRank1 WHERE Score>@Score
		END
		ELSE
		BEGIN
			SELECT @Score=Score+InsureScore FROM THTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID
			SELECT @Score AS 'Score',COUNT(*)+201 AS 'Rank' FROM THTreasureDB.dbo.GameScoreInfo WHERE Score+InsureScore>=@Score
		END
	END
	ELSE
	BEGIN
		SELECT @Score=Score FROM THTreasureDB.dbo.GameScoreInfoRank2 WHERE UserID=@dwUserID
		IF @Score>0
		BEGIN
			SELECT @Score AS 'Score',COUNT(*)+1 AS 'Rank' FROM THTreasureDB.dbo.GameScoreInfoRank2 WHERE Score>@Score
		END
		ELSE
		BEGIN
			SELECT @Score=GameSum FROM THRecordDB.[dbo].[RecordUserCountInfo] WHERE UserID=@dwUserID
			SELECT @Score AS 'Score',COUNT(*)+201 AS 'Rank' FROM THRecordDB.[dbo].[RecordUserCountInfo] WHERE GameSum>=@Score
		END
	END
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------