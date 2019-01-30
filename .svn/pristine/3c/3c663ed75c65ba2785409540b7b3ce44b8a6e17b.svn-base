----------------------------------------------------------------------------------------------------
-- 版权：2017
-- 时间：2017-06-26
-- 用途：背包管理
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_QueryPackage]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_QueryPackage]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_OpenBox]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_OpenBox]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_ExchangeFee]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_ExchangeFee]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_ExchangeCurrency]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_ExchangeCurrency]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_PackageLottery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_PackageLottery]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_LoadLotteryConfig]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_LoadLotteryConfig]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_QueryLottery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_QueryLottery]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_OpenPacks]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_OpenPacks]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_RookiePacksTake]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_RookiePacksTake]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 查询背包
CREATE PROCEDURE GSP_MB_QueryPackage
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)

	-- 查询密码
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

	-- 账户判断
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的账户信息有误，请查证后再次尝试！'
		RETURN 1
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的密码输入有误，请查证后再次尝试！'
		RETURN 2
	END

	-- 删除物品
	DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsCount=0

	-- 输出变量
	SELECT A.GoodsID,GoodsName,GoodsType,GoodsPrice,LimitCount,GoodsCount FROM AccountsPackage A,PackageGoodsInfo (NOLOCK) B 
	WHERE A.GoodsID=B.GoodsID AND B.Nullity=0 AND A.UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 开启宝箱
CREATE PROC GSP_MB_OpenBox
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@dwGoodsID INT,								-- 物品 I D
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @Beans AS DECIMAL(18, 2)
	DECLARE @GoodsName AS NVARCHAR(31)
	DECLARE @GoodsType AS TINYINT
	DECLARE @GoodsPrice AS DECIMAL(18, 2)
	DECLARE @GoodsCount AS INT

	-- 查询密码
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

	-- 账户判断
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的账户信息有误，请查证后再次尝试！'
		RETURN 1
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的密码输入有误，请查证后再次尝试！'
		RETURN 2
	END

	-- 查询锁定
	DECLARE @LockKindID INT
	DECLARE @LockServerID INT
	SELECT @LockKindID=KindID, @LockServerID=ServerID FROM THTreasureDBLink.THTreasureDB.dbo.GameScoreLocker WHERE UserID=@dwUserID

	-- 锁定判断
	IF @LockKindID IS NOT NULL AND @LockServerID IS NOT NULL
	BEGIN
		-- 查询信息
		DECLARE @KindName NVARCHAR(31)
		DECLARE @ServerName NVARCHAR(31)
		SELECT @KindName=KindName FROM THPlatformDBLink.THPlatformDB.dbo.GameKindItem WHERE KindID=@LockKindID
		SELECT @ServerName=ServerName FROM THPlatformDBLink.THPlatformDB.dbo.GameRoomInfo WHERE ServerID=@LockServerID

		-- 错误信息
		IF @KindName IS NULL SET @KindName=N'未知游戏'
		IF @ServerName IS NULL SET @ServerName=N'未知房间'
		SET @strErrorDescribe=N'您正在 [ '+@KindName+N' ] 的 [ '+@ServerName+N' ] 游戏房间中，不能进行当前操作！'
		RETURN 3
	END

	-- 查询宝石
	SELECT @Beans=Currency FROM THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo WHERE UserID=@dwUserID

	-- 查询物品
	SELECT @GoodsName=GoodsName,@GoodsType=GoodsType,@GoodsPrice=GoodsPrice 
	FROM PackageGoodsInfo (NOLOCK) WHERE Nullity=0 AND GoodsID=@dwGoodsID

	-- 查询数量
	SELECT @GoodsCount=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- 数据调整
	IF @Beans IS NULL SET @Beans=0
	IF @GoodsCount IS NULL SET @GoodsCount=0

	-- 物品判断
	IF @GoodsName IS NULL OR @GoodsType IS NULL OR @GoodsPrice IS NULL OR @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'您操作的物品不存在，请查证后再次尝试！'
		RETURN 4
	END

	-- 类型判断
	IF @GoodsType<>2
	BEGIN
		SET @strErrorDescribe=N'您操作的物品类型非宝箱类型物品，请查证后再次尝试！'
		RETURN 5
	END

	-- 价格判断
	IF @Beans<@GoodsPrice
	BEGIN
		SET @strErrorDescribe=N'您的钻石数量不足 ' + CONVERT(NVARCHAR,@GoodsPrice) + N' 个，请进入游戏充值页面进行充值！'
		RETURN 6
	END
	
--测试定义
--DECLARE @dwUserID AS INT
--DECLARE @dwGoodsID AS INT
--SET @dwUserID=15024
--SET @dwGoodsID=202

	-- 变量定义
	DECLARE @RandRange AS INT
	DECLARE @MaxRange AS INT
	DECLARE @dwLuckyGoodsID AS INT
	DECLARE @dwLuckyGoodsCount AS INT
	DECLARE @RechargeAmount AS DECIMAL(18, 2)
	DECLARE @RewardLimit AS INT
	DECLARE @OpenBoxCount AS INT
	DECLARE @PackageFee AS INT
	DECLARE @ExchangeFee AS INT
	DECLARE @FeeGoodsID AS INT
	
	-- 充值金额
	SELECT @RechargeAmount=ISNULL(SUM(PayAmount),0) FROM THTreasureDBLink.THTreasureDB.dbo.ShareDetailInfo WHERE UserID=@dwUserID

	declare @isUse int
	select @isUse=isUse  FROM [THPlatformDB].[dbo].[SelectPlatform](nolock) where ID = 1
	if @isUse is null set @isUse = 0

	-- 奖励限制
	SELECT TOP 1 @RewardLimit=RewardLimit FROM RewardLimit WHERE RechargeAmount<=@RechargeAmount and isUse = @isUse ORDER BY RewardLimit DESC

	-- 奖励限制
	SET @FeeGoodsID=301
	IF @RewardLimit IS NULL SET @RewardLimit=36

	-- 开箱次数
	SELECT @OpenBoxCount=COUNT(*) FROM PackageRecord WHERE UserID=@dwUserID AND RecordType=1 AND GoodsID=@dwGoodsID

	-- 背包话费
	SELECT @PackageFee=ISNULL(SUM(GoodsCount),0) FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@FeeGoodsID

	-- 兑换话费
	SELECT @ExchangeFee=ISNULL(SUM(GoodsCount),0) FROM PackageExchangeFee WHERE UserID=@dwUserID AND GoodsID=@FeeGoodsID

	-- 数据调整
	IF @OpenBoxCount IS NULL SET @OpenBoxCount=0
	IF @PackageFee IS NULL SET @PackageFee=0
	IF @ExchangeFee IS NULL SET @ExchangeFee=0

	-- 条件判断
	IF @OpenBoxCount=0 AND (@PackageFee+@ExchangeFee+10<@RewardLimit) and @isUse = 0
	BEGIN
		-- 黄金宝箱首次必中五元话费
		IF @dwGoodsID=201 
		BEGIN
			SET @dwLuckyGoodsID=@FeeGoodsID
			SET @dwLuckyGoodsCount=5
		END

		-- 钻石宝箱首次必中十元话费
		ELSE IF @dwGoodsID=202 
		BEGIN
			SET @dwLuckyGoodsID=@FeeGoodsID
			SET @dwLuckyGoodsCount=10
		END
	END
	ELSE
	BEGIN
		-- 随机上限
		SELECT @MaxRange=MAX(RangeEnd) FROM PackageBoxConfig WHERE GoodsID=@dwGoodsID and isUse = @isUse
		WHILE 1=1
		BEGIN
			-- 随机数据
			SET @RandRange=CAST(CEILING(RAND()*@MaxRange) AS INT)

			-- 中奖物品
			SELECT @dwLuckyGoodsID=LuckyGoodsID,@dwLuckyGoodsCount=LuckyGoodsCount FROM PackageBoxConfig 
			WHERE GoodsID=@dwGoodsID AND @RandRange>=RangeStart AND @RandRange<=RangeEnd and isUse = @isUse
			
			-- 话费上限
			IF @dwLuckyGoodsID=@FeeGoodsID AND @PackageFee+@ExchangeFee+@dwLuckyGoodsCount>=@RewardLimit
			BEGIN
				CONTINUE
			END

			BREAK
		END
	END

	-- 数据调整
	IF @dwLuckyGoodsID IS NULL OR @dwLuckyGoodsCount IS NULL
	BEGIN
		SET @dwLuckyGoodsID=501
		SET @dwLuckyGoodsCount=20000		--THAccountsDB.dbo.PackagePacksConfig.PacksGoodsCount 701,501,20000
		-- return 1
	END

	-- 更新宝石
	UPDATE THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo SET Currency=Currency-@GoodsPrice WHERE UserID=@dwUserID

	-- 更新宝箱
	UPDATE AccountsPackage SET GoodsCount=GoodsCount-1 WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	IF @dwLuckyGoodsID<>501
	BEGIN
		-- 更新物品
		UPDATE AccountsPackage SET GoodsCount=GoodsCount+@dwLuckyGoodsCount WHERE UserID=@dwUserID AND GoodsID=@dwLuckyGoodsID

		-- 插入物品
		IF @@ROWCOUNT=0
		BEGIN
			INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@dwLuckyGoodsID,@dwLuckyGoodsCount)
		END
	END

	-- 背包记录
	DECLARE @RecordNote AS NVARCHAR(32)
	SET @RecordNote = N'开启 ' + @GoodsName + N' 获得'
	-- IF @dwLuckyGoodsID<>501
	-- BEGIN
		INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@dwUserID,2,@dwLuckyGoodsID,@dwLuckyGoodsCount,@RecordNote)
	-- END
	INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@dwGoodsID,1)

	-- 删除物品
	DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsCount=0

	if @dwLuckyGoodsID= 501 and @dwLuckyGoodsCount > 0
	begin
		update [THTreasureDB].[dbo].[GameScoreInfo] set score=score+@dwLuckyGoodsCount where userid = @dwUserID
		INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@dwLuckyGoodsID,@dwLuckyGoodsCount)
	end
	-- 任务类型
	DECLARE @wKindID INT
	IF @dwGoodsID=201 SET @wKindID=3004
	ELSE IF @dwGoodsID=202 SET @wKindID=3005
	ELSE SET @wKindID=0

	-- 任务推进
	IF @wKindID<>0
	BEGIN
		EXEC GSP_MB_TaskForward @dwUserID,@wKindID,0,1,0,0
	END

	-- 输出变量 dwGoodsID是消耗宝箱id,dwGoodCt 是消耗宝箱数量
	SELECT GoodsID,GoodsName,GoodsType,@dwLuckyGoodsCount AS GoodsCount,@dwGoodsID as dwGoodsID,1 as dwGoodCt  FROM PackageGoodsInfo WHERE Nullity=0 AND GoodsID=@dwLuckyGoodsID
	
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------

-- 兑换话费
CREATE PROC GSP_MB_ExchangeFee
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@dwGoodsID INT,								-- 物品 I D
	@szMobilePhone NVARCHAR(11),				-- 移动电话
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsType AS TINYINT
	DECLARE @LimitCount AS INT
	DECLARE @GoodsCount AS INT

	-- 查询密码
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

	-- 账户判断
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的账户信息有误，请查证后再次尝试！'
		RETURN 1
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的密码输入有误，请查证后再次尝试！'
		RETURN 2
	END

	-- 查询物品
	SELECT @GoodsType=GoodsType,@LimitCount=LimitCount FROM PackageGoodsInfo (NOLOCK) WHERE Nullity=0 AND GoodsID=@dwGoodsID

	-- 查询数量
	SELECT @GoodsCount=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- 数据调整
	IF @LimitCount IS NULL SET @LimitCount=0
	IF @GoodsCount IS NULL SET @GoodsCount=0

	-- 物品判断
	IF @GoodsType IS NULL OR @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'您操作的物品不存在，请查证后再次尝试！'
		RETURN 3
	END

	-- 类型判断
	IF @GoodsType<>3
	BEGIN
		SET @strErrorDescribe=N'您操作的物品类型非话费类型物品，请查证后再次尝试！'
		RETURN 4
	END

	-- 兑换条件
	IF @GoodsCount<@LimitCount OR @LimitCount=0
	BEGIN
		SET @strErrorDescribe=N'您兑换的话费卡数量不足 ' + CONVERT(NVARCHAR,@LimitCount) + N' 元，请集齐后再进行兑换！'
		RETURN 5
	END

	-- 手机判断
	IF LEN(@szMobilePhone)<>11
	BEGIN
		SET @strErrorDescribe=N'您的手机号码输入有误，请查证后再次尝试！'
		RETURN 6
	END

	-- 更新物品
	UPDATE AccountsPackage SET GoodsCount=GoodsCount-@LimitCount WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- 背包记录
	INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@dwGoodsID,@LimitCount)

	-- 兑换记录
	INSERT PackageExchangeFee(UserID,MobilePhone,GoodsID,GoodsCount) VALUES (@dwUserID,@szMobilePhone,@dwGoodsID,@LimitCount)

	-- 删除物品
	DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsCount=0

	-- 设置信息
	SET @strErrorDescribe=N'话费兑换成功，将于3-5个工作日内到账！'

	select @dwGoodsID as dwGoodsID,@GoodsCount as GoodsCount
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 兑换货币
CREATE PROC GSP_MB_ExchangeCurrency
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 财富变量
DECLARE @Score BIGINT
DECLARE @Beans DECIMAL(18, 2)

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @BeansGoodsID AS INT
	DECLARE @ScoreGoodsID AS INT
	DECLARE @BeansGoodsCount AS INT
	DECLARE @ScoreGoodsCount AS INT

	-- 查询密码
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

	-- 账户判断
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的账户信息有误，请查证后再次尝试！'
		RETURN 1
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的密码输入有误，请查证后再次尝试！'
		RETURN 2
	END

	-- 查询宝石
	SET @BeansGoodsID=401
	SELECT @BeansGoodsCount=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@BeansGoodsID

	-- 兑换宝石
	IF @BeansGoodsCount IS NOT NULL
	BEGIN
		-- 更新宝石
		UPDATE THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo SET Currency=Currency+@BeansGoodsCount WHERE UserID=@dwUserID

		-- 插入宝石
		IF @@ROWCOUNT=0
		BEGIN
			INSERT THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo(UserID,Currency) VALUES (@dwUserID,@BeansGoodsCount)
		END

		-- 删除物品
		DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@BeansGoodsID

		-- 背包记录
		INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@BeansGoodsID,@BeansGoodsCount)
	END

	-- 查询金币
	SET @ScoreGoodsID=501
	SELECT @ScoreGoodsCount=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@ScoreGoodsID

	-- 兑换金币
	IF @ScoreGoodsCount IS NOT NULL
	BEGIN
		-- 更新金币
		UPDATE THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo SET Score=Score+@ScoreGoodsCount WHERE UserID=@dwUserID

		-- 插入金币
		IF @@ROWCOUNT=0
		BEGIN
			INSERT THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo(UserID,Score) VALUES (@dwUserID,@ScoreGoodsCount)
		END

		-- 删除物品
		DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@ScoreGoodsID

		-- 背包记录
		INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@ScoreGoodsID,@ScoreGoodsCount)
	END
	
	-- 查询分数
	SELECT @Score=Score FROM THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID

	-- 查询宝石
	SELECT @Beans=Currency FROM THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo WHERE UserID=@dwUserID

	-- 数据调整
	IF @Score IS NULL SET @Score=0
	IF @Beans IS NULL SET @Beans=0

	-- 输出变量
	SELECT @Score AS Score, @Beans AS Beans
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 背包抽奖
CREATE PROC GSP_MB_PackageLottery
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@dwGoodsID INT,								-- 物品 I D
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsType AS TINYINT
	DECLARE @GoodsName AS NVARCHAR(31)
	DECLARE @GoodsCount AS INT

	-- 查询密码
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

	-- 账户判断
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的账户信息有误，请查证后再次尝试！'
		RETURN 1
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的密码输入有误，请查证后再次尝试！'
		RETURN 2
	END

	-- 查询物品
	SELECT @GoodsName=GoodsName,@GoodsType=GoodsType FROM PackageGoodsInfo (NOLOCK) WHERE Nullity=0 AND GoodsID=@dwGoodsID

	-- 查询数量
	SELECT @GoodsCount=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- 数据调整
	IF @GoodsCount IS NULL OR @GoodsCount<0 SET @GoodsCount=0

	-- 物品判断
	IF @GoodsCount<10
	BEGIN
		SET @strErrorDescribe=N'您的奖券不足10张！'
		RETURN 3
	END

	-- 物品判断
	IF @GoodsName IS NULL OR @GoodsType IS NULL OR @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'您操作的物品不存在，请查证后再次尝试！'
		RETURN 3
	END

	-- 类型判断
	IF @GoodsType<>8
	BEGIN
		SET @strErrorDescribe=N'您操作的物品类型非抽奖类型物品，请查证后再次尝试！'
		RETURN 4
	END

--测试定义
--DECLARE @dwUserID AS INT
--DECLARE @dwGoodsID AS INT
--SET @dwUserID=15024
--SET @dwGoodsID=202

	-- 变量定义
	DECLARE @RandRange AS INT
	DECLARE @MaxRange AS INT
	DECLARE @ItemIndex AS INT
	DECLARE @dwLuckyGoodsID AS INT
	DECLARE @dwLuckyGoodsCount AS INT
	DECLARE @RechargeAmount AS DECIMAL(18, 2)
	DECLARE @RewardLimit AS INT
	DECLARE @PackageFee AS INT
	DECLARE @ExchangeFee AS INT
	DECLARE @TotalScore AS BIGINT
	DECLARE @FeeGoodsID AS INT
	DECLARE @ScoreGoodsID AS INT
	DECLARE @LotteryTimes AS INT
	
	-- 充值金额
	SELECT @RechargeAmount=ISNULL(SUM(PayAmount),0) FROM THTreasureDBLink.THTreasureDB.dbo.ShareDetailInfo WHERE UserID=@dwUserID

	-- 奖励限制
	SELECT TOP 1 @RewardLimit=RewardLimit FROM RewardLimit WHERE RechargeAmount<=@RechargeAmount ORDER BY RewardLimit DESC

	-- 奖励限制
	SET @FeeGoodsID=301
	IF @RewardLimit IS NULL SET @RewardLimit=36

	-- 背包话费
	SELECT @PackageFee=ISNULL(SUM(GoodsCount),0) FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@FeeGoodsID

	-- 兑换话费
	SELECT @ExchangeFee=ISNULL(SUM(GoodsCount),0) FROM PackageExchangeFee WHERE UserID=@dwUserID AND GoodsID=@FeeGoodsID

	-- 玩家金币
	SET @ScoreGoodsID=501
	SELECT @TotalScore=Score+InsureScore FROM THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID

	-- 数据调整
	IF @PackageFee IS NULL SET @PackageFee=0
	IF @ExchangeFee IS NULL SET @ExchangeFee=0
	IF @TotalScore IS NULL SET @TotalScore=0

	-- 随机上限
	SELECT @MaxRange=MAX(RangeEnd) FROM LotteryConfig
	WHILE 1=1
	BEGIN
		-- 随机数据
		SET @RandRange=CAST(CEILING(RAND()*@MaxRange) AS INT)

		-- 中奖物品
		SELECT @ItemIndex=ItemIndex,@dwLuckyGoodsID=LuckyGoodsID,@dwLuckyGoodsCount=LuckyGoodsCount FROM LotteryConfig 
		WHERE @RandRange>=RangeStart AND @RandRange<=RangeEnd
		
		-- 话费上限
		IF @dwLuckyGoodsID=@FeeGoodsID AND @PackageFee+@ExchangeFee+@dwLuckyGoodsCount>=@RewardLimit
		BEGIN
			CONTINUE
		END

		-- 话费必中
		IF @TotalScore>10000 AND @dwLuckyGoodsID<>@FeeGoodsID AND @PackageFee+@ExchangeFee<=10
		BEGIN
			CONTINUE
		END

		-- 金币限制
		IF @TotalScore<3000 AND @dwLuckyGoodsID<>@ScoreGoodsID
		BEGIN
			CONTINUE
		END

		-- 金币限制
		IF @TotalScore>20000 AND @dwLuckyGoodsID=@ScoreGoodsID
		BEGIN
			CONTINUE
		END

		BREAK
	END

	-- 数据调整
	IF @ItemIndex IS NULL OR @dwLuckyGoodsID IS NULL OR @dwLuckyGoodsCount IS NULL
	BEGIN
		SET @ItemIndex=2
		SET @dwLuckyGoodsID=501
		SET @dwLuckyGoodsCount=2888
	END

--测试输出
--SELECT @RandRange,@dwLuckyGoodsID,@dwLuckyGoodsCount

	-- 更新抽奖
	UPDATE AccountsPackage SET GoodsCount=GoodsCount-10 WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- 更新物品
	UPDATE AccountsPackage SET GoodsCount=GoodsCount+@dwLuckyGoodsCount WHERE UserID=@dwUserID AND GoodsID=@dwLuckyGoodsID

	-- 插入物品
	IF @@ROWCOUNT=0
	BEGIN
		INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@dwLuckyGoodsID,@dwLuckyGoodsCount)
	END

	-- 背包记录
	DECLARE @RecordNote AS NVARCHAR(32)
	SET @RecordNote = N'使用 ' + @GoodsName + N' 获得'
	INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@dwGoodsID,1)
	INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@dwUserID,2,@dwLuckyGoodsID,@dwLuckyGoodsCount,@RecordNote)

	-- 删除物品
	DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsCount=0
	
	-- 抽奖次数
	SELECT @LotteryTimes=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID
	
	-- 数据调整
	IF @LotteryTimes IS NULL SET @LotteryTimes=0

	-- 输出变量
	SELECT @LotteryTimes AS LotteryTimes,@ItemIndex AS ItemIndex,GoodsID,GoodsName,GoodsType,@dwLuckyGoodsCount AS GoodsCount,
	@GoodsCount as consumeGoodsCount,@dwGoodsID as consumedwGoodsID
	FROM PackageGoodsInfo WHERE Nullity=0 AND GoodsID=@dwLuckyGoodsID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 抽奖配置
CREATE PROC GSP_MB_LoadLotteryConfig
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	-- 输出变量
	SELECT ItemIndex,LuckyGoodsID AS GoodsID,LuckyGoodsCount AS GoodsCount FROM LotteryConfig
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 查询抽奖
CREATE PROC GSP_MB_QueryLottery
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)

	-- 查询密码
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

	-- 账户判断
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的账户信息有误，请查证后再次尝试！'
		RETURN 1
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的密码输入有误，请查证后再次尝试！'
		RETURN 2
	END

	DECLARE @TakeDateTime AS DATETIME
	DECLARE @LotteryTimes AS INT
	DECLARE @GoodsID AS INT
	DECLARE @GoodsCount AS INT
	
	-- 设置物品
	SET @GoodsID=801
	SET @GoodsCount=10
	
	-- 领取时间
	SELECT @TakeDateTime=TakeDateTime FROM AccountsLottery WHERE UserID=@dwUserID

	-- 首次领取
	IF @TakeDateTime IS NULL
	BEGIN
		INSERT AccountsLottery(UserID,TakeDateTime) VALUES (@dwUserID,GetDate())

		-- 更新物品
		UPDATE AccountsPackage SET GoodsCount=GoodsCount+@GoodsCount WHERE UserID=@dwUserID AND GoodsID=@GoodsID

		-- 插入物品
		IF @@ROWCOUNT=0
		BEGIN
			INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@GoodsID,@GoodsCount)
		END

--		-- 更新宝石
--		UPDATE THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo SET Currency=Currency+1000 WHERE UserID=@dwUserID
--
--		-- 插入宝石
--		IF @@ROWCOUNT=0
--		BEGIN
--			INSERT THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo(UserID,Currency) VALUES (@dwUserID,1000)
--		END

		-- 更新金币
		UPDATE THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo SET Score=Score WHERE UserID=@dwUserID

		-- 插入金币
		IF @@ROWCOUNT=0
		BEGIN
			INSERT THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo(UserID,Score) VALUES (@dwUserID,0)
		END
	END
	ELSE
	BEGIN
		-- 领取判断
		IF DateDiff(dd,@TakeDateTime,GetDate())<>0
		BEGIN
			UPDATE AccountsLottery SET TakeDateTime=GetDate() WHERE UserID=@dwUserID

			-- 更新物品
			UPDATE AccountsPackage SET GoodsCount=GoodsCount+@GoodsCount WHERE UserID=@dwUserID AND GoodsID=@GoodsID

			-- 插入物品
			IF @@ROWCOUNT=0
			BEGIN
				INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@GoodsID,@GoodsCount)
			END
		END
	END

	-- 查询数量
	SELECT @LotteryTimes=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@GoodsID
	
	-- 数据调整
	IF @LotteryTimes IS NULL SET @LotteryTimes=0

	-- 输出变量
	SELECT @LotteryTimes AS LotteryTimes
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 打开礼包
CREATE PROC GSP_MB_OpenPacks
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@dwGoodsID INT,								-- 物品 I D
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsName AS NVARCHAR(31)
	DECLARE @GoodsType AS TINYINT
	DECLARE @GoodsCount AS INT

	-- 查询密码
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

	-- 账户判断
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的账户信息有误，请查证后再次尝试！'
		RETURN 1
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的密码输入有误，请查证后再次尝试！'
		RETURN 2
	END

	-- 查询物品
	SELECT @GoodsName=GoodsName,@GoodsType=GoodsType FROM PackageGoodsInfo (NOLOCK) WHERE Nullity=0 AND GoodsID=@dwGoodsID

	-- 查询数量
	SELECT @GoodsCount=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- 数据调整
	IF @GoodsCount IS NULL SET @GoodsCount=0

	-- 物品判断
	IF @GoodsName IS NULL OR @GoodsType IS NULL OR @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'您操作的物品不存在，请查证后再次尝试！'+@GoodsName+N'_'+CAST(@GoodsType AS VARCHAR(100))+N'_'+CAST(@GoodsCount AS VARCHAR(100))+N'_'+CAST(@dwUserID AS VARCHAR(100))
		RETURN 3
	END

	-- 类型判断
	IF @GoodsType<>7
	BEGIN
		SET @strErrorDescribe=N'您操作的物品类型非礼包类型物品，请查证后再次尝试！'
		RETURN 4
	END

	DECLARE @dwPacksGoodsID AS INT
	DECLARE @dwPacksGoodsCount AS INT
	DECLARE @i INT
	DECLARE @count INT
	
	-- 更新礼包
	UPDATE AccountsPackage SET GoodsCount=GoodsCount-1 WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- 背包记录
	INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@dwGoodsID,1)

	declare @isUse int
	select @isUse=isUse  FROM [THPlatformDB].[dbo].[SelectPlatform](nolock) where ID = 1
	if @isUse is null set @isUse = 0

	-- 循环礼包
	SET @i = 1
	SELECT @count = COUNT(*) FROM PackagePacksConfig WHERE GoodsID=@dwGoodsID and isUse = @isUse
	WHILE (@i <= @count)
	BEGIN
		-- 礼包物品
		SELECT @dwPacksGoodsID=PacksGoodsID,@dwPacksGoodsCount=PacksGoodsCount FROM (SELECT ROW_NUMBER() OVER 
		(ORDER BY PacksGoodsID) AS RowNumber,PacksGoodsID,PacksGoodsCount FROM PackagePacksConfig WHERE GoodsID=@dwGoodsID and isUse = @isUse) A WHERE A.RowNumber = @i

		-- 更新物品
		UPDATE AccountsPackage SET GoodsCount=GoodsCount+@dwPacksGoodsCount WHERE UserID=@dwUserID AND GoodsID=@dwPacksGoodsID

		-- 插入物品
		IF @@ROWCOUNT=0
		BEGIN
			INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@dwPacksGoodsID,@dwPacksGoodsCount)
		END


		IF @dwPacksGoodsID=501
		BEGIN
			DECLARE @dwPacksGoodsCountTmp AS INT
			SET @dwPacksGoodsCountTmp=NULL
			SELECT @dwPacksGoodsCountTmp=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwPacksGoodsID

			IF @dwPacksGoodsCountTmp IS NOT NULL
			BEGIN
				-- 更新金币
				UPDATE THTreasureDB.dbo.GameScoreInfo SET Score=Score+@dwPacksGoodsCountTmp WHERE UserID=@dwUserID

				-- 插入金币
				IF @@ROWCOUNT=0
				BEGIN
					INSERT THTreasureDB.dbo.GameScoreInfo(UserID,Score) VALUES (@dwUserID,@dwPacksGoodsCountTmp)
				END
				-- 删除物品
				DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwPacksGoodsID
			END
		END


		-- 背包记录
		DECLARE @RecordNote AS NVARCHAR(32)
		SET @RecordNote = N'打开 ' + @GoodsName + N' 获得'
		INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@dwUserID,2,@dwPacksGoodsID,@dwPacksGoodsCount,@RecordNote)

		SET @i=@i+1
	END

	-- 删除物品
	DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsCount=0

	-- 输出变量
	SELECT @dwGoodsID AS PacksID,B.GoodsID AS GoodsID,B.GoodsName AS GoodsName,B.GoodsType AS GoodsType,A.PacksGoodsCount AS GoodsCount,1 as consumeGoodsCt
	FROM PackagePacksConfig A,PackageGoodsInfo (NOLOCK) B WHERE A.PacksGoodsID=B.GoodsID AND B.Nullity=0 AND A.GoodsID=@dwGoodsID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 领取礼包
CREATE PROC GSP_MB_RookiePacksTake
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)

	-- 查询密码
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

	-- 账户判断
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的账户信息有误，请查证后再次尝试！'
		RETURN 1
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的密码输入有误，请查证后再次尝试！'
		RETURN 2
	END

	DECLARE @TakeStatus AS TINYINT
	DECLARE @GoodsID AS INT
	DECLARE @GoodsCount AS INT
	SET @GoodsID=701
	SET @GoodsCount=1

	-- 领取状态
	IF EXISTS (SELECT * FROM RookiePacks WHERE UserID=@dwUserID)
	BEGIN
		SET @TakeStatus=1
	END
	ELSE
	BEGIN
		SET @TakeStatus=0
		
		-- 更新物品
		UPDATE AccountsPackage SET GoodsCount=GoodsCount+@GoodsCount WHERE UserID=@dwUserID AND GoodsID=@GoodsID

		-- 插入物品
		IF @@ROWCOUNT=0
		BEGIN
			INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@GoodsID,@GoodsCount)
		END

		-- 写入记录
		INSERT RookiePacks(UserID) VALUES (@dwUserID)

		-- 背包记录
		INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@dwUserID,2,@GoodsID,@GoodsCount,N'领取新手礼包')
	END

	-- 输出变量
	SELECT @TakeStatus AS TakeStatus,GoodsID,GoodsName,GoodsType,@GoodsCount AS GoodsCount 
	FROM PackageGoodsInfo WHERE Nullity=0 AND GoodsID=@GoodsID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------