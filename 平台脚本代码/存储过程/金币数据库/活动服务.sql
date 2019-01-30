
----------------------------------------------------------------------------------------------------

USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_ActivityQuery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_ActivityQuery]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_ActivityTakeReward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_ActivityTakeReward]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- ���ѯ
CREATE PROC GSP_GP_ActivityQuery
	@wActivityID INT,							-- ���ʶ
	@dwUserID INT,								-- �û� I D
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @TakeStatus TINYINT

	-- �û��ж�
	IF NOT EXISTS (SELECT UserID FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID)
	BEGIN
		SET @strErrorDescribe=N'�����˻���Ϣ�������֤���ٴγ��ԣ�'
		RETURN 1
	END

	-- ��ж�
	IF @wActivityID=1
	BEGIN
		-- ͳ�ƴ���
		DECLARE @ActivityRewardCount AS INT
		SELECT @ActivityRewardCount=COUNT(RecordID) FROM RecordActivityReward WHERE UserID=@dwUserID AND ActivityID=@wActivityID

		-- �����ж�
		IF @ActivityRewardCount<>0
		BEGIN
			SET @TakeStatus=1
		END
		ELSE
		BEGIN
			SET @TakeStatus=0
		END
	END
	ELSE
	BEGIN
		SET @strErrorDescribe=N'���Ļ��ʶ�������֤���ٴγ��ԣ�'
		RETURN 2
	END

	-- ���У��
	IF @wActivityID IS NULL SET @wActivityID=0
	IF @TakeStatus IS NULL SET @TakeStatus=0

	-- �������
	SELECT @wActivityID AS ActivityID, @TakeStatus AS TakeStatus
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- ��ȡ����
CREATE PROC GSP_GP_ActivityTakeReward
	@wActivityID INT,							-- ���ʶ
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strMachineID NVARCHAR(32),					-- ������ʶ
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	
	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	
	-- �˻��ж�
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'�����˻���Ϣ�������֤���ٴγ��ԣ�'
		RETURN 1
	END

	-- �����ж�
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'�������������������֤���ٴγ��ԣ�'
		RETURN 2
	END

	-- ��ж�
	IF @wActivityID=1
	BEGIN
		-- �����
		SET @strErrorDescribe=N'��Ǹ���û�ѹ��ڣ����������»��Ϣ��'
		RETURN 3
		
		-- ͳ�ƴ���
		DECLARE @ActivityRewardCount AS INT
		SELECT @ActivityRewardCount=COUNT(RecordID) FROM RecordActivityReward WHERE UserID=@dwUserID AND ActivityID=@wActivityID

		-- �����ж�
		IF @ActivityRewardCount<>0
		BEGIN
			SET @strErrorDescribe=N'��Ǹ�����Ѿ���ȡ���û�����������ٴ���ȡ��'
			RETURN 3
		END

		-- ���ý���
		DECLARE @RewardGoodsID INT
		DECLARE @RewardGoodsCount INT
		SET @RewardGoodsID=50
		SET @RewardGoodsCount=5

		-- ������Ʒ
		UPDATE PackageInfo SET GoodsCount=GoodsCount+@RewardGoodsCount WHERE UserID=@dwUserID AND GoodsID=@RewardGoodsID

		-- ������Ʒ
		IF @@ROWCOUNT=0
		BEGIN
			INSERT PackageInfo(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@RewardGoodsID,@RewardGoodsCount)
		END

		-- д���¼
		INSERT RecordActivityReward (ActivityID,UserID,GoodsID,GoodsCount,OperateMachine) VALUES (1,@dwUserID,@RewardGoodsID,@RewardGoodsCount,@strMachineID)

		-- �������
		SET @strErrorDescribe=N'��ϲ�����������ȡ�ɹ���'
	END
	ELSE
	BEGIN
		SET @strErrorDescribe=N'���Ļ��ʶ�������֤���ٴγ��ԣ�'
		RETURN 4
	END
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------