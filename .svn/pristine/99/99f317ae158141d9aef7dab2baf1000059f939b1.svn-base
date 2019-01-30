----------------------------------------------------------------------
-- 版权：2017
-- 时间：2017-10-18
-- 用途：会员充值
----------------------------------------------------------------------

USE [THTreasureDB]
GO

-- 会员充值
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_MemberRecharge') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_MemberRecharge
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

---------------------------------------------------------------------------------------
-- 会员充值
CREATE PROCEDURE NET_PW_MemberRecharge
	@strOrdersID		NVARCHAR(50),			--	订单编号
	@PayAmount			DECIMAL(18,2),			--  支付金额
	@strIPAddress		NVARCHAR(31),			--	连接地址
	@strErrorDescribe	NVARCHAR(127) OUTPUT	--	输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 订单信息
DECLARE @OperUserID INT
DECLARE @ShareID INT
DECLARE @UserID INT
DECLARE @GameID INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @OrderAmount DECIMAL(18,2)
DECLARE @DiscountScale DECIMAL(18,2)
DECLARE @IPAddress NVARCHAR(15)
DECLARE @CurrencyType TINYINT
DECLARE @Currency DECIMAL(18,2)
DECLARE @OrderID NVARCHAR(50)

-- 用户信息
DECLARE @Score BIGINT

-- 执行逻辑
BEGIN
	-- 订单查询
	SELECT @OperUserID=OperUserID,@ShareID=ShareID,@UserID=UserID,@GameID=GameID,@Accounts=Accounts,
		@OrderID=OrderID,@OrderAmount=OrderAmount,@DiscountScale=DiscountScale,@CurrencyType=CurrencyType
	FROM OnLineOrder WHERE OrderID=@strOrdersID

	-- 订单存在
	IF @OrderID IS NULL
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值订单不存在。'
		RETURN 1
	END

	-- 订单重复
	IF EXISTS(SELECT OrderID FROM ShareDetailInfo(NOLOCK) WHERE OrderID=@strOrdersID) 
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值订单重复。'
		RETURN 2
	END

	-- 货币查询
	DECLARE @BeforeCurrency DECIMAL(18,2)
	SELECT @BeforeCurrency=Currency FROM UserCurrencyInfo WHERE UserID=@UserID
	IF @BeforeCurrency IS NULL SET @BeforeCurrency=0

	--------------------------------------------------------------------------------
	-- 充值货币
	SET @Currency=0

	--------------------------------------------------------------------------------
	-- 会员等级
	DECLARE @MemberOrder TINYINT
	SELECT @MemberOrder=MemberOrder FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@UserID
	IF @MemberOrder IS NULL SET @MemberOrder=0

	--------------------------------------------------------------------------------
	-- 充值分数
	DECLARE @RechargeScore BIGINT
	SELECT @RechargeScore=Score FROM GlobalRechargeMemberConfig WHERE Price=@PayAmount AND Nullity=0
	IF @RechargeScore IS NULL SET @RechargeScore=0

	-- 判断会员
	IF @MemberOrder<>10 SET @RechargeScore=0

	-- 更新分数
	UPDATE GameScoreInfo SET Score=Score+@RechargeScore WHERE UserID=@UserID
	IF @@ROWCOUNT=0
	BEGIN
		INSERT INTO GameScoreInfo(UserID,Score,RegisterIP,LastLogonIP) VALUES (@UserID,@RechargeScore,@strIPAddress,@strIPAddress)
	END

	--------------------------------------------------------------------------------

	-- 产生记录
	INSERT INTO ShareDetailInfo(
		OperUserID,ShareID,UserID,GameID,Accounts,OrderID,OrderAmount,DiscountScale,PayAmount,
		CurrencyType,Currency,BeforeCurrency,IPAddress)
	VALUES(
		@OperUserID,@ShareID,@UserID,@GameID,@Accounts,@OrderID,@OrderAmount,@DiscountScale,@PayAmount,
		@CurrencyType,@Currency,@BeforeCurrency,@strIPAddress)

	-- 渠道记录
	IF @ShareID=13 OR @ShareID=14 OR @ShareID=19
	BEGIN
		-- 平台编号
		DECLARE @PlatformID INT
		SELECT @PlatformID=PlatformID FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@UserID

		-- 官方平台
		IF @PlatformID=1002 OR @PlatformID=2001
		BEGIN
			-- 所属渠道
			DECLARE @ChannelID INT
			SELECT @ChannelID=ChannelID FROM THAccountsDBLink.THAccountsDB.dbo.AccountsChannel WHERE UserID=@UserID
			IF @ChannelID IS NOT NULL
			BEGIN
				-- 查询比例
				DECLARE @OutPercent DECIMAL(18,2)
				DECLARE @Nullity TINYINT
				SELECT @OutPercent=OutPercent,@Nullity=Nullity FROM THAccountsDBLink.THAccountsDB.dbo.ChannelConfig WHERE ChannelID=@ChannelID
				IF @OutPercent IS NOT NULL AND @Nullity IS NOT NULL
				BEGIN
					-- 写入记录
					INSERT RecordChannelRecharge (PlatformID,ChannelID,UserID,ShareID,OrderID,PayAmount,OutPercent,OutAmount,Nullity)
					VALUES (@PlatformID,@ChannelID,@UserID,@ShareID,@OrderID,@PayAmount,@OutPercent,@OutPercent*@PayAmount/100,@Nullity)
				END
			END
		END
	END

	-- 更新订单状态
	UPDATE OnLineOrder SET OrderStatus=2,Currency=@Currency,PayAmount=@PayAmount WHERE OrderID=@OrderID
END

RETURN 0

GO

---------------------------------------------------------------------------------------