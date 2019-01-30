----------------------------------------------------------------------------------------------------
-- ��Ȩ��2016
-- ʱ�䣺2016-12-20
-- ��;������ע��
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_MB_FastRegister') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_MB_FastRegister
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- ����ע��
CREATE PROCEDURE GSP_MB_FastRegister
	@dwPlatformID INT,							-- ƽ̨���
	@dwSpreaderID INT,							-- ������ʶ
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strMachineID NCHAR(32),					-- ������ʶ
	@strDeviceModel NVARCHAR(64),				-- �豸�ͺ�
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ������Ϣ
DECLARE @UserID INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @LogonPass NCHAR(32)

-- ������Ϣ
DECLARE @GameID INT

-- ��������
DECLARE @EnjoinLogon AS INT
DECLARE @EnjoinRegister AS INT

-- ������Ϣ
DECLARE @RewardGoodsID INT
DECLARE @RewardGoodsCount INT

-- ִ���߼�
BEGIN
	SET @UserID=0
	-- ��ѯ�û�
	SELECT TOP 1 @UserID=UserID, @GameID=GameID, @Accounts=Accounts, @LogonPass=LogonPass FROM AccountsInfo(NOLOCK) WHERE RegisterMachine=@strMachineID

	IF @UserID>0
	BEGIN
		-- �������
		SELECT TOP 1 @dwSpreaderID=ChannelID from THRecordDB.[dbo].[RecordChannelOpen] WHERE IP=@strClientIP ORDER BY RecordID DESC
		IF (SELECT COUNT(*) FROM AccountsInfo WHERE UserID=@UserID AND SpreaderID<>@dwSpreaderID)>0
		BEGIN
			UPDATE AccountsInfo SET SpreaderID=@dwSpreaderID WHERE UserID=@UserID AND SpreaderID<>@dwSpreaderID
			UPDATE AccountsChannel SET ChannelID=@dwSpreaderID WHERE UserID=@UserID AND ChannelID<>@dwSpreaderID
			IF (SELECT COUNT(*) FROM AccountsChannel WHERE UserID=@UserID AND ChannelID=@dwSpreaderID)=0 INSERT AccountsChannel (UserID,ChannelID) VALUES (@UserID,@dwSpreaderID)
			EXEC THRecordDB.dbo.GSP_GR_DJ_Reg @dwSpreaderID,@dwPlatformID,@strClientIP,@strMachineID
		END
		SELECT @UserID AS UserID, @Accounts AS Accounts, @LogonPass AS LogonPass
		RETURN 0
	END

	-- ע����ͣ
	SELECT @EnjoinRegister=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinRegister'
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinRegister'
		RETURN 1
	END

	-- ��¼��ͣ
	SELECT @EnjoinLogon=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinLogon'
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinLogon'
		RETURN 2
	END

	-- Ч���ַ
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��֪ͨ����ϵͳ��ֹ�������ڵ� IP ��ַ��ע�Ṧ�ܣ�����ϵ�ͻ����������˽���ϸ�����'
		RETURN 5
	END
	
	-- Ч�����
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineID AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��֪ͨ����ϵͳ��ֹ�����Ļ�����ע�Ṧ�ܣ�����ϵ�ͻ����������˽���ϸ�����'
		RETURN 6
	END

	-- �����ǳ�
	DECLARE	@strAccounts NVARCHAR(31)
	DECLARE	@strNickname NVARCHAR(31)
	DECLARE	@strLogonPass NCHAR(32)
	DECLARE @strRand NVARCHAR(6)
	
	-- ��������
--	SELECT @strLogonPass = CONVERT(NVARCHAR(32),REPLACE(newid(),'-',''))
	SELECT @strLogonPass = 'E10ADC3949BA59ABBE56E057F20F883E'


	DECLARE @R1 INT
	DECLARE @R2 INT
	SET @R1=FLOOR(RAND()*4)
	SET @R2=FLOOR(RAND()*4)
	SET @strNickname=NULL
	SET @strAccounts=NULL
	WHILE @strNickname IS NULL OR (SELECT COUNT(*) FROM THAccountsDB.dbo.AccountsInfo WHERE NickName=@strNickname)>0
	BEGIN
		SELECT @strNickname=NickName FROM THAccountsDB.dbo.Accounts_Nickname0 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname0 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname0)) AND @R1=0
		SELECT @strNickname=NickName FROM THAccountsDB.dbo.Accounts_Nickname1 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname1 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname1)) AND @R1=1
		SELECT @strNickname=NickName FROM THAccountsDB.dbo.Accounts_Nickname2 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname2 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname2)) AND @R1=2
		SELECT @strNickname=NickName FROM THAccountsDB.dbo.Accounts_Nickname3 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname3 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname3)) AND @R1=3
		SELECT @strNickname=NickName+@strNickname FROM THAccountsDB.dbo.Accounts_Nickname0 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname0 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname0)) AND @R2=0
		SELECT @strNickname=NickName+@strNickname FROM THAccountsDB.dbo.Accounts_Nickname1 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname1 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname1)) AND @R2=1
		SELECT @strNickname=NickName+@strNickname FROM THAccountsDB.dbo.Accounts_Nickname2 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname2 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname2)) AND @R2=2
		SELECT @strNickname=NickName+@strNickname FROM THAccountsDB.dbo.Accounts_Nickname3 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname3 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname3)) AND @R2=3
	END

	WHILE @strAccounts IS NULL OR (SELECT COUNT(*) FROM THAccountsDB.dbo.AccountsInfo WHERE Accounts=@strAccounts)>0
	BEGIN
		-- �����˺�
		SET @strAccounts = CONVERT(NVARCHAR(4),@dwPlatformID) + N'Fast' + CONVERT(NVARCHAR(6),REPLACE(newid(),'-',''))
	END

--	WHILE 1=1
--	BEGIN
--		-- �����ʶ
--		SELECT @strRand = CONVERT(NVARCHAR(6),REPLACE(newid(),'-',''))
--
--		-- �����˺�
--		SET @strAccounts = CONVERT(NVARCHAR(4),@dwPlatformID) + N'Fast' + @strRand
--		
--		-- �����ǳ�
--		SET @strNickname = CONVERT(NVARCHAR(4),@dwPlatformID) + N'Fast' + @strRand
--
--		-- ��ѯ�˺�
--		IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts)
--		BEGIN
--			CONTINUE
--		END
--		
--		-- ��ѯ�ǳ�
--		IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE NickName=@strNickName)
--		BEGIN
--			CONTINUE
--		END
--
--		BREAK
--	END

	SELECT TOP 1 @dwSpreaderID=ChannelID from THRecordDB.[dbo].[RecordChannelOpen] WHERE IP=@strClientIP ORDER BY RecordID DESC

	-- ע���û�
	INSERT AccountsInfo (Accounts,NickName,RegAccounts,LogonPass,DynamicPass,Gender,FaceID,GameLogonTimes,LastLogonIP,LastLogonMachine,LastLogonModel,RegisterIP,RegisterMachine,RegisterModel,PlatformID,SpreaderID)
	VALUES (@strAccounts,@strNickName,@strAccounts,@strLogonPass,CONVERT(nvarchar(32),REPLACE(newid(),'-','')),1,1,1,@strClientIP,@strMachineID,@strDeviceModel,@strClientIP,@strMachineID,@strDeviceModel,@dwPlatformID,@dwSpreaderID)

	EXEC THRecordDB.dbo.GSP_GR_DJ_Reg @dwSpreaderID,@dwPlatformID,@strClientIP,@strMachineID

	-- �����ж�
	IF @@ERROR<>0
	BEGIN
		SET @strErrorDescribe=N'���������ԭ���ʺ�ע��ʧ�ܣ��볢���ٴ�ע�ᣡ'
		RETURN 8
	END

	-- ��ѯ�û�
	SELECT @UserID=UserID, @GameID=GameID, @Accounts=Accounts, @LogonPass=LogonPass FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts

	-- �����ʶ
	SELECT @GameID=GameID FROM GameIdentifier(NOLOCK) WHERE UserID=@UserID
	IF @GameID IS NULL 
	BEGIN
		SET @GameID=0
		SET @strErrorDescribe=N'�û�ע��ɹ�����δ�ɹ���ȡ��Ϸ ID ���룬ϵͳ�Ժ󽫸������䣡'
	END
	ELSE UPDATE AccountsInfo SET GameID=@GameID WHERE UserID=@UserID

	-- ��¼��־
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE SystemStreamInfo SET GameRegisterSuccess=GameRegisterSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT SystemStreamInfo (DateID, GameRegisterSuccess) VALUES (@DateID, 1)

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	-- ע������

	-- ��ȡ����
	DECLARE @GrantIPCount AS BIGINT
	DECLARE @GrantScoreCount AS BIGINT
	SELECT @GrantIPCount=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'GrantIPCount'
	SELECT @GrantScoreCount=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'GrantScoreCount'

	-- ��������
	IF @GrantScoreCount IS NOT NULL AND @GrantScoreCount>0 AND @GrantIPCount IS NOT NULL AND @GrantIPCount>0
	BEGIN
		-- ���ʹ���
		DECLARE @GrantCount AS BIGINT
		DECLARE @GrantMachineCount AS BIGINT
		SELECT @GrantCount=GrantCount FROM SystemGrantCount(NOLOCK) WHERE DateID=@DateID AND RegisterIP=@strClientIP
		SELECT @GrantMachineCount=GrantCount FROM SystemMachineGrantCount(NOLOCK) WHERE DateID=@DateID AND RegisterMachine=@strMachineID
	
		-- �����ж�
		IF (@GrantCount IS NOT NULL AND @GrantCount>=@GrantIPCount) OR (@GrantMachineCount IS NOT NULL AND @GrantMachineCount>=@GrantIPCount)
		BEGIN
			SET @GrantScoreCount=0
		END
	END

	-- ���ͽ��
	IF @GrantScoreCount IS NOT NULL AND @GrantScoreCount>0
	BEGIN
		-- ���¼�¼
		UPDATE SystemGrantCount SET GrantScore=GrantScore+@GrantScoreCount, GrantCount=GrantCount+1 WHERE DateID=@DateID AND RegisterIP=@strClientIP

		-- �����¼
		IF @@ROWCOUNT=0
		BEGIN
			INSERT SystemGrantCount (DateID, RegisterIP, RegisterMachine, GrantScore, GrantCount) VALUES (@DateID, @strClientIP, @strMachineID, @GrantScoreCount, 1)
		END

		-- ���¼�¼
		UPDATE SystemMachineGrantCount SET GrantScore=GrantScore+@GrantScoreCount, GrantCount=GrantCount+1 WHERE DateID=@DateID AND RegisterMachine=@strMachineID

		-- �����¼
		IF @@ROWCOUNT=0
		BEGIN
			INSERT SystemMachineGrantCount (DateID, RegisterIP, RegisterMachine, GrantScore, GrantCount) VALUES (@DateID, @strClientIP, @strMachineID, @GrantScoreCount, 1)
		END

		-- ���ͽ��
		INSERT THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo (UserID, Score, RegisterIP, LastLogonIP) VALUES (@UserID, @GrantScoreCount, @strClientIP, @strClientIP) 
	END

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	-- ����ͳ��

	-- ���»���
	UPDATE RegisterMachineInfo SET RegisterCount=RegisterCount+1 WHERE RegisterMachine=@strMachineID

	-- �������
	IF @@ROWCOUNT=0
	BEGIN
		INSERT RegisterMachineInfo (RegisterMachine,RegisterCount) VALUES (@strMachineID,1)
	END

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	-- ��������
	
	-- ��ѯ����
	DECLARE @ChannelID AS INT
	SELECT @ChannelID=ChannelID FROM WebVisitInfo WHERE WebVisitIP=@strClientIP
	IF @ChannelID IS NOT NULL
	BEGIN
		-- �����ж�
		IF EXISTS (SELECT * FROM ChannelConfig WHERE ChannelID=@ChannelID AND Nullity=0)
		BEGIN
			INSERT AccountsChannel (UserID,ChannelID) VALUES (@UserID,@ChannelID)
		END
	END

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------

	-- �������
	SELECT @UserID AS UserID, @Accounts AS Accounts, @LogonPass AS LogonPass

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------