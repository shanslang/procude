----------------------------------------------------------------------
-- 版权：2011
-- 时间：2011-09-1
-- 用途：在线充值
----------------------------------------------------------------------

USE [THTreasureDB]
GO

-- 在线充值
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_FilledOnLine') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_FilledOnLine
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

---------------------------------------------------------------------------------------
-- 在线充值
CREATE PROCEDURE NET_PW_FilledOnLine
	@strOrdersID		NVARCHAR(50),			--	订单编号
	@PayAmount			DECIMAL(18,2),			--  支付金额
	@isVB				INT,					--	是否电话充值
	@strIPAddress		NVARCHAR(31),			--	用户帐号	
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
DECLARE @GiftScore BIGINT
DECLARE @Lottery INT
DECLARE @RedPacket INT
DECLARE @PackageFee INT
DECLARE @RecordNote NVARCHAR(32)
DECLARE @CurInsure BIGINT

-- 用户信息
DECLARE @Score BIGINT

-- 其他信息
DECLARE @Rate INT

-- 执行逻辑
BEGIN
	-- 订单查询
	SELECT @OperUserID=OperUserID,@ShareID=ShareID,@UserID=UserID,@GameID=GameID,@Accounts=Accounts,
		@OrderID=OrderID,@OrderAmount=OrderAmount,@DiscountScale=DiscountScale,@CurrencyType=CurrencyType
	FROM OnLineOrder WHERE OrderID=@strOrdersID

	-- 订单存在
	IF @OrderID IS NULL or @PayAmount <=0 --校验负数
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值订单不存在。'
		RETURN 1
	END

	-- 订单重复
	--IF EXISTS(SELECT OrderID FROM ShareDetailInfo(NOLOCK) WHERE OrderID=@strOrdersID) 
	--BEGIN
	--	SET @strErrorDescribe=N'抱歉！充值订单重复。'
	--	RETURN 2
	--END

	-- 货币汇率
	SELECT @Rate=StatusValue FROM THAccountsDBLink.THAccountsDB.dbo.SystemStatusInfo WHERE StatusString='RateCurrency'
	IF @Rate=0 OR @Rate IS NULL
		SET @Rate=1

	-- 货币查询
	DECLARE @BeforeCurrency DECIMAL(18,2)
	SELECT @BeforeCurrency=Currency FROM UserCurrencyInfo WHERE UserID=@UserID
	IF @BeforeCurrency IS NULL SET @BeforeCurrency=0
	SET @Currency=0
	SET @GiftScore=0
	SET @RedPacket=0
	SET @PackageFee=0
	SET @Lottery=0

	-- 首充礼包
	IF @CurrencyType=4
	BEGIN		
		-- 礼包内容
		IF NOT EXISTS(SELECT * FROM ShareDetailInfo WHERE UserID=@UserID AND CurrencyType=@CurrencyType AND PayAmount=@PayAmount) AND @PayAmount=3
		BEGIN
			SET @Currency=10
			SET @GiftScore=50000
			SET @RedPacket=1
			SET @PackageFee=1
		END
		ELSE
		BEGIN
			--SET @Currency=@PayAmount*@Rate
			SET @Currency=0
			SET @GiftScore=0
			SET @RedPacket=0
			SET @PackageFee=0
		END
	END

	-- 充值礼包
	IF @CurrencyType=3
	BEGIN		
		IF @PayAmount=8 and NOT EXISTS(SELECT * FROM ShareDetailInfo WHERE UserID=@UserID AND CurrencyType=@CurrencyType AND PayAmount=@PayAmount)
		BEGIN
			SET @Currency=0
			SET @GiftScore=100000
			SET @RedPacket=2
			SET @Lottery=30
		END
		ELSE IF @PayAmount=28 and NOT EXISTS(SELECT * FROM ShareDetailInfo WHERE UserID=@UserID AND CurrencyType=@CurrencyType AND PayAmount=@PayAmount)
		BEGIN
			SET @Currency=280
			SET @GiftScore=120000
			SET @RedPacket=0
			SET @Lottery=0
		END
		ELSE IF @PayAmount=40 and NOT EXISTS(SELECT * FROM ShareDetailInfo WHERE UserID=@UserID AND CurrencyType=@CurrencyType AND PayAmount=@PayAmount)
		BEGIN
			SET @Currency=60
			SET @GiftScore=500000
			SET @RedPacket=4
			SET @Lottery=80
		END
		ELSE IF @PayAmount=68 and NOT EXISTS(SELECT * FROM ShareDetailInfo WHERE UserID=@UserID AND CurrencyType=@CurrencyType AND PayAmount=@PayAmount)
		BEGIN
			SET @Currency=500
			SET @GiftScore=400000
			SET @RedPacket=7
		END
		ELSE
		BEGIN
			--SET @Currency=@PayAmount*@Rate
			SET @Currency=0
			SET @GiftScore=0
			SET @RedPacket=0
			SET @PackageFee=0
		END
	END

	--select @Currency,@GiftScore,@RedPacket,@PackageFee,@CurrencyType
	--return 1

	-- 充值金币
	IF @CurrencyType=2
	BEGIN
		IF @PayAmount=6
		BEGIN
			SET @GiftScore=60000
		END
		ELSE IF @PayAmount=18
		BEGIN
			SET @GiftScore=210000
		END
		ELSE IF @PayAmount=50
		BEGIN
			SET @GiftScore=600000
		END
		ELSE IF @PayAmount=98
		BEGIN
			SET @GiftScore=1250000
		END
		ELSE IF @PayAmount=188
		BEGIN
			SET @GiftScore=2500000
		END
		ELSE IF @PayAmount=328
		BEGIN
			SET @GiftScore=4580000
		END
		ELSE IF @PayAmount=518
		BEGIN
			SET @GiftScore=7580000
		END
		ELSE IF @PayAmount=698
		BEGIN
			SET @GiftScore=10900000
		END
		ELSE
		BEGIN
			SET @GiftScore=0
		END
	END

	-- 充值钻石
	IF @CurrencyType=1
	BEGIN
		IF @PayAmount=12
		BEGIN
			SET @Currency=120
		END
		ELSE IF @PayAmount=30
		BEGIN
			SET @Currency=330
		END
		ELSE IF @PayAmount=60
		BEGIN
			SET @Currency=700
		END
		ELSE IF @PayAmount=108
		BEGIN
			SET @Currency=1280
		END
		ELSE IF @PayAmount=198
		BEGIN
			SET @Currency=2500
		END
		ELSE IF @PayAmount=328
		BEGIN
			SET @Currency=4300
		END
		ELSE IF @PayAmount=518
		BEGIN
			SET @Currency=7180
		END
		ELSE IF @PayAmount=698
		BEGIN
			SET @Currency=10800
		END
		ELSE
		BEGIN
			--SET @Currency=@PayAmount*@Rate
			SET @Currency=0
			SET @GiftScore=0
		END
	END


	-- 赠送写分
	IF @GiftScore<>0
	BEGIN
		SELECT @CurInsure=InsureScore FROM GameScoreInfo WHERE UserID=@UserID
		IF @CurInsure IS NULL SET @CurInsure=0

		UPDATE GameScoreInfo SET Score=Score+@GiftScore WHERE UserID=@UserID
		IF @@ROWCOUNT=0
		BEGIN
			INSERT INTO GameScoreInfo(UserID,Score,RegisterIP,LastLogonIP) VALUES (@UserID,@GiftScore,@strIPAddress,@strIPAddress)
		END

		-- 写赠送金币记录
		INSERT INTO THRecordDBLink.THRecordDB.dbo.RecordGrantTreasure(MasterID,ClientIP,CollectDate,UserID,CurGold,AddGold,Reason)
		VALUES (1,@strIPAddress,GETDATE(),@UserID,@CurInsure,@GiftScore,N'礼包赠送金币')
	END

	-- 赠送红包
	IF @RedPacket<>0
	BEGIN
		DECLARE @RedPacketID INT
		SET @RedPacketID=901

		-- 更新背包
		UPDATE THAccountsDBLink.THAccountsDB.dbo.AccountsPackage SET GoodsCount=GoodsCount+@RedPacket WHERE UserID=@UserID AND GoodsID=@RedPacketID
		IF @@ROWCOUNT=0
		BEGIN
			INSERT THAccountsDBLink.THAccountsDB.dbo.AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@UserID,@RedPacketID,@RedPacket)
		END

		-- 背包记录
		SET @RecordNote = N'充值 ' + CONVERT(NVARCHAR,@PayAmount) + N' 元礼包赠送红包'
		INSERT THAccountsDBLink.THAccountsDB.dbo.PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@UserID,2,@RedPacketID,@RedPacket,@RecordNote)
	END

	-- 赠送抽奖卡
	IF @Lottery<>0
	BEGIN
		DECLARE @LotteryID INT
		SET @LotteryID=801

		-- 更新背包
		UPDATE THAccountsDBLink.THAccountsDB.dbo.AccountsPackage SET GoodsCount=GoodsCount+@Lottery WHERE UserID=@UserID AND GoodsID=@LotteryID
		IF @@ROWCOUNT=0
		BEGIN
			INSERT THAccountsDBLink.THAccountsDB.dbo.AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@UserID,@LotteryID,@Lottery)
		END

		-- 背包记录
		SET @RecordNote = N'充值 ' + CONVERT(NVARCHAR,@PayAmount) + N' 元礼包赠送抽奖卡'
		INSERT THAccountsDBLink.THAccountsDB.dbo.PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@UserID,2,@LotteryID,@Lottery,@RecordNote)
	END

	-- 赠送话费
	IF @PackageFee<>0
	BEGIN
		DECLARE @PackageFeeID INT
		SET @PackageFeeID=301

		-- 更新背包
		UPDATE THAccountsDBLink.THAccountsDB.dbo.AccountsPackage SET GoodsCount=GoodsCount+@PackageFee WHERE UserID=@UserID AND GoodsID=@PackageFeeID
		IF @@ROWCOUNT=0
		BEGIN
			INSERT THAccountsDBLink.THAccountsDB.dbo.AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@UserID,@PackageFeeID,@PackageFee)
		END

		-- 背包记录
		SET @RecordNote = N'充值 ' + CONVERT(NVARCHAR,@PayAmount) + N' 元礼包赠送话费'
		INSERT THAccountsDBLink.THAccountsDB.dbo.PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@UserID,2,@PackageFeeID,@PackageFee,@RecordNote)
	END
	--------------------------------------------------------------------------------

	-- 电话充值，货币减半
--	IF @isVB = 1
--	BEGIN
--		SET @Currency = @Currency/2
--	END
	
	UPDATE UserCurrencyInfo SET Currency=Currency+@Currency WHERE UserID=@UserID
	IF (SELECT COUNT(*) FROM UserCurrencyInfo WHERE UserID=@UserID)=0
	BEGIN
		INSERT UserCurrencyInfo(UserID,Currency) VALUES(@UserID,@Currency)
	END
	
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
	UPDATE OnLineOrder SET OrderStatus=2,Currency=@Currency,PayAmount=@PayAmount
	WHERE OrderID=@OrderID

	--------------------------------------------------------------------------------

	-- 推广系统
	DECLARE @SpreaderID INT	
	SELECT @SpreaderID=SpreaderID FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo
	WHERE UserID = @UserID
	IF @SpreaderID<>0
	BEGIN
		DECLARE @SpreadRate DECIMAL(18,2)
		DECLARE @GrantScore BIGINT
		DECLARE @Note NVARCHAR(512)
		-- 推广分成
		SELECT @SpreadRate=FillGrantRate FROM GlobalSpreadInfo
		IF @SpreadRate IS NULL
		BEGIN
			SET @SpreadRate=0.1
		END
		-- 货币与金币的汇率
		DECLARE @GoldRate INT
		SELECT @GoldRate=StatusValue FROM THAccountsDBLink.THAccountsDB.dbo.SystemStatusInfo WHERE StatusString='RateGold'
		IF @GoldRate=0 OR @GoldRate IS NULL
			SET @GoldRate=1
		SET @GrantScore = @Currency*@GoldRate*@SpreadRate
		SET @Note = N'充值'+LTRIM(STR(@PayAmount))+'元'
		INSERT INTO RecordSpreadInfo(UserID,Score,TypeID,ChildrenID,CollectNote)
		VALUES(@SpreaderID,@GrantScore,3,@UserID,@Note)		
	END

	-- 记录日志
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)

	UPDATE StreamShareInfo
	SET ShareTotals=ShareTotals+1
	WHERE DateID=@DateID AND ShareID=@ShareID

	IF @@ROWCOUNT=0
	BEGIN
		INSERT StreamShareInfo(DateID,ShareID,ShareTotals)
		VALUES (@DateID,@ShareID,1)
	END
	
	--------------------------------------------------------------------------------

	-- 兑换金币
	IF @CurrencyType=5
	BEGIN
		DECLARE @CurrentBeans DECIMAL(18,2)
		DECLARE @ConvertGold BIGINT
		DECLARE @InsureScore BIGINT
		DECLARE @ConvertRate INT

		-- 查询游戏豆
		SELECT @CurrentBeans=Currency FROM UserCurrencyInfo WHERE UserID=@UserID
		IF @CurrentBeans IS NULL
		BEGIN
			SET @CurrentBeans=0
		END

		-- 查询银行
		SELECT @InsureScore=InsureScore FROM GameScoreInfo WHERE UserID=@UserID
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
		VALUES(@UserID,@InsureScore,@CurrentBeans,@Currency,@ConvertRate,1,@strIPAddress)
		
		-- 兑换金币
		SET @ConvertGold=Convert(BIGINT,@Currency*@ConvertRate)
		UPDATE GameScoreInfo SET Score=Score+@ConvertGold WHERE UserID=@UserID
		IF @@ROWCOUNT=0
		BEGIN
			INSERT INTO GameScoreInfo(UserID,Score,RegisterIP,LastLogonIP) VALUES (@UserID,@ConvertGold,@strIPAddress,@strIPAddress)
		END

		-- 更新游戏豆
		UPDATE UserCurrencyInfo SET Currency=Currency-@Currency WHERE UserID=@UserID
	END

	--------------------------------------------------------------------------------
	
	-- 任务推进
	EXEC THAccountsDBLink.THAccountsDB.dbo.GSP_MB_TaskForward @UserID,3006,0,1,0,0
END

RETURN 0


--------------------------------------------------------------------------------

