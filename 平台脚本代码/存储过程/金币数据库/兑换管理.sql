
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

-- 加载会员
CREATE PROC GSP_GR_LoadMemberParameter	
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	-- 加载会员
	SELECT MemberName, MemberOrder, MemberPrice, PresentScore FROM MemberType(NOLOCK)

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 购买会员
CREATE PROC GSP_GR_PurchaseMember

	-- 用户信息
	@dwUserID INT,								-- 用户标识
	@cbMemberOrder INT,							-- 会员标识
	@PurchaseTime INT,							-- 购买时间

	-- 系统信息	
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strNotifyContent NVARCHAR(127) OUTPUT		-- 输出信息

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN

	-- 查询会员
	DECLARE @Nullity BIT
	DECLARE @CurrMemberOrder SMALLINT	
	SELECT @Nullity=Nullity, @CurrMemberOrder=MemberOrder FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 用户判断
	IF @CurrMemberOrder IS NULL
	BEGIN
		SET @strNotifyContent=N'您的帐号不存在，请联系客户服务中心了解详细情况！'
		RETURN 1
	END	

	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strNotifyContent=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 2
	END

	-- 变量定义	
	DECLARE @MemberName AS NVARCHAR(16)
	DECLARE @MemberPrice AS DECIMAL(18,2)
	DECLARE @PresentScore AS BIGINT
	DECLARE @MemberRight AS INT	

	-- 读取会员
	SELECT @MemberName=MemberName,@MemberPrice=MemberPrice, @PresentScore=PresentScore,@MemberRight=UserRight	
	FROM MemberType(NOLOCK) WHERE MemberOrder=@cbMemberOrder	

	-- 存在判断
	IF @MemberName IS NULL
	BEGIN
		SET @strNotifyContent=N'抱歉地通知您，您所购买的会员不存在或者正在维护中，请联系客户服务中心了解详细情况！'
		RETURN 4
	END

	DECLARE @Currency DECIMAL(18,2)
	SELECT @Currency=Currency FROM UserCurrencyInfo(NOLOCK) WHERE UserID=@dwUserID
	IF @Currency IS NULL Set @Currency=0

	-- 费用计算
	DECLARE @ConsumeCurrency DECIMAL(18,2)
	SELECT @ConsumeCurrency=@MemberPrice*@PurchaseTime	

	-- 读取游戏豆
	DECLARE @CurrencyOP DECIMAL(18,2)
	declare @Ret int
	set @CurrencyOP = -@ConsumeCurrency
	exec @Ret = proc_CurrencyOp @dwUserID,@CurrencyOP
	if @Ret <> 0
	BEGIN
		-- 错误信息
		SET @strNotifyContent=N'您身上的游戏豆余额不足，请充值后再次尝试！'
		RETURN 5
	END

	-- 读取游戏币
	DECLARE @Score BIGINT
	SELECT @Score=Score FROM GameScoreInfo(NOLOCK) WHERE UserID=@dwUserID
	-- 插入资料
	IF @Score IS NULL
		set @Score =0

	-- 赠送计算
	DECLARE @TotalPreSentScore BIGINT
	SELECT @TotalPreSentScore=@PreSentScore*@PurchaseTime		

	-- 兑换日志
	INSERT INTO RecordBuyMember(UserID,MemberOrder,MemberMonths,MemberPrice,Currency,PresentScore,BeforeCurrency,BeforeScore,ClinetIP,InputDate)
	VALUES(@dwUserID,@cbMemberOrder,@PurchaseTime,@MemberPrice,@ConsumeCurrency,@TotalPreSentScore,@Currency,@Score,@strClientIP,GETDATE())
	
	-- 变化日志
	INSERT INTO RecordCurrencyChange(UserID,ChangeCurrency,ChangeType,BeforeCurrency,AfterCurrency,ClinetIP,InputDate,Remark)
	VALUES(@dwUserID,@ConsumeCurrency,10,@Currency,@Currency-@ConsumeCurrency,@strClientIP,GETDATE(),'兑换游戏币')	

	--exec proc_BankOp @dwUserID,@TotalPreSentScore
	update GameScoreInfo set score=score+@TotalPreSentScore where userid = @dwUserID
	
	-- 会员资料
	DECLARE @MaxUserRight INT
	DECLARE @MemberValidMonth INT
	DECLARE @MaxMemberOrder TINYINT	 
	DECLARE @MemberOverDate DATETIME
	DECLARE @MemberSwitchDate DATETIME

	-- 有效期限
	SELECT @MemberValidMonth= @PurchaseTime

	-- 删除过期
	DELETE FROM THAccountsDBLink.THAccountsDB.dbo.AccountsMember
	WHERE UserID=@dwUserID AND MemberOrder=@cbMemberOrder AND MemberOverDate<=GETDATE()

	-- 更新会员
	UPDATE THAccountsDBLink.THAccountsDB.dbo.AccountsMember SET MemberOverDate=DATEADD(mm,@MemberValidMonth, GETDATE())
	WHERE UserID=@dwUserID AND MemberOrder=@cbMemberOrder
	IF @@ROWCOUNT=0
	BEGIN
		INSERT THAccountsDBLink.THAccountsDB.dbo.AccountsMember(UserID,MemberOrder,UserRight,MemberOverDate)
		VALUES (@dwUserID,@cbMemberOrder,@MemberRight,DATEADD(mm,@MemberValidMonth, GETDATE()))
	END

	-- 绑定会员,(会员期限与切换时间)
	SELECT @MaxMemberOrder=MAX(MemberOrder),@MemberOverDate=MAX(MemberOverDate),@MemberSwitchDate=MIN(MemberOverDate)
	FROM THAccountsDBLink.THAccountsDB.dbo.AccountsMember WHERE UserID=@dwUserID

	-- 会员权限
	SELECT @MaxUserRight=UserRight FROM THAccountsDBLink.THAccountsDB.dbo.AccountsMember
	WHERE UserID=@dwUserID AND MemberOrder=@MaxMemberOrder
	
	-- 附加会员卡信息
	UPDATE THAccountsDBLink.THAccountsDB.dbo.AccountsInfo
	SET MemberOrder=@MaxMemberOrder,UserRight=@MaxUserRight,MemberOverDate=@MemberOverDate,MemberSwitchDate=@MemberSwitchDate
	WHERE UserID=@dwUserID

	-- 会员等级
	SELECT @CurrMemberOrder=MemberOrder FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 查询游戏币
	DECLARE @CurrScore BIGINT
	SELECT @CurrScore=Score FROM GameScoreInfo WHERE UserID=@dwUserID	

	-- 查询游戏豆
	DECLARE @CurrBeans DECIMAL(18,2)
	SELECT @CurrBeans=Currency FROM UserCurrencyInfo WHERE UserID=@dwUserID

	-- 成功提示
	SET @strNotifyContent=N'恭喜您，会员购买成功！' 

	-- 输出记录
	SELECT @CurrMemberOrder AS MemberOrder,@MaxUserRight AS UserRight,@CurrScore AS CurrScore,@CurrBeans AS CurrBeans

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 兑换游戏币
CREATE PROC GSP_GR_ExchangeScore

	-- 用户信息
	@dwUserID INT,								-- 用户标识
	@ExchangeIngot INT,							-- 兑换元宝	

	-- 系统信息	
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strNotifyContent NVARCHAR(127) OUTPUT		-- 输出信息

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN

	-- 查询会员
	DECLARE @Nullity BIT
	DECLARE @UserIngot INT	
	SELECT @Nullity=Nullity, @UserIngot=UserMedal FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 用户判断
	IF @UserIngot IS NULL
	BEGIN
		SET @strNotifyContent=N'您的帐号不存在，请联系客户服务中心了解详细情况！'
		RETURN 1
	END	

	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strNotifyContent=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 2
	END

	-- 元宝判断
	IF @UserIngot < @ExchangeIngot
	BEGIN
		SET @strNotifyContent=N'您的元宝不足，请调整好兑换金额后再试！'
		RETURN 3		
	END

	-- 兑换比率
	DECLARE @ExchangeRate INT
	SELECT @ExchangeRate=StatusValue FROM THAccountsDBLink.THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'MedalExchangeRate'

	-- 系统错误
	IF @ExchangeRate IS NULL
	BEGIN
		SET @strNotifyContent=N'抱歉！元宝兑换失败，请联系客户服务中心了解详细情况。'
		RETURN 4			
	END

	-- 计算游戏币
	DECLARE @ExchangeScore BIGINT
	SET @ExchangeScore = @ExchangeRate*@ExchangeIngot

	-- 查询银行
	DECLARE @InsureScore BIGINT
	SELECT @InsureScore=InsureScore FROM GameScoreInfo WHERE UserID=@dwUserID

	-- 插入资料
	IF @InsureScore IS NULL
	BEGIN
		-- 设置变量
		SET @InsureScore=0

		-- 插入资料
		INSERT INTO GameScoreInfo (UserID, LastLogonIP, LastLogonMachine, RegisterIP, RegisterMachine)
		VALUES (@dwUserID, @strClientIP, @strMachineID, @strClientIP, @strMachineID)		
	END	

	-- 更新银行
	UPDATE GameScoreInfo SET InsureScore=InsureScore+@ExchangeScore WHERE UserID=@dwUserID	
	
	-- 更新元宝
	SET @UserIngot=@UserIngot-@ExchangeIngot
	UPDATE THAccountsDBLink.THAccountsDB.dbo.AccountsInfo SET UserMedal=@UserIngot WHERE UserID=@dwUserID			

	-- 查询游戏币
	DECLARE @CurrScore BIGINT
	SELECT @CurrScore=Score FROM GameScoreInfo WHERE UserID=@dwUserID

	-- 插入记录
	INSERT THRecordDBLink.THRecordDB.dbo.RecordConvertUserMedal (UserID, CurInsureScore, CurUserMedal, ConvertUserMedal, ConvertRate, IsGamePlaza, ClientIP, CollectDate)
	VALUES(@dwUserID, @InsureScore, @UserIngot, @ExchangeIngot, @ExchangeRate, 0, @strClientIP, GetDate())

	-- 成功提示
	SET @strNotifyContent=N'恭喜您，游戏币兑换成功！'

	-- 输出记录
	SELECT @UserIngot AS CurrIngot,@CurrScore AS CurrScore

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 游戏豆兑换
CREATE PROCEDURE GSP_GR_ConvertBeans
	@dwUserID			INT,					-- 用户 I D
	@strPassword		NCHAR(32),				-- 用户密码
	@dBeans				DECIMAL(18,2),			-- 兑换数量
	@strClientIP		VARCHAR(15),			-- 兑换地址
	@strMachineID		NVARCHAR(32),			-- 机器标识
	@strNotifyContent	NVARCHAR(127) OUTPUT	-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 用户信息
DECLARE @UserID INT
DECLARE @LogonPass NCHAR(32)
DECLARE @Nullity BIT
DECLARE @StunDown BIT
DECLARE @CurrentBeans DECIMAL(18,2)

-- 金币信息
DECLARE @InsureScore BIGINT

-- 兑换金币
DECLARE @ConvertGold BIGINT

-- 兑换比例
DECLARE @ConvertRate INT

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID, @LogonPass=LogonPass, @Nullity=Nullity, @StunDown=StunDown
	FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		SET @strNotifyContent=N'您的帐号不存在或者密码输入有误，请查证后再次尝试登录！'
		RETURN 1
	END
	
	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strNotifyContent=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 2
	END

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SET @strNotifyContent=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 3
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strNotifyContent=N'您的密码输入有误，请查证后再次尝试！'
		RETURN 4
	END

	-- 查询游戏豆
	SELECT @CurrentBeans=Currency FROM UserCurrencyInfo WHERE UserID=@dwUserID
	IF @CurrentBeans IS NULL
	BEGIN
		SET @CurrentBeans=0
	END

	-- 数量判断
	IF @dBeans > @CurrentBeans or @CurrentBeans=0
	BEGIN
		SET @strNotifyContent=N'抱歉，您的宝石不足，无法兑换！'
		RETURN 5
	END
	
	-- 查询银行
	SELECT @InsureScore=InsureScore FROM GameScoreInfo WHERE UserID=@dwUserID
	IF @InsureScore IS NULL
	BEGIN
		SET @InsureScore=0
	END

	-- 兑换比例
	SELECT @ConvertRate=StatusValue FROM THAccountsDBLink.THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'RateGold'
	IF @ConvertRate IS NULL OR @ConvertRate=0
	BEGIN
		SET @ConvertRate=1
	END

	-- 兑换记录
	INSERT INTO THRecordDBLink.THRecordDB.dbo.RecordConvertBeans(
		UserID,CurInsureScore,CurBeans,ConvertBeans,ConvertRate,IsGamePlaza,ClientIP)
	VALUES(@UserID,@InsureScore,@CurrentBeans,@dBeans,@ConvertRate,0,@strClientIP)
	
	-- 兑换金币
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

	-- 更新游戏豆
	UPDATE UserCurrencyInfo SET Currency=Currency-@dBeans WHERE UserID=@dwUserID

	-- 查询游戏币
	DECLARE @CurrScore BIGINT
	SELECT @CurrScore=Score FROM GameScoreInfo WHERE UserID=@dwUserID

	-- 查询游戏豆
	SELECT @CurrentBeans=Currency FROM UserCurrencyInfo WHERE UserID=@dwUserID

	-- 成功提示
	SET @strNotifyContent=N'恭喜您，游戏币兑换成功！'

	-- 输出记录
	SELECT @CurrScore AS CurrScore,@CurrentBeans AS CurrBeans
END

RETURN 0

GO