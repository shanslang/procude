
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

-- ��Ϸд��
CREATE PROC GSP_GR_WriteGameScore

	-- �û���Ϣ
	@dwUserID INT,								-- �û� I D
	@dwDBQuestID INT,							-- �����ʶ
	@dwInoutIndex INT,							-- ��������

	-- ����ɼ�
	@lVariationScore BIGINT,					-- �û�����
	@lVariationGrade BIGINT,					-- �û��ɼ�
	@lVariationInsure BIGINT,					-- �û�����
	@lVariationRevenue BIGINT,					-- ��Ϸ˰��
	@lVariationWinCount INT,					-- ʤ������
	@lVariationLostCount INT,					-- ʧ������
	@lVariationDrawCount INT,					-- �;�����
	@lVariationFleeCount INT,					-- ������Ŀ
	@lVariationUserMedal BIGINT,				-- �û�����
	@lVariationExperience INT,					-- �û�����
	@lVariationLoveLiness INT,					-- �û�����
	@dwVariationPlayTimeCount INT,				-- ��Ϸʱ��

	-- ������Ϣ
	@cbTaskForward TINYINT,						-- �������

	-- ������Ϣ	
	@wKindID INT,								-- ��Ϸ I D
	@wServerID INT,								-- ���� I D
	@strClientIP NVARCHAR(15)					-- ���ӵ�ַ

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	--begin try
		--exec THRecordDB.dbo.GSP_GR_DJ_Win @dwUserID,@lVariationScore
	--end try
	--begin catch
	--end catch
	
--	UPDATE GameScoreInfo SET Score=0 WHERE UserID=@dwUserID AND Score<0
--	UPDATE GameScoreInfo SET InsureScore=0 WHERE UserID=@dwUserID AND InsureScore<0

	-- ȫ����Ϣ
	--IF @lVariationExperience>0 OR @lVariationLoveLiness<>0 OR @lVariationUserMedal>0
	--BEGIN
		--UPDATE THAccountsDB.dbo.AccountsInfo SET Experience=Experience+@lVariationExperience, LoveLiness=LoveLiness+@lVariationLoveLiness,
			--UserMedal=UserMedal+@lVariationUserMedal
		--WHERE UserID=@dwUserID
	--END

	-- �����¼
	DECLARE @DateID INT
    SELECT @DateID=CAST(CAST(GetDate() AS FLOAT) AS INT) 

	DECLARE @ReWinCount INT
	
	-- �����ж�
	--IF NOT EXISTS(SELECT * FROM StreamScoreInfo(NOLOCK) WHERE DateID=@DateID AND UserID=@dwUserID) 
	--BEGIN
		-- �����¼
		--INSERT INTO StreamScoreInfo(DateID, UserID, WinCount, LostCount, ReWinCount, Revenue, PlayTimeCount, OnlineTimeCount, FirstCollectDate, LastCollectDate)
		--VALUES(@DateID, @dwUserID, @lVariationWinCount, @lVariationLostCount, 0, @lVariationRevenue, @dwVariationPlayTimeCount, 0, GetDate(), GetDate())		
	--END ELSE
	--BEGIN
		-- ��ѯ��ʤ
		--SELECT @ReWinCount=ISNULL(ReWinCount,0) FROM StreamScoreInfo(NOLOCK) WHERE DateID=@DateID AND UserID=@dwUserID
		--IF @lVariationLostCount+@lVariationDrawCount>0
		--BEGIN
			--SET @ReWinCount=0
		--END
		--ELSE
		--BEGIN
			--SET @ReWinCount=@ReWinCount+1
		--END

		-- ���¼�¼
		--UPDATE StreamScoreInfo SET WinCount=WinCount+@lVariationWinCount, LostCount=LostCount+@lVariationLostCount, ReWinCount=@ReWinCount, Revenue=Revenue+@lVariationRevenue,
			--   PlayTimeCount=PlayTimeCount+@dwVariationPlayTimeCount, LastCollectDate=GetDate()
		--WHERE DateID=@DateID AND UserID=@dwUserID		
	--END
	
	if @wKindID = 7
	begin
		--����ר�ż�¼
		update [THRecordDB].[dbo].[RecordUserCountInfo] set [DezSum]=[DezSum]+@lVariationScore where [UserID]=@dwUserID
		update [THRecordDB].[dbo].[RecordUserDayCount] set [DezSum]=[DezSum]+@lVariationScore where [UserID]=@dwUserID and [InsertDate] = convert(nvarchar(22),getdate(),110)
		if @@rowcount = 0
		begin
			INSERT INTO [THRecordDB].[dbo].[RecordUserDayCount] ([UserID],[InsertDate],[DezSum]) VALUES (@dwUserID,getdate(),@lVariationScore)
		end
	end
		
	-- �������
	IF @cbTaskForward=1
	BEGIN
		begin try
			exec THPlatformDB.dbo.GSP_GR_TaskForward @dwUserID,@wKindID,0,@lVariationWinCount,@lVariationLostCount,@lVariationDrawCount	
		end try
		begin catch
		end catch
	END
	
	-- �û�����
	UPDATE GameScoreInfo SET Score=Score+@lVariationScore, Revenue=Revenue+@lVariationRevenue, InsureScore=InsureScore+@lVariationInsure
		--WinCount=WinCount+@lVariationWinCount, LostCount=LostCount+@lVariationLostCount, DrawCount=DrawCount+@lVariationDrawCount,
		--FleeCount=FleeCount+@lVariationFleeCount, PlayTimeCount=PlayTimeCount+@dwVariationPlayTimeCount
	WHERE UserID=@dwUserID
	
	-- ����RecordVipzcPt�����
	if @@ROWCOUNT > 0
	begin
		exec [THRecordDB].[dbo].[PHP_Record_RecordVipzcPt] @dwUserID,0
	end
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------