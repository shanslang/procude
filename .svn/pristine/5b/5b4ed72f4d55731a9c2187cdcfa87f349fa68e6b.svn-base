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

-- 超管用户信息
CREATE PROC GSP_GR_AdminSysUserInfo
	@dwUserID INT								-- 用户标识
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 辅助变量
DECLARE @EnjoinScore AS INT

-- 执行逻辑
BEGIN
	DECLARE @DeviceType			TINYINT			-- 设备类型
	DECLARE @MaxWinScore		BIGINT			-- 用户最大赢钱
	DECLARE	@MaxWinScoreEx		BIGINT			-- 附加最大赢钱
	DECLARE @InScore			BIGINT			-- 转入分数
	DECLARE @OutScore			BIGINT			-- 转出分数
	DECLARE @MemberOrder		TINYINT			-- 会员等级
	DECLARE @LastLogonIP		NVARCHAR(15)	-- 登录地址
	DECLARE @LastLogonMachine	NVARCHAR(32)	-- 登录机器
	DECLARE @RegisterIP			NVARCHAR(15)	-- 注册地址
	DECLARE @RegisterMachine	NVARCHAR(32)	-- 注册机器
	DECLARE @MaxWinScoreGift	BIGINT			-- 赠送最大赢钱
	DECLARE @RechargeScore		BIGINT			-- 充值分数
	DECLARE @TraderInScore		BIGINT			-- 银商转入
	DECLARE @TraderOutScore		BIGINT			-- 银商回收
	DECLARE @GetGuideScore		BIGINT			-- 收指导费
	DECLARE @PayGuideScore		BIGINT			-- 付指导费
	DECLARE @PlatformID			INT				-- 平台编号
	DECLARE @Currency			DECIMAL(18, 2)	-- 用户货币
	DECLARE @PackageFee			INT				-- 背包话费
	DECLARE @ExchangeFee		INT				-- 兑换话费
	DECLARE @PackageRedPacket	INT				-- 背包红包
	DECLARE @ExchangeRedPacket	INT				-- 兑换红包
	DECLARE @RegisterDate		DATETIME		-- 注册时间
	DECLARE @ObtainedAwards		INT				-- 已获奖励
	DECLARE @RechargeAmount		DECIMAL(18, 2)	-- 充值金额
	DECLARE	@ProfitRatio1		BIGINT			-- 盈利系数1
	DECLARE	@ProfitRatio2		BIGINT			-- 盈利系数2

	-- 最大赢钱
	SELECT @MaxWinScore=MaxWinScore,@MaxWinScoreEx=MaxWinScoreEx FROM MaxWinScore WHERE UserID=@dwUserID

	-- 转入分数
	SELECT @InScore = SUM(SwapScore) FROM RecordInsure(NOLOCK) WHERE TargetUserID=@dwUserID AND TradeType=3

	-- 转出分数
	SELECT @OutScore = SUM(SwapScore) FROM RecordInsure(NOLOCK) WHERE SourceUserID=@dwUserID AND TradeType=3

	-- 查询用户
	SELECT @MemberOrder=MemberOrder, @LastLogonIP=LastLogonIP, @LastLogonMachine=LastLogonMachine, @RegisterIP=RegisterIP, 
	@RegisterMachine=RegisterMachine, @RegisterDate=RegisterDate FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 赠送最大赢钱
	SELECT @MaxWinScoreGift=StatusValue FROM THAccountsDBLink.THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'MaxWinScoreGift'

	-- 充值分数
	SELECT @RechargeScore=SUM(ConvertBeans*ConvertRate) FROM THRecordDBLink.THRecordDB.dbo.RecordConvertBeans WHERE UserID=@dwUserID

	-- 银商转入
	SELECT @TraderInScore=SUM(B.SwapScore) FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo A, RecordInsure B 
		WHERE A.UserID=B.SourceUserID AND B.TargetUserID=@dwUserID AND B.TradeType=3 AND A.MemberOrder=10

	-- 银商回收
	SELECT @TraderOutScore=SUM(B.SwapScore) FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo A, RecordInsure B 
		WHERE A.UserID=B.TargetUserID AND B.SourceUserID=@dwUserID AND B.TradeType = 3 AND A.MemberOrder=10

	-- 收指导费
	SELECT @GetGuideScore=SUM(B.GuideScore) FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo A, RecordPayGuide B 
		WHERE A.UserID=B.SourceUserID AND B.TargetUserID=@dwUserID AND A.MemberOrder=10

	-- 付指导费
	SELECT @PayGuideScore=SUM(B.GuideScore) FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo A, RecordPayGuide B 
		WHERE A.UserID=B.TargetUserID AND B.SourceUserID=@dwUserID AND A.MemberOrder=10
		
	-- 平台编号
	SELECT @PlatformID=PlatformID FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 用户货币
	SELECT @Currency=Currency FROM UserCurrencyInfo WHERE UserID=@dwUserID

	-- 背包话费
	DECLARE @FeeGoodsID AS INT
	SET @FeeGoodsID=301
	SELECT @PackageFee=GoodsCount FROM THAccountsDBLink.THAccountsDB.dbo.AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@FeeGoodsID

	-- 兑换话费
	SELECT @ExchangeFee=ISNULL(SUM(GoodsCount),0) FROM THAccountsDBLink.THAccountsDB.dbo.PackageExchangeFee 
		WHERE UserID=@dwUserID AND GoodsID=@FeeGoodsID

	-- 背包红包
	SELECT @PackageRedPacket=GoodsCount FROM THAccountsDBLink.THAccountsDB.dbo.AccountsPackage WHERE UserID=@dwUserID AND GoodsID=901

	-- 兑换红包
	SELECT @ExchangeRedPacket=ISNULL(SUM(Amount),0) FROM RecordAliPayTransfer WHERE UserID=@dwUserID AND TransferStatus=1

	-- 充值金额
	SELECT @RechargeAmount=ISNULL(SUM(PayAmount),0) FROM ShareDetailInfo WHERE UserID=@dwUserID

	-- 空值处理
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
	
	-- 用户类型 1为玩家，2为限制，10为银商
	IF @MemberOrder=10
	BEGIN
		SET @DeviceType=10
	END
	ELSE
	BEGIN
		SET @DeviceType=1
	END

	-- 效验地址
	SELECT @EnjoinScore=EnjoinScore FROM THAccountsDBLink.THAccountsDB.dbo.ConfineAddress
	WHERE AddrString=@LastLogonIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinScore IS NOT NULL AND @EnjoinScore<>0
	BEGIN
		SET @DeviceType=2
	END

	-- 效验地址
	SELECT @EnjoinScore=EnjoinScore FROM THAccountsDBLink.THAccountsDB.dbo.ConfineAddress
	WHERE AddrString=@RegisterIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinScore IS NOT NULL AND @EnjoinScore<>0
	BEGIN
		SET @DeviceType=2
	END

	-- 效验机器
	SELECT @EnjoinScore=EnjoinScore FROM THAccountsDBLink.THAccountsDB.dbo.ConfineMachine
	WHERE MachineSerial=@LastLogonMachine AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinScore IS NOT NULL AND @EnjoinScore<>0
	BEGIN
		SET @DeviceType=2
	END

	-- 效验机器
	SELECT @EnjoinScore=EnjoinScore FROM THAccountsDBLink.THAccountsDB.dbo.ConfineMachine
	WHERE MachineSerial=@RegisterMachine AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinScore IS NOT NULL AND @EnjoinScore<>0
	BEGIN
		SET @DeviceType=2
	END

	-- 已获奖励 = 背包话费 + 兑换话费 + 背包红包 + 兑换红包
	SET @ObtainedAwards = @PackageFee + @ExchangeFee + @PackageRedPacket + @ExchangeRedPacket

	-- 系数定义
	DECLARE @RatioA INT
	DECLARE @RatioB INT
	SET @RatioA = 10000
	SET @RatioB = 20000

	-- 盈利系数1 = 转出分数 + 用户货币 * 系数B + 已获奖励 * 系数A - 充值金额 * 系数A
	SET @ProfitRatio1 = @OutScore + @Currency * @RatioB + @ObtainedAwards * @RatioA - @RechargeAmount * @RatioA

	-- 盈利系数2 = 转入分数 + 充值金额 * 系数A + 500000
	SET @ProfitRatio2 = @InScore + @RechargeAmount * @RatioA + 500000

	-- 最大赢钱 = (充值分数 + 银商转入 + 收指导费)x2 - 银商回收 - 付指导费 + 附加最大赢钱 + 赠送最大赢钱
	SET @MaxWinScore = (@RechargeScore + @TraderInScore + @GetGuideScore)*2 - @TraderOutScore - @PayGuideScore + @MaxWinScoreEx + @MaxWinScoreGift

	-- 输出结果
	SELECT @DeviceType AS DeviceType, @MaxWinScore AS MaxWinScore, @MaxWinScoreEx AS MaxWinScoreEx, @InScore AS InScore, 
			@OutScore AS OutScore, @PlatformID AS PlatformID, @RegisterDate AS RegisterDate, @ObtainedAwards AS ObtainedAwards, 
			@RechargeAmount AS RechargeAmount, @ProfitRatio1 AS ProfitRatio1, @ProfitRatio2 AS ProfitRatio2
END

RETURN 0

GO

---------------------------------------------------------------------------------------------

-- 附加最大赢钱
CREATE PROC GSP_GR_UserMaxWinScore
	@dwUserID INT,								-- 用户标识
	@lMaxWinScore BIGINT						-- 最大赢钱
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
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
