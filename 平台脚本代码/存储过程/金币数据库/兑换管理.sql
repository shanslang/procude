
----------------------------------------------------------------------------------------------------

USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_LoadMemberParameter]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_LoadMemberParameter]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_PurchaseMember]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_PurchaseMember]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_ExchangeScore]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_ExchangeScore]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_ConvertBeans]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_ConvertBeans]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- ���ػ�Ա
CREATE PROC GSP_GR_LoadMemberParameter	
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	-- ���ػ�Ա
	SELECT MemberName, MemberOrder, MemberPrice, PresentScore FROM MemberType(NOLOCK)

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- �����Ա
CREATE PROC GSP_GR_PurchaseMember

	-- �û���Ϣ
	@dwUserID INT,								-- �û���ʶ
	@cbMemberOrder INT,							-- ��Ա��ʶ
	@PurchaseTime INT,							-- ����ʱ��

	-- ϵͳ��Ϣ	
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strMachineID NVARCHAR(32),					-- ������ʶ
	@strNotifyContent NVARCHAR(127) OUTPUT		-- �����Ϣ

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN

	-- ��ѯ��Ա
	DECLARE @Nullity BIT
	DECLARE @CurrMemberOrder SMALLINT	
	SELECT @Nullity=Nullity, @CurrMemberOrder=MemberOrder FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- �û��ж�
	IF @CurrMemberOrder IS NULL
	BEGIN
		SET @strNotifyContent=N'�����ʺŲ����ڣ�����ϵ�ͻ����������˽���ϸ�����'
		RETURN 1
	END	

	-- �ʺŽ�ֹ
	IF @Nullity<>0
	BEGIN
		SET @strNotifyContent=N'�����ʺ���ʱ���ڶ���״̬������ϵ�ͻ����������˽���ϸ�����'
		RETURN 2
	END

	-- ��������	
	DECLARE @MemberName AS NVARCHAR(16)
	DECLARE @MemberPrice AS DECIMAL(18,2)
	DECLARE @PresentScore AS BIGINT
	DECLARE @MemberRight AS INT	

	-- ��ȡ��Ա
	SELECT @MemberName=MemberName,@MemberPrice=MemberPrice, @PresentScore=PresentScore,@MemberRight=UserRight	
	FROM MemberType(NOLOCK) WHERE MemberOrder=@cbMemberOrder	

	-- �����ж�
	IF @MemberName IS NULL
	BEGIN
		SET @strNotifyContent=N'��Ǹ��֪ͨ������������Ļ�Ա�����ڻ�������ά���У�����ϵ�ͻ����������˽���ϸ�����'
		RETURN 4
	END

	DECLARE @Currency DECIMAL(18,2)
	SELECT @Currency=Currency FROM UserCurrencyInfo(NOLOCK) WHERE UserID=@dwUserID
	IF @Currency IS NULL Set @Currency=0

	-- ���ü���
	DECLARE @ConsumeCurrency DECIMAL(18,2)
	SELECT @ConsumeCurrency=@MemberPrice*@PurchaseTime	

	-- ��ȡ��Ϸ��
	DECLARE @CurrencyOP DECIMAL(18,2)
	declare @Ret int
	set @CurrencyOP = -@ConsumeCurrency
	exec @Ret = proc_CurrencyOp @dwUserID,@CurrencyOP
	if @Ret <> 0
	BEGIN
		-- ������Ϣ
		SET @strNotifyContent=N'�����ϵ���Ϸ�����㣬���ֵ���ٴγ��ԣ�'
		RETURN 5
	END

	-- ��ȡ��Ϸ��
	DECLARE @Score BIGINT
	SELECT @Score=Score FROM GameScoreInfo(NOLOCK) WHERE UserID=@dwUserID
	-- ��������
	IF @Score IS NULL
		set @Score =0

	-- ���ͼ���
	DECLARE @TotalPreSentScore BIGINT
	SELECT @TotalPreSentScore=@PreSentScore*@PurchaseTime		

	-- �һ���־
	INSERT INTO RecordBuyMember(UserID,MemberOrder,MemberMonths,MemberPrice,Currency,PresentScore,BeforeCurrency,BeforeScore,ClinetIP,InputDate)
	VALUES(@dwUserID,@cbMemberOrder,@PurchaseTime,@MemberPrice,@ConsumeCurrency,@TotalPreSentScore,@Currency,@Score,@strClientIP,GETDATE())
	
	-- �仯��־
	INSERT INTO RecordCurrencyChange(UserID,ChangeCurrency,ChangeType,BeforeCurrency,AfterCurrency,ClinetIP,InputDate,Remark)
	VALUES(@dwUserID,@ConsumeCurrency,10,@Currency,@Currency-@ConsumeCurrency,@strClientIP,GETDATE(),'�һ���Ϸ��')	

	--exec proc_BankOp @dwUserID,@TotalPreSentScore
	update GameScoreInfo set score=score+@TotalPreSentScore where userid = @dwUserID
	
	-- ��Ա����
	DECLARE @MaxUserRight INT
	DECLARE @MemberValidMonth INT
	DECLARE @MaxMemberOrder TINYINT	 
	DECLARE @MemberOverDate DATETIME
	DECLARE @MemberSwitchDate DATETIME

	-- ��Ч����
	SELECT @MemberValidMonth= @PurchaseTime

	-- ɾ������
	DELETE FROM THAccountsDBLink.THAccountsDB.dbo.AccountsMember
	WHERE UserID=@dwUserID AND MemberOrder=@cbMemberOrder AND MemberOverDate<=GETDATE()

	-- ���»�Ա
	UPDATE THAccountsDBLink.THAccountsDB.dbo.AccountsMember SET MemberOverDate=DATEADD(mm,@MemberValidMonth, GETDATE())
	WHERE UserID=@dwUserID AND MemberOrder=@cbMemberOrder
	IF @@ROWCOUNT=0
	BEGIN
		INSERT THAccountsDBLink.THAccountsDB.dbo.AccountsMember(UserID,MemberOrder,UserRight,MemberOverDate)
		VALUES (@dwUserID,@cbMemberOrder,@MemberRight,DATEADD(mm,@MemberValidMonth, GETDATE()))
	END

	-- �󶨻�Ա,(��Ա�������л�ʱ��)
	SELECT @MaxMemberOrder=MAX(MemberOrder),@MemberOverDate=MAX(MemberOverDate),@MemberSwitchDate=MIN(MemberOverDate)
	FROM THAccountsDBLink.THAccountsDB.dbo.AccountsMember WHERE UserID=@dwUserID

	-- ��ԱȨ��
	SELECT @MaxUserRight=UserRight FROM THAccountsDBLink.THAccountsDB.dbo.AccountsMember
	WHERE UserID=@dwUserID AND MemberOrder=@MaxMemberOrder
	
	-- ���ӻ�Ա����Ϣ
	UPDATE THAccountsDBLink.THAccountsDB.dbo.AccountsInfo
	SET MemberOrder=@MaxMemberOrder,UserRight=@MaxUserRight,MemberOverDate=@MemberOverDate,MemberSwitchDate=@MemberSwitchDate
	WHERE UserID=@dwUserID

	-- ��Ա�ȼ�
	SELECT @CurrMemberOrder=MemberOrder FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- ��ѯ��Ϸ��
	DECLARE @CurrScore BIGINT
	SELECT @CurrScore=Score FROM GameScoreInfo WHERE UserID=@dwUserID	

	-- ��ѯ��Ϸ��
	DECLARE @CurrBeans DECIMAL(18,2)
	SELECT @CurrBeans=Currency FROM UserCurrencyInfo WHERE UserID=@dwUserID

	-- �ɹ���ʾ
	SET @strNotifyContent=N'��ϲ������Ա����ɹ���' 

	-- �����¼
	SELECT @CurrMemberOrder AS MemberOrder,@MaxUserRight AS UserRight,@CurrScore AS CurrScore,@CurrBeans AS CurrBeans

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- �һ���Ϸ��
CREATE PROC GSP_GR_ExchangeScore

	-- �û���Ϣ
	@dwUserID INT,								-- �û���ʶ
	@ExchangeIngot INT,							-- �һ�Ԫ��	

	-- ϵͳ��Ϣ	
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strMachineID NVARCHAR(32),					-- ������ʶ
	@strNotifyContent NVARCHAR(127) OUTPUT		-- �����Ϣ

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN

	-- ��ѯ��Ա
	DECLARE @Nullity BIT
	DECLARE @UserIngot INT	
	SELECT @Nullity=Nullity, @UserIngot=UserMedal FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- �û��ж�
	IF @UserIngot IS NULL
	BEGIN
		SET @strNotifyContent=N'�����ʺŲ����ڣ�����ϵ�ͻ����������˽���ϸ�����'
		RETURN 1
	END	

	-- �ʺŽ�ֹ
	IF @Nullity<>0
	BEGIN
		SET @strNotifyContent=N'�����ʺ���ʱ���ڶ���״̬������ϵ�ͻ����������˽���ϸ�����'
		RETURN 2
	END

	-- Ԫ���ж�
	IF @UserIngot < @ExchangeIngot
	BEGIN
		SET @strNotifyContent=N'����Ԫ�����㣬������öһ��������ԣ�'
		RETURN 3		
	END

	-- �һ�����
	DECLARE @ExchangeRate INT
	SELECT @ExchangeRate=StatusValue FROM THAccountsDBLink.THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'MedalExchangeRate'

	-- ϵͳ����
	IF @ExchangeRate IS NULL
	BEGIN
		SET @strNotifyContent=N'��Ǹ��Ԫ���һ�ʧ�ܣ�����ϵ�ͻ����������˽���ϸ�����'
		RETURN 4			
	END

	-- ������Ϸ��
	DECLARE @ExchangeScore BIGINT
	SET @ExchangeScore = @ExchangeRate*@ExchangeIngot

	-- ��ѯ����
	DECLARE @InsureScore BIGINT
	SELECT @InsureScore=InsureScore FROM GameScoreInfo WHERE UserID=@dwUserID

	-- ��������
	IF @InsureScore IS NULL
	BEGIN
		-- ���ñ���
		SET @InsureScore=0

		-- ��������
		INSERT INTO GameScoreInfo (UserID, LastLogonIP, LastLogonMachine, RegisterIP, RegisterMachine)
		VALUES (@dwUserID, @strClientIP, @strMachineID, @strClientIP, @strMachineID)		
	END	

	-- ��������
	UPDATE GameScoreInfo SET InsureScore=InsureScore+@ExchangeScore WHERE UserID=@dwUserID	
	
	-- ����Ԫ��
	SET @UserIngot=@UserIngot-@ExchangeIngot
	UPDATE THAccountsDBLink.THAccountsDB.dbo.AccountsInfo SET UserMedal=@UserIngot WHERE UserID=@dwUserID			

	-- ��ѯ��Ϸ��
	DECLARE @CurrScore BIGINT
	SELECT @CurrScore=Score FROM GameScoreInfo WHERE UserID=@dwUserID

	-- �����¼
	INSERT THRecordDBLink.THRecordDB.dbo.RecordConvertUserMedal (UserID, CurInsureScore, CurUserMedal, ConvertUserMedal, ConvertRate, IsGamePlaza, ClientIP, CollectDate)
	VALUES(@dwUserID, @InsureScore, @UserIngot, @ExchangeIngot, @ExchangeRate, 0, @strClientIP, GetDate())

	-- �ɹ���ʾ
	SET @strNotifyContent=N'��ϲ������Ϸ�Ҷһ��ɹ���'

	-- �����¼
	SELECT @UserIngot AS CurrIngot,@CurrScore AS CurrScore

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- ��Ϸ���һ�
CREATE PROCEDURE GSP_GR_ConvertBeans
	@dwUserID			INT,					-- �û� I D
	@strPassword		NCHAR(32),				-- �û�����
	@dBeans				DECIMAL(18,2),			-- �һ�����
	@strClientIP		VARCHAR(15),			-- �һ���ַ
	@strMachineID		NVARCHAR(32),			-- ������ʶ
	@strNotifyContent	NVARCHAR(127) OUTPUT	-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �û���Ϣ
