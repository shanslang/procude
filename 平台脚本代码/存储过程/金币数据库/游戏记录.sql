
----------------------------------------------------------------------------------------------------

USE THStreamDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_RecordDrawInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_RecordDrawInfo]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_RecordDrawScore]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_RecordDrawScore]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 游戏记录
CREATE PROC GSP_GR_RecordDrawInfo

	-- 房间信息
	@wKindID INT,								-- 游戏 I D
	@wServerID INT,								-- 房间 I D

	-- 桌子信息
	@wTableID INT,								-- 桌子号码
	@wUserCount INT,							-- 用户数目
	@wAndroidCount INT,							-- 机器数目

	-- 税收损耗
	@lWasteCount BIGINT,						-- 损耗数目
	@lRevenueCount BIGINT,						-- 游戏税收

	-- 统计信息
	@dwUserMemal BIGINT,						-- 损耗数目
	@dwPlayTimeCount INT,						-- 游戏时间

	-- 时间信息
	@SystemTimeStart DATETIME,					-- 开始时间
	@SystemTimeConclude DATETIME				-- 结束时间

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN

	-- 插入记录
	declare @Day int
	set @Day = day(getdate())
	if @Day = 1
	INSERT RecordDrawInfo1(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 2
	INSERT RecordDrawInfo2(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 3
	INSERT RecordDrawInfo3(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 4
	INSERT RecordDrawInfo4(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 5
	INSERT RecordDrawInfo5(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 6
	INSERT RecordDrawInfo6(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 7
	INSERT RecordDrawInfo7(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 8
	INSERT RecordDrawInfo8(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 9
	INSERT RecordDrawInfo9(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 10
	INSERT RecordDrawInfo10(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 11
	INSERT RecordDrawInfo11(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 12
	INSERT RecordDrawInfo12(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 13
	INSERT RecordDrawInfo13(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 14
	INSERT RecordDrawInfo14(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 15
	INSERT RecordDrawInfo15(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 16
	INSERT RecordDrawInfo16(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 17
	INSERT RecordDrawInfo17(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 18
	INSERT RecordDrawInfo18(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 19
	INSERT RecordDrawInfo19(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 20
	INSERT RecordDrawInfo20(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 21
	INSERT RecordDrawInfo21(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 22
	INSERT RecordDrawInfo22(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 23
	INSERT RecordDrawInfo23(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 24
	INSERT RecordDrawInfo24(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 25
	INSERT RecordDrawInfo25(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 26
	INSERT RecordDrawInfo26(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 27
	INSERT RecordDrawInfo27(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 28
	INSERT RecordDrawInfo28(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 29
	INSERT RecordDrawInfo29(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 30
	INSERT RecordDrawInfo30(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	else if @Day = 31
	INSERT RecordDrawInfo31(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	
	
	-- 读取记录
	SELECT SCOPE_IDENTITY() AS DrawID

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 游戏记录
CREATE PROC GSP_GR_RecordDrawScore

	-- 房间信息
	@dwDrawID INT,								-- 局数标识
	@dwUserID INT,								-- 用户标识
	@wChairID INT,								-- 椅子号码

	-- 用户信息
	@dwDBQuestID INT,							-- 请求标识
	@dwInoutIndex INT,							-- 进出索引

	-- 成绩信息
	@lScore BIGINT,								-- 用户积分
	@lGrade BIGINT,								-- 用户成绩
	@lRevenue BIGINT,							-- 用户税收
	@dwUserMedal INT,							-- 奖牌数目
	@dwPlayTimeCount INT						-- 游戏时间

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN

	-- 插入记录
	declare @Day int
	set @Day = day(getdate())
	if @Day = 1
	INSERT RecordDrawScore1(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 2
	INSERT RecordDrawScore2(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 3
	INSERT RecordDrawScore3(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 4
	INSERT RecordDrawScore4(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 5
	INSERT RecordDrawScore5(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 6
	INSERT RecordDrawScore6(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 7
	INSERT RecordDrawScore7(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 8
	INSERT RecordDrawScore8(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 9
	INSERT RecordDrawScore9(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 10
	INSERT RecordDrawScore10(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 11
	INSERT RecordDrawScore11(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 12
	INSERT RecordDrawScore12(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 13
	INSERT RecordDrawScore13(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 14
	INSERT RecordDrawScore14(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 15
	INSERT RecordDrawScore15(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 16
	INSERT RecordDrawScore16(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 17
	INSERT RecordDrawScore17(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 18
	INSERT RecordDrawScore18(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 19
	INSERT RecordDrawScore19(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 20
	INSERT RecordDrawScore20(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 21
	INSERT RecordDrawScore21(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 22
	INSERT RecordDrawScore22(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 23
	INSERT RecordDrawScore23(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 24
	INSERT RecordDrawScore24(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 25
	INSERT RecordDrawScore25(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 26
	INSERT RecordDrawScore26(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 27
	INSERT RecordDrawScore27(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 28
	INSERT RecordDrawScore28(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 29
	INSERT RecordDrawScore29(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 30
	INSERT RecordDrawScore30(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	else if @Day = 31
	INSERT RecordDrawScore31(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
