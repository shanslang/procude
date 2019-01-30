USE [THAccountsDB]
GO

/****** Object:  StoredProcedure [dbo].[NET_PW_RegisterAccounts1]    Script Date: 2018/10/11 10:23:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











----------------------------------------------------------------------------------------------------

-- �ʺ�ע��
ALTER PROCEDURE [dbo].[NET_PW_RegisterAccounts1]
	@strAccounts NVARCHAR(31),					-- �û��ʺ�
	@strNickname NVARCHAR(31),					-- �û��ǳ�
	@strLogonPass NCHAR(32),					-- �û�����
	@strInsurePass NCHAR(32),					-- �û�����
	@dwFaceID INT,								-- ͷ���ʶ
	@dwGender TINYINT,							-- �û��Ա�
	@strSpreader NVARCHAR(31),					-- �ƹ�Ա��
	@strCompellation NVARCHAR(16),				-- ��ʵ����
	@strPassPortID NVARCHAR(18),				-- ���֤��
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strAdID INT,								-- �ƹ���ԴID
	@strPCEggsPCID	INT,						-- PC����PCID
	@strPCEggsADID	NVARCHAR(255),				-- PC����ADID
	@RegDeviceType int,						-- �°��豸ID��0��PC��16����׿��32��IOS)
	@RegKindID int,							    -- ��ϷID 378 - Ѫ��  6 - Ӯ����  27  -ţţ
	@Regmark int,								--1���ֻ�һ��ע�ᣬ0������ע��
	@externalMsg Nvarchar(50)='',					--��չ�ֶ�
	@RealName nvarchar(10)='',					--��ʵ����
	@IdentityCard nvarchar(18)='',				--���֤��
	@WeiXinName   nvarchar(31)=N'',				--΢���ǳ�
	@RegisterMachine nvarchar(32)=N'',
	@strErrorDescribe	NVARCHAR(127) OUTPUT	-- �����Ϣ
 AS

-- ��������
SET NOCOUNT ON

-- ������Ϣ
DECLARE @UserID INT
DECLARE @FaceID INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @Nickname NVARCHAR(31) 
DECLARE @UnderWrite NVARCHAR(63)

-- ��չ��Ϣ
DECLARE @GameID INT
DECLARE @SpreaderID INT
DECLARE @Gender TINYINT
DECLARE @Experience INT
DECLARE @Loveliness INT
DECLARE @MemberOrder INT
DECLARE @MemberOverDate DATETIME
DECLARE @CustomFaceVer TINYINT
DECLARE @Compellation NVARCHAR(16)
DECLARE @PassPortID NVARCHAR(18)
DECLARE @OpType int
SET @Loveliness = 0 -- ����ֵĬ��ֵ

-- ��������
DECLARE @EnjoinLogon AS INT
DECLARE @EnjoinRegister AS INT

-- ִ���߼�
BEGIN
	IF @strNickname='AppServicesRegister'
	BEGIN
		SET @UserID=0
		SET @GameID=0
		SELECT @UserID=UserID,@GameID=GameID
		FROM AccountsInfo(NOLOCK) WHERE Nickname='AppServicesRegister'
		--����һ��ע��
		IF(@UserID>0)
		BEGIN
			UPDATE AccountsInfo
			SET Nickname='���1123'+ CONVERT(VARCHAR(30),@UserID)
			WHERE UserID=@UserID
			SET @UserID=0
			SET @GameID=0
		END
	--set @Nickname='���581'+cast((select max(userid) FROM AccountsInfo(NOLOCK)) as nvarchar)
	--set @strAccounts='yjzc2016'+cast((select max(userid) FROM AccountsInfo(NOLOCK)) as nvarchar)
	declare @maxuserid nvarchar(10)
	set @maxuserid=cast((select max(userid)+1 FROM AccountsInfo(NOLOCK)) as nvarchar)
	set @Nickname='���'+@maxuserid
	set @strAccounts='dwj'+@maxuserid
	set @strInsurePass=''
	END
	else
	   BEGIN
		 set @strInsurePass=@strLogonPass
		 set @Nickname=@strNickname
	   END

	-- У���˺�6-12λ��ĸ�����ֵ����
	-- declare @sz_zh int
	-- declare @zm_zh int
	-- declare @len_zh int
	-- select  @sz_zh = PATINDEX('%[A-Za-z]%', @strAccounts)
	-- select  @zm_zh = PATINDEX('%[0-9]%', @strAccounts)
	-- select  @len_zh = len(@strAccounts)
	-- if @sz_zh < 1 or @zm_zh < 1 or @len_zh > 12 or @len_zh < 6
	-- begin
		-- SET @strErrorDescribe=N'�˺ű�����6-12λ��ĸ�����ֵ���ϣ�'
		-- RETURN 1
	-- end

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

	-- Ч������
	IF EXISTS (SELECT [String] FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strAccounts)>0 AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL))
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��֪ͨ��������������ʺ������������ַ�����������ʺ������ٴ������ʺţ�'
		RETURN 1
	END

	-- Ч���ǳ�
	IF EXISTS (SELECT [String] FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strNickname)>0 AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL))
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��֪ͨ��������������ǳƺ��������ַ�����������ǳƺ��ٴ������ʺţ�'
		RETURN 1
	END
	
	-- Ч���ַ
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��֪ͨ����ϵͳ��ֹ�������ڵ� IP ��ַ��ע�Ṧ�ܣ�����ϵ�ͻ����������˽���ϸ�����'
		RETURN 2
	END
	-- Ч�����
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@RegisterMachine AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��֪ͨ����ϵͳ��ֹ�����Ļ�����ע�Ṧ�ܣ�����ϵ�ͻ����������˽���ϸ�����'
		RETURN 6
	END

	-- ����������,һ��������ֻ��ע��3��   -- 8.31�������ʱע�͵�
	--IF 2< (select count([RegisterMachine]) FROM [THAccountsDB].[dbo].[AccountsInfo](nolock) where [RegisterMachine] = @RegisterMachine)
	--BEGIN
		--SET @strErrorDescribe=N'��Ǹ��֪ͨ����ͬһ������ֻ��ע��3���ţ�'
		--RETURN 3
	--END

	-- ��ѯ�û�
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts)
	BEGIN
		SET @strErrorDescribe=N'���ʺ����ѱ�ע�ᣬ�뻻��һ�ʺ����ֳ����ٴ�ע�ᣡ'
		RETURN 3
	END

	IF @Nickname<>'AppServicesRegister' AND EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE NickName=@Nickname)
	BEGIN
		SET @strErrorDescribe=N'���ʺ��������ǳ��ѱ�ע�ᣬ�뻻��һ�ʺų����ٴ�ע�ᣡ'
		RETURN 3
	END

	 --ÿ��IP���ע������
	IF 100<(SELECT COUNT(*) FROM AccountsInfo WHERE CONVERT(NVARCHAR(30),registerdate,23) = CONVERT(NVARCHAR(30),getdate(),23) AND registerip=@strClientIP)
	BEGIN
		SET @strErrorDescribe=N'�����ڵ� IP ��ַ��ע���������࣡'
		RETURN 3
	END

	-- ���ƹ�Ա
	IF @strSpreader<>''
	BEGIN
		-- ���ƹ�Ա
		SELECT @SpreaderID=UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strSpreader

		-- �������
		IF @SpreaderID IS NULL
		BEGIN
			SET @strErrorDescribe=N'������д���Ƽ��˲����ڻ�����д����������ٴ�ע�ᣡ'
			RETURN 4
		END
	END
	ELSE SET @SpreaderID=0

	 declare @NoviceAward int 
	 set @NoviceAward=0
	 if @RegKindID not in(378,200)
	  set @NoviceAward=1
	set @dwFaceID=1
	declare @i int
	set @i=0
	retry:
	-- ע���û�
	INSERT AccountsInfo (Accounts,Nickname,RegAccounts,LogonPass,InsurePass,SpreaderID,Gender,FaceID,WebLogonTimes,RegisterIP,LastLogonIP,Compellation,PassPortID,RegisterMachine)
	VALUES (@strAccounts,@Nickname,@strAccounts,@strLogonPass,@strInsurePass,@SpreaderID,@dwGender,@dwFaceID,1,@strClientIP,@strClientIP,@strCompellation,@strPassPortID,@RegisterMachine)
	-- ��ȡ�Զ�����UserID
	DECLARE @NewUserID INT
	SET @NewUserID = @@IDENTITY

	--  ע��ɹ��Ͳ������ݵ�[RecordUserCountInfo]
	insert into [THRecordDB].[dbo].[RecordUserCountInfo]([UserID],[RechargeSum],[RechargeCount],[GameSum],[GameSumDay],[ZzSum],[ZzCount],[ZcPtSum],[ZcPtCount],[ZcVipSum],
  [ZcVipCount],[ZrPtSum],[ZrPtCount],[ZrVipSum],[ZrVipCount],[InsertDate],[DezSum],[Status]) 
  values(@NewUserID,0,0,0,0,0,0,0,0,0,0,0,0,0,0,getdate(),0,0)

	-- �����ж�
	IF @@ERROR<>0
	BEGIN
		SET @strErrorDescribe=N'�ʺ��Ѵ��ڣ��뻻��һ�ʺ����ֳ����ٴ�ע�ᣡ'
		RETURN 5
	END
	set @i=@i+1
	SELECT @GameID=GameID FROM GameIdentifier(NOLOCK) WHERE UserID=@NewUserID
		IF @GameID IS NULL or @GameID=0
		BEGIN
			SET @GameID=0
			SET @strErrorDescribe=N'ע��ʧ�ܣ�������ע�ᣡ'
			UPDATE AccountsInfo SET RegisterMachine='',Accounts=substring(replace(newid(), '-', ''),1,31),Nullity=1 WHERE UserID=@NewUserID
			if @i>1 
			begin
				return 1
			end
		    goto retry
		END
		ELSE UPDATE AccountsInfo SET GameID=@GameID WHERE UserID=@NewUserID


	-- ��ѯ�û�
	SELECT @UserID=UserID, @Accounts=Accounts, @Nickname=Nickname,@UnderWrite=UnderWrite, @Gender=Gender, @FaceID=FaceID, @Experience=Experience,
		@MemberOrder=MemberOrder, @MemberOverDate=MemberOverDate, /*@Loveliness=Loveliness,*/@CustomFaceVer=CustomFaceVer,
		@Compellation=Compellation,@PassPortID=PassPortID
	FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts


	 
	--����һ��ע��
	IF(@strNickname='AppServicesRegister')
	BEGIN
		UPDATE AccountsInfo
		SET Nickname='���'+ CONVERT(VARCHAR(30),@NewUserID)
		WHERE UserID=@UserID
	END
	
	-- ��¼��־
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE SystemStreamInfo SET WebRegisterSuccess=WebRegisterSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT SystemStreamInfo (DateID, WebRegisterSuccess) VALUES (@DateID, 1)

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	-- ע������

	-- ��ȡ����
	DECLARE @GrantScoreCount AS BIGINT
	DECLARE @GrantIPCount AS BIGINT
	SELECT @GrantScoreCount=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'GrantScoreCount'
	SELECT @GrantIPCount=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'GrantIPCount'

	-- �������
	SELECT @UserID AS UserID,@strAccounts as strAccounts
	set @strErrorDescribe='ע��ɹ�'
End 

RETURN 0

GO