DECLARE @UserID INT
DECLARE @LogonPass NCHAR(32)
DECLARE @Nullity BIT
DECLARE @StunDown BIT
DECLARE @CurrentBeans DECIMAL(18,2)

-- �����Ϣ
DECLARE @InsureScore BIGINT

-- �һ����
DECLARE @ConvertGold BIGINT

-- �һ�����
DECLARE @ConvertRate INT

-- ִ���߼�
BEGIN
	-- ��ѯ�û�
	SELECT @UserID=UserID, @LogonPass=LogonPass, @Nullity=Nullity, @StunDown=StunDown
	FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- ��ѯ�û�
	IF @UserID IS NULL
	BEGIN
		SET @strNotifyContent=N'�����ʺŲ����ڻ������������������֤���ٴγ��Ե�¼��'
		RETURN 1
	END
	
	-- �ʺŽ�ֹ
	IF @Nullity<>0
	BEGIN
		SET @strNotifyContent=N'�����ʺ���ʱ���ڶ���״̬������ϵ�ͻ����������˽���ϸ�����'
		RETURN 2
	END

	-- �ʺŹر�
	IF @StunDown<>0
	BEGIN
		SET @strNotifyContent=N'�����ʺ�ʹ���˰�ȫ�رչ��ܣ��������¿�ͨ����ܼ���ʹ�ã�'
		RETURN 3
	END

	-- �����ж�
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strNotifyContent=N'�������������������֤���ٴγ��ԣ�'
		RETURN 4
	END

	-- ��ѯ��Ϸ��
	SELECT @CurrentBeans=Currency FROM UserCurrencyInfo WHERE UserID=@dwUserID
	IF @CurrentBeans IS NULL
	BEGIN
		SET @CurrentBeans=0
	END

	-- �����ж�
	IF @dBeans > @CurrentBeans or @CurrentBeans=0
	BEGIN
		SET @strNotifyContent=N'��Ǹ�����ı�ʯ���㣬�޷��һ���'
		RETURN 5
	END
	
	-- ��ѯ����
	SELECT @InsureScore=InsureScore FROM GameScoreInfo WHERE UserID=@dwUserID
	IF @InsureScore IS NULL
	BEGIN
		SET @InsureScore=0
	END

	-- �һ�����
	SELECT @ConvertRate=StatusValue FROM THAccountsDBLink.THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'RateGold'
	IF @ConvertRate IS NULL OR @ConvertRate=0
	BEGIN
		SET @ConvertRate=1
	END

	-- �һ���¼
	INSERT INTO THRecordDBLink.THRecordDB.dbo.RecordConvertBeans(
		UserID,CurInsureScore,CurBeans,ConvertBeans,ConvertRate,IsGamePlaza,ClientIP)
	VALUES(@UserID,@InsureScore,@CurrentBeans,@dBeans,@ConvertRate,0,@strClientIP)
	
	-- �һ����
	SET @ConvertGold=Convert(BIGINT,@dBeans*@ConvertRate)
	IF NOT EXISTS(SELECT * FROM GameScoreInfo WHERE UserID=@dwUserID)
	BEGIN
		INSERT INTO GameScoreInfo(UserID,InsureScore,RegisterIP,LastLogonMachine,LastLogonIP,RegisterMachine) 
		VALUES (@UserID,@ConvertGold,@strClientIP,@strMachineID,@strClientIP,@strMachineID)
	END
	ELSE
	BEGIN
		UPDATE GameScoreInfo SET InsureScore=InsureScore+@ConvertGold WHERE UserID=@dwUserID
	END

	-- ������Ϸ��
	UPDATE UserCurrencyInfo SET Currency=Currency-@dBeans WHERE UserID=@dwUserID

	-- ��ѯ��Ϸ��
	DECLARE @CurrScore BIGINT
	SELECT @CurrScore=Score FROM GameScoreInfo WHERE UserID=@dwUserID

	-- ��ѯ��Ϸ��
	SELECT @CurrentBeans=Currency FROM UserCurrencyInfo WHERE UserID=@dwUserID

	-- �ɹ���ʾ
	SET @strNotifyContent=N'��ϲ������Ϸ�Ҷһ��ɹ���'

	-- �����¼
	SELECT @CurrScore AS CurrScore,@CurrentBeans AS CurrBeans
END

RETURN 0

GO