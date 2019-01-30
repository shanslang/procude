
----------------------------------------------------------------------------------------------------

USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteGameScore]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteGameScore]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 游戏写分
CREATE PROC GSP_GR_WriteGameScore

	-- 用户信息
	@dwUserID INT,								-- 用户 I D
	@dwDBQuestID INT,							-- 请求标识
	@dwInoutIndex INT,							-- 进出索引

	-- 变更成绩
	@lVariationScore BIGINT,					-- 用户分数
	@lVariationGrade BIGINT,					-- 用户成绩
	@lVariationInsure BIGINT,					-- 用户银行
	@lVariationRevenue BIGINT,					-- 游戏税收
	@lVariationWinCount INT,					-- 胜利盘数
	@lVariationLostCount INT,					-- 失败盘数
	@lVariationDrawCount INT,					-- 和局盘数
	@lVariationFleeCount INT,					-- 逃跑数目
	@lVariationUserMedal BIGINT,				-- 用户奖牌
	@lVariationExperience INT,					-- 用户经验
	@lVariationLoveLiness INT,					-- 用户魅力
	@dwVariationPlayTimeCount INT,				-- 游戏时间

	-- 附加信息
	@cbTaskForward TINYINT,						-- 任务跟进

	-- 属性信息	
	@wKindID INT,								-- 游戏 I D
	@wServerID INT,								-- 房间 I D
	@strClientIP NVARCHAR(15)					-- 连接地址

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	--begin try
		--exec THRecordDB.dbo.GSP_GR_DJ_Win @dwUserID,@lVariationScore
	--end try
	--begin catch
	--end catch
	
--	UPDATE GameScoreInfo SET Score=0 WHERE UserID=@dwUserID AND Score<0
--	UPDATE GameScoreInfo SET InsureScore=0 WHERE UserID=@dwUserID AND InsureScore<0

	-- 全局信息
	--IF @lVariationExperience>0 OR @lVariationLoveLiness<>0 OR @lVariationUserMedal>0
	--BEGIN
		--UPDATE THAccountsDB.dbo.AccountsInfo SET Experience=Experience+@lVariationExperience, LoveLiness=LoveLiness+@lVariationLoveLiness,
			--UserMedal=UserMedal+@lVariationUserMedal
		--WHERE UserID=@dwUserID
	--END

	-- 变更记录
	DECLARE @DateID INT
    SELECT @DateID=CAST(CAST(GetDate() AS FLOAT) AS INT) 

	DECLARE @ReWinCount INT
	
	-- 存在判断
	--IF NOT EXISTS(SELECT * FROM StreamScoreInfo(NOLOCK) WHERE DateID=@DateID AND UserID=@dwUserID) 
	--BEGIN
		-- 插入记录
		--INSERT INTO StreamScoreInfo(DateID, UserID, WinCount, LostCount, ReWinCount, Revenue, PlayTimeCount, OnlineTimeCount, FirstCollectDate, LastCollectDate)
		--VALUES(@DateID, @dwUserID, @lVariationWinCount, @lVariationLostCount, 0, @lVariationRevenue, @dwVariationPlayTimeCount, 0, GetDate(), GetDate())		
	--END ELSE
	--BEGIN
		-- 查询连胜
		--SELECT @ReWinCount=ISNULL(ReWinCount,0) FROM StreamScoreInfo(NOLOCK) WHERE DateID=@DateID AND UserID=@dwUserID
		--IF @lVariationLostCount+@lVariationDrawCount>0
		--BEGIN
			--SET @ReWinCount=0
		--END
		--ELSE
		--BEGIN
			--SET @ReWinCount=@ReWinCount+1
		--END

		-- 更新记录
		--UPDATE StreamScoreInfo SET WinCount=WinCount+@lVariationWinCount, LostCount=LostCount+@lVariationLostCount, ReWinCount=@ReWinCount, Revenue=Revenue+@lVariationRevenue,
			--   PlayTimeCount=PlayTimeCount+@dwVariationPlayTimeCount, LastCollectDate=GetDate()
		--WHERE DateID=@DateID AND UserID=@dwUserID		
	--END
	
	if @wKindID = 7
	begin
		--德州专门记录
		update [THRecordDB].[dbo].[RecordUserCountInfo] set [DezSum]=[DezSum]+@lVariationScore where [UserID]=@dwUserID
		update [THRecordDB].[dbo].[RecordUserDayCount] set [DezSum]=[DezSum]+@lVariationScore where [UserID]=@dwUserID and [InsertDate] = convert(nvarchar(22),getdate(),110)
		if @@rowcount = 0
		begin
			INSERT INTO [THRecordDB].[dbo].[RecordUserDayCount] ([UserID],[InsertDate],[DezSum]) VALUES (@dwUserID,getdate(),@lVariationScore)
		end
	end
		
	-- 任务跟进
	IF @cbTaskForward=1
	BEGIN
		begin try
			exec THPlatformDB.dbo.GSP_GR_TaskForward @dwUserID,@wKindID,0,@lVariationWinCount,@lVariationLostCount,@lVariationDrawCount	
		end try
		begin catch
		end catch
	END
	
	-- 用户积分
	UPDATE GameScoreInfo SET Score=Score+@lVariationScore, Revenue=Revenue+@lVariationRevenue, InsureScore=InsureScore+@lVariationInsure
		--WinCount=WinCount+@lVariationWinCount, LostCount=LostCount+@lVariationLostCount, DrawCount=DrawCount+@lVariationDrawCount,
		--FleeCount=FleeCount+@lVariationFleeCount, PlayTimeCount=PlayTimeCount+@dwVariationPlayTimeCount
	WHERE UserID=@dwUserID
	
	-- 更新RecordVipzcPt的余额
	if @@ROWCOUNT > 0
	begin
		exec [THRecordDB].[dbo].[PHP_Record_RecordVipzcPt] @dwUserID,0
	end
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------