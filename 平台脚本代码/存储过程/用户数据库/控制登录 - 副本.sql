
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_KZ_EfficacyAccounts]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_KZ_EfficacyAccounts]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- �ʺŵ�¼
CREATE PROC GSP_KZ_EfficacyAccounts
	@strAccounts NVARCHAR(31),					-- �û��ʺ�
	@strPassword NCHAR(32),						-- �û�����
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strMachineID NVARCHAR(32),					-- ������ʶ
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
AS

-- ��������
SET NOCOUNT ON

-- ������Ϣ
DECLARE @UserID INT
DECLARE @Accounts NVARCHAR(31)

-- ��������
DECLARE @EnjoinLogon AS INT

-- ִ���߼�
BEGIN
	-- ϵͳ��ͣ
	SELECT @EnjoinLogon=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinLogon'
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinLogon'
		RETURN 2
	END

	-- Ч���ַ
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��֪ͨ����ϵͳ��ֹ�������ڵ� IP ��ַ�ĵ�¼���ܣ�����ϵ�ͻ����������˽���ϸ�����'
		RETURN 4
	END
	
	-- Ч�����
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineID AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��֪ͨ����ϵͳ��ֹ�����Ļ����ĵ�¼���ܣ�����ϵ�ͻ����������˽���ϸ�����'
		RETURN 7
	END

	-- ��ѯ�û�
	DECLARE @Nullity TINYINT
	DECLARE @StunDown TINYINT
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @InsurePass AS NCHAR(32)
	DECLARE	@MachineSerial NCHAR(32)
	DECLARe @strLastLogonIP NCHAR(15)
	DECLARE @MoorMachine AS TINYINT
	SELECT @UserID=UserID, @Accounts=Accounts, @LogonPass=LogonPass,@InsurePass=InsurePass,
		@Nullity=Nullity, @StunDown=StunDown,
		@strLastLogonIP=LastLogonIP,
		@MoorMachine=MoorMachine, @MachineSerial=LastLogonMachine
	FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts

	-- �����ж�
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'�����ʺŲ����ڻ������������������֤���ٴγ��Ե�¼��'
		RETURN 3
	END

	-- �̶�����
	IF @MoorMachine=2
	BEGIN
		SET @MoorMachine=1
		SET @strErrorDescribe=N'�����ʺųɹ�ʹ���˹̶�������¼���ܣ�'
		UPDATE AccountsInfo SET MoorMachine=@MoorMachine, LastLogonMachine=@strMachineID WHERE UserID=@UserID
	END

	-- ������Ϣ
	UPDATE AccountsInfo SET GameLogonTimes=GameLogonTimes+1,LastLogonDate=GETDATE(), LastLogonIP=@strClientIP,DynamicPassTime=GETDATE(),
		DynamicPass=CONVERT(nvarchar(32),REPLACE(newid(),'-','')),LastLogonMachine=@strMachineID 
	WHERE UserID=@UserID

	-- ��̬����
	DECLARE @szDynamicPass  nchar(32)
	SELECT @szDynamicPass=DynamicPass FROM AccountsInfo WHERE UserID=@UserID

	-- ��¼��־
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE SystemStreamInfo SET GameLogonSuccess=GameLogonSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT SystemStreamInfo (DateID, GameLogonSuccess) VALUES (@DateID, 1)

	-- ���б�ʶ
	DECLARE @InsureEnabled TINYINT
	SET @InsureEnabled=0
	IF @InsurePass <> '' SET @InsureEnabled=1
	
	-- �������
	SELECT @UserID AS UserID, @Accounts AS Accounts, @MoorMachine AS MoorMachine, @InsureEnabled AS InsureEnabled
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
