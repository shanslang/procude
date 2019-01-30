
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

-- ָ������
CREATE PROC GSP_GR_WriteGuideScore
	@dwUserID INT,								-- �û� I D
	@dwTargetUserID INT,						-- Ŀ���û�
	@lGuideScore BIGINT							-- ָ������
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	
	DECLARE @SourceScore BIGINT
	DECLARE @SourceInsure BIGINT
	DECLARE @TargetScore BIGINT
	DECLARE @TargetInsure BIGINT

	-- ��Ҳ�ѯ
	SELECT @SourceScore=Score, @SourceInsure=InsureScore FROM GameScoreInfo(NOLOCK) WHERE UserID=@dwUserID

	-- ��Ҳ�ѯ
	SELECT @TargetScore=Score, @TargetInsure=InsureScore FROM GameScoreInfo(NOLOCK) WHERE UserID=@dwTargetUserID

	IF @SourceScore=NULL SET @SourceScore=0
	IF @SourceInsure=NULL SET @SourceInsure=0
	IF @TargetScore=NULL SET @TargetScore=0
	IF @TargetInsure=NULL SET @TargetInsure=0

	-- ��¼��־
	INSERT INTO RecordPayGuide(SourceUserID, SourceScore, SourceInsure, TargetUserID, TargetScore, TargetInsure, GuideScore)
	VALUES (@dwUserID, @SourceScore, @SourceInsure, @dwTargetUserID, @TargetScore, @TargetInsure, @lGuideScore)

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------