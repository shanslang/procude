
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_ChannelQuery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_ChannelQuery]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_ChannelBinding]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_ChannelBinding]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- ������ѯ
CREATE PROC GSP_MB_ChannelQuery
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @BindingStatus AS TINYINT
	DECLARE @ChannelReward AS INT
	DECLARE @PlatformID AS INT

	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

	-- �˻��ж�
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'�����˻���Ϣ�������֤���ٴγ��ԣ�'
		RETURN 1
	END

	-- �����ж�
--	IF @LogonPass<>@strPassword
--	BEGIN
--		SET @strErrorDescribe=N'�������������������֤���ٴγ���111��'+@LogonPass+'___'+@strPassword
--		RETURN 2
--	END

	-- ��ѯ״̬
	SELECT @BindingStatus=BindingStatus FROM AccountsChannel WHERE UserID=@dwUserID

	-- ��ѯ����
	SELECT @ChannelReward=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'ChannelReward'

	-- ���ݵ���
	IF @BindingStatus IS NULL SET @BindingStatus=0
	IF @ChannelReward IS NULL SET @ChannelReward=0

	-- ��ѯƽ̨
	SELECT @PlatformID=PlatformID FROM AccountsInfo WHERE UserID=@dwUserID
	IF @PlatformID<>1002 AND @PlatformID<>2001
	BEGIN
		SET @BindingStatus=2
	END

	-- �������
	SELECT @BindingStatus AS BindingStatus, @ChannelReward AS ChannelReward
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- ������
CREATE PROC GSP_MB_ChannelBinding
	@dwUserID INT,								-- �û� I D
	@dwChannelID INT,							-- ������ʶ
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
	DECLARE @BindingStatus AS TINYINT
	DECLARE @ChannelReward AS INT
	DECLARE @PlatformID AS INT
	DECLARE @UserScore AS BIGINT
	DECLARE @SetBindingStatus AS TINYINT

	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

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

	declare @chid int
	SELECT TOP 1 @chid=ChannelID from [THRecordDB].[dbo].[RecordMachineCountInfo](nolock) WHERE [RegisterMachine]=@strMachineID and ChannelID <>0  and (ChannelID < 1000 or  ChannelID > 4000) ORDER BY ID DESC
	if @chid is not null 
	begin 
		SET @strErrorDescribe=N'���豸�Ѱ󶨹�������'
		RETURN 3
	end

	-- ��ѯƽ̨
	SELECT @PlatformID=PlatformID FROM AccountsInfo WHERE UserID=@dwUserID
	--IF @PlatformID<>1002 AND @PlatformID<>2001
	--BEGIN
	--	SET @strErrorDescribe=N'�Բ���������Ϸ�˺�Ϊ��������Ȩ�˺ţ��ǹٷ��˺��޷���ȡ������'
	--	RETURN 3
	--END

	-- ����״̬
	SET @SetBindingStatus=2

	-- ��ѯ״̬
	SELECT @BindingStatus=BindingStatus FROM AccountsChannel WHERE UserID=@dwUserID

	-- ���ݵ���
	IF @BindingStatus IS NULL SET @BindingStatus=0

	-- ״̬�ж�
	IF @BindingStatus=0
	BEGIN
		-- �����ж�
		IF NOT EXISTS (SELECT * FROM ChannelConfig WHERE ChannelID=@dwChannelID AND Nullity=0)
		BEGIN
			SET @strErrorDescribe=N'�Բ����������������ʶ��δ���ã����֤���ٴγ��ԣ�'
			RETURN 4
		END

		-- ������
		-- UPDATE AccountsInfo SET SpreaderID=@dwChannelID WHERE UserID=@dwUserID AND SpreaderID=@dwChannelID
		UPDATE AccountsInfo SET SpreaderID=@dwChannelID WHERE UserID=@dwUserID 
		EXEC THRecordDB.dbo.GSP_GR_DJ_Reg @dwChannelID,@PlatformID,@strClientIP,@strMachineID
		UPDATE AccountsChannel SET ChannelID=@dwChannelID,BindingStatus=@SetBindingStatus WHERE UserID=@dwUserID
		IF @@ROWCOUNT=0
		BEGIN
			INSERT AccountsChannel (UserID,ChannelID,BindingStatus) VALUES (@dwUserID,@dwChannelID,@SetBindingStatus)
		END
	END
	ELSE IF @BindingStatus=1
	BEGIN
		-- ����״̬
		UPDATE AccountsChannel SET BindingStatus=@SetBindingStatus WHERE UserID=@dwUserID
	END
	ELSE IF @BindingStatus=2
	BEGIN
		SET @strErrorDescribe=N'���Ѿ��󶨹��������޷��ٴΰ󶨣�'
		RETURN 5
	END
	ELSE
	BEGIN
		SET @strErrorDescribe=N'���İ�״̬�쳣������ϵ�ͷ������'
		RETURN 6
	END

	-- ��ѯ����
	SELECT @ChannelReward=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'ChannelReward'

	-- ���ݵ���
	IF @ChannelReward IS NULL SET @ChannelReward=0

	-- ���ͽ��
	UPDATE THTreasureDB.dbo.GameScoreInfo SET Score=Score+@ChannelReward WHERE UserID=@dwUserID
	IF @@ROWCOUNT=0
	BEGIN
		INSERT THTreasureDB.dbo.GameScoreInfo(UserID,Score,RegisterIP,LastLogonIP) VALUES (@dwUserID,@ChannelReward,@strClientIP,@strClientIP)
	END
	--  ���ͽ�Ҽ�¼
	insert into [THRecordDB].[dbo].[RecordGrantGameScore]([MasterID],[ClientIP],[CollectDate],[UserID],[KindID],[CurScore],[AddScore],[Reason]) values(0,'',getdate(),@dwUserID,6,0,@ChannelReward,'������')

	-- ��ѯ����
	SELECT @UserScore=Score FROM THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID

	-- ���ݵ���
	IF @UserScore IS NULL SET @UserScore=0

	-- �����Ϣ
	SELECT @SetBindingStatus AS BindingStatus, @UserScore AS UserScore
	SET @strErrorDescribe=N'��ϲ����������ȡ�ɹ���'
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------