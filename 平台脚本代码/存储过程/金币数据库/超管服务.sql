USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_AdminSysUserInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_AdminSysUserInfo]
GO
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_UserMaxWinScore]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_UserMaxWinScore]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO	
----------------------------------------------------------------------------------------------------

-- �����û���Ϣ
CREATE PROC GSP_GR_AdminSysUserInfo
	@dwUserID INT								-- �û���ʶ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ��������
DECLARE @EnjoinScore AS INT

-- ִ���߼�
BEGIN
	DECLARE @DeviceType			TINYINT			-- �豸����
	DECLARE @MaxWinScore		BIGINT			-- �û����ӮǮ
	DECLARE	@MaxWinScoreEx		BIGINT			-- �������ӮǮ
	DECLARE @InScore			BIGINT			-- ת�����
	DECLARE @OutScore			BIGINT			-- ת������
	DECLARE @MemberOrder		TINYINT			-- ��Ա�ȼ�
	DECLARE @LastLogonIP		NVARCHAR(15)	-- ��¼��ַ
	DECLARE @LastLogonMachine	NVARCHAR(32)	-- ��¼����
	DECLARE @RegisterIP			NVARCHAR(15)	-- ע���ַ
	DECLARE @RegisterMachine	NVARCHAR(32)	-- ע�����
	DECLARE @MaxWinScoreGift	BIGINT			-- �������ӮǮ
	DECLARE @RechargeScore		BIGINT			-- ��ֵ����
	DECLARE @TraderInScore		BIGINT			-- ����ת��
	DECLARE @TraderOutScore		BIGINT			-- ���̻���
	DECLARE @GetGuideScore		BIGINT			-- ��ָ����
	DECLARE @PayGuideScore		BIGINT			-- ��ָ����
	DECLARE @PlatformID			INT				-- ƽ̨���
	DECLARE @Currency			DECIMAL(18, 2)	-- �û�����
	DECLARE @PackageFee			INT				-- ��������
	DECLARE @ExchangeFee		INT				-- �һ�����
	DECLARE @PackageRedPacket	INT				-- �������
	DECLARE @ExchangeRedPacket	INT				-- �һ����
	DECLARE @RegisterDate		DATETIME		-- ע��ʱ��
	DECLARE @ObtainedAwards		INT				-- �ѻ���
	DECLARE @RechargeAmount		DECIMAL(18, 2)	-- ��ֵ���
	DECLARE	@ProfitRatio1		BIGINT			-- ӯ��ϵ��1
	DECLARE	@ProfitRatio2		BIGINT			-- ӯ��ϵ��2

	-- ���ӮǮ
	SELECT @MaxWinScore=MaxWinScore,@MaxWinScoreEx=MaxWinScoreEx FROM MaxWinScore WHERE UserID=@dwUserID

	-- ת�����
	SELECT @InScore = SUM(SwapScore) FROM RecordInsure(NOLOCK) WHERE TargetUserID=@dwUserID AND TradeType=3

	-- ת������
	SELECT @OutScore = SUM(SwapScore) FROM RecordInsure(NOLOCK) WHERE SourceUserID=@dwUserID AND TradeType=3

	-- ��ѯ�û�
	SELECT @MemberOrder=MemberOrder, @LastLogonIP=LastLogonIP, @LastLogonMachine=LastLogonMachine, @RegisterIP=RegisterIP, 
	@RegisterMachine=RegisterMachine, @RegisterDate=RegisterDate FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- �������ӮǮ
	SELECT @MaxWinScoreGift=StatusValue FROM THAccountsDBLink.THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'MaxWinScoreGift'

	-- ��ֵ����
	SELECT @RechargeScore=SUM(ConvertBeans*ConvertRate) FROM THRecordDBLink.THRecordDB.dbo.RecordConvertBeans WHERE UserID=@dwUserID

	-- ����ת��
	SELECT @TraderInScore=SUM(B.SwapScore) FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo A, RecordInsure B 
		WHERE A.UserID=B.SourceUserID AND B.TargetUserID=@dwUserID AND B.TradeType=3 AND A.MemberOrder=10

	-- ���̻���
	SELECT @TraderOutScore=SUM(B.SwapScore) FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo A, RecordInsure B 
		WHERE A.UserID=B.TargetUserID AND B.SourceUserID=@dwUserID AND B.TradeType = 3 AND A.MemberOrder=10

	-- ��ָ����
	SELECT @GetGuideScore=SUM(B.GuideScore) FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo A, RecordPayGuide B 
		WHERE A.UserID=B.SourceUserID AND B.TargetUserID=@dwUserID AND A.MemberOrder=10

	-- ��ָ����
	SELECT @PayGuideScore=SUM(B.GuideScore) FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo A, RecordPayGuide B 
		WHERE A.UserID=B.TargetUserID AND B.SourceUserID=@dwUserID AND A.MemberOrder=10
		
	-- ƽ̨���
	SELECT @PlatformID=PlatformID FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- �û�����
	SELECT @Currency=Currency FROM UserCurrencyInfo WHERE UserID=@dwUserID

	-- ��������
	DECLARE @FeeGoodsID AS INT
	SET @FeeGoodsID=301
	SELECT @PackageFee=GoodsCount FROM THAccountsDBLink.THAccountsDB.dbo.AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@FeeGoodsID

	-- �һ�����
	SELECT @ExchangeFee=ISNULL(SUM(GoodsCount),0) FROM THAccountsDBLink.THAccountsDB.dbo.PackageExchangeFee 
		WHERE UserID=@dwUserID AND GoodsID=@FeeGoodsID

	-- �������
	SELECT @PackageRedPacket=GoodsCount FROM THAccountsDBLink.THAccountsDB.dbo.AccountsPackage WHERE UserID=@dwUserID AND GoodsID=901

	-- �һ����
	SELECT @ExchangeRedPacket=ISNULL(SUM(Amount),0) FROM RecordAliPayTransfer WHERE UserID=@dwUserID AND TransferStatus=1

	-- ��ֵ���
	SELECT @RechargeAmount=ISNULL(SUM(PayAmount),0) FROM ShareDetailInfo WHERE UserID=@dwUserID

	-- ��ֵ����
	IF @MaxWinScore IS NULL SET @MaxWinScore=0
	IF @MaxWinScoreEx IS NULL SET @MaxWinScoreEx=0
	IF @InScore IS NULL SET @InScore=0
	IF @OutScore IS NULL SET @OutScore=0
	IF @MemberOrder IS NULL SET @MemberOrder=0
	IF @LastLogonIP IS NULL SET @LastLogonIP=N''
	IF @LastLogonMachine IS NULL SET @LastLogonMachine=N''
	IF @RegisterIP IS NULL SET @RegisterIP=N''
	IF @RegisterMachine IS NULL SET @RegisterMachine=N''
	IF @MaxWinScoreGift IS NULL SET @MaxWinScoreGift=0
	IF @RechargeScore IS NULL SET @RechargeScore=0
	IF @TraderInScore IS NULL SET @TraderInScore=0
	IF @TraderOutScore IS NULL SET @TraderOutScore=0
	IF @GetGuideScore IS NULL SET @GetGuideScore=0
	IF @PayGuideScore IS NULL SET @PayGuideScore=0
	IF @PlatformID IS NULL SET @PlatformID=0
	IF @Currency IS NULL SET @Currency=0
	IF @PackageFee IS NULL SET @PackageFee=0
	IF @ExchangeFee IS NULL SET @ExchangeFee=0
	IF @PackageRedPacket IS NULL SET @PackageRedPacket=0
	IF @ExchangeRedPacket IS NULL SET @ExchangeRedPacket=0
	IF @RegisterDate IS NULL SET @RegisterDate=GETDATE()
	IF @ObtainedAwards IS NULL SET @ObtainedAwards=0
	IF @RechargeAmount IS NULL SET @RechargeAmount=0
	IF @ProfitRatio1 IS NULL SET @ProfitRatio1=0
	IF @ProfitRatio2 IS NULL SET @ProfitRatio2=0
	
	-- �û����� 1Ϊ��ң�2Ϊ���ƣ�10Ϊ����
	IF @MemberOrder=10
	BEGIN
		SET @DeviceType=10
	END
	ELSE
	BEGIN
		SET @DeviceType=1
	END

	-- Ч���ַ
	SELECT @EnjoinScore=EnjoinScore FROM THAccountsDBLink.THAccountsDB.dbo.ConfineAddress
	WHERE AddrString=@LastLogonIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinScore IS NOT NULL AND @EnjoinScore<>0
	BEGIN
		SET @DeviceType=2
	END

	-- Ч���ַ
	SELECT @EnjoinScore=EnjoinScore FROM THAccountsDBLink.THAccountsDB.dbo.ConfineAddress
	WHERE AddrString=@RegisterIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinScore IS NOT NULL AND @EnjoinScore<>0
	BEGIN
		SET @DeviceType=2
	END

	-- Ч�����
	SELECT @EnjoinScore=EnjoinScore FROM THAccountsDBLink.THAccountsDB.dbo.ConfineMachine
	WHERE MachineSerial=@LastLogonMachine AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinScore IS NOT NULL AND @EnjoinScore<>0
	BEGIN
		SET @DeviceType=2
	END

	-- Ч�����
	SELECT @EnjoinScore=EnjoinScore FROM THAccountsDBLink.THAccountsDB.dbo.ConfineMachine
	WHERE MachineSerial=@RegisterMachine AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinScore IS NOT NULL AND @EnjoinScore<>0
	BEGIN
		SET @DeviceType=2
	END

	-- �ѻ��� = �������� + �һ����� + ������� + �һ����
	SET @ObtainedAwards = @PackageFee + @ExchangeFee + @PackageRedPacket + @ExchangeRedPacket

	-- ϵ������
	DECLARE @RatioA INT
	DECLARE @RatioB INT
	SET @RatioA = 10000
	SET @RatioB = 20000

	-- ӯ��ϵ��1 = ת������ + �û����� * ϵ��B + �ѻ��� * ϵ��A - ��ֵ��� * ϵ��A
	SET @ProfitRatio1 = @OutScore + @Currency * @RatioB + @ObtainedAwards * @RatioA - @RechargeAmount * @RatioA

	-- ӯ��ϵ��2 = ת����� + ��ֵ��� * ϵ��A + 500000
	SET @ProfitRatio2 = @InScore + @RechargeAmount * @RatioA + 500000

	-- ���ӮǮ = (��ֵ���� + ����ת�� + ��ָ����)x2 - ���̻��� - ��ָ���� + �������ӮǮ + �������ӮǮ
	SET @MaxWinScore = (@RechargeScore + @TraderInScore + @GetGuideScore)*2 - @TraderOutScore - @PayGuideScore + @MaxWinScoreEx + @MaxWinScoreGift

	-- ������
	SELECT @DeviceType AS DeviceType, @MaxWinScore AS MaxWinScore, @MaxWinScoreEx AS MaxWinScoreEx, @InScore AS InScore, 
			@OutScore AS OutScore, @PlatformID AS PlatformID, @RegisterDate AS RegisterDate, @ObtainedAwards AS ObtainedAwards, 
			@RechargeAmount AS RechargeAmount, @ProfitRatio1 AS ProfitRatio1, @ProfitRatio2 AS ProfitRatio2
END

RETURN 0

GO

---------------------------------------------------------------------------------------------

-- �������ӮǮ
CREATE PROC GSP_GR_UserMaxWinScore
	@dwUserID INT,								-- �û���ʶ
	@lMaxWinScore BIGINT						-- ���ӮǮ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	IF NOT EXISTS(SELECT * FROM MaxWinScore WHERE UserID=@dwUserID)
	BEGIN
		INSERT MaxWinScore (UserID,MaxWinScoreEx,MaxWinScoreExDate) 
		VALUES (@dwUserID,@lMaxWinScore,getdate())
	END
	ELSE
	BEGIN
		UPDATE MaxWinScore SET MaxWinScoreEx=@lMaxWinScore,MaxWinScoreExDate=getdate() WHERE UserID=@dwUserID
	END
END

RETURN 0

GO

---------------------------------------------------------------------------------------------
