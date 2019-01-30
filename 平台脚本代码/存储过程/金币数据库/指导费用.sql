
----------------------------------------------------------------------------------------------------

USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteGuideScore]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteGuideScore]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 指导费用
CREATE PROC GSP_GR_WriteGuideScore
	@dwUserID INT,								-- 用户 I D
	@dwTargetUserID INT,						-- 目标用户
	@lGuideScore BIGINT							-- 指导费用
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	
	DECLARE @SourceScore BIGINT
	DECLARE @SourceInsure BIGINT
	DECLARE @TargetScore BIGINT
	DECLARE @TargetInsure BIGINT

	-- 金币查询
	SELECT @SourceScore=Score, @SourceInsure=InsureScore FROM GameScoreInfo(NOLOCK) WHERE UserID=@dwUserID

	-- 金币查询
	SELECT @TargetScore=Score, @TargetInsure=InsureScore FROM GameScoreInfo(NOLOCK) WHERE UserID=@dwTargetUserID

	IF @SourceScore=NULL SET @SourceScore=0
	IF @SourceInsure=NULL SET @SourceInsure=0
	IF @TargetScore=NULL SET @TargetScore=0
	IF @TargetInsure=NULL SET @TargetInsure=0

	-- 记录日志
	INSERT INTO RecordPayGuide(SourceUserID, SourceScore, SourceInsure, TargetUserID, TargetScore, TargetInsure, GuideScore)
	VALUES (@dwUserID, @SourceScore, @SourceInsure, @dwTargetUserID, @TargetScore, @TargetInsure, @lGuideScore)

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------