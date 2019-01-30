----------------------------------------------------------------------------------------------------
-- 版权：2017
-- 时间：2017-08-07
-- 用途：红包管理
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_RedPacketConfig]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_RedPacketConfig]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_QueryRedPacket]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_QueryRedPacket]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_RedPacketLottery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_RedPacketLottery]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_AliPayQuery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_AliPayQuery]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_AliPayUpdate]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_AliPayUpdate]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO


----------------------------------------------------------------------------------------------------

-- 红包配置
CREATE PROC GSP_MB_RedPacketConfig
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	declare @isUse int
	select @isUse=isUse  FROM [THPlatformDB].[dbo].[SelectPlatform](nolock) where ID = 1 
	if @isUse is null set @isUse = 0
	-- 输出变量
	SELECT ItemIndex,LuckyGoodsID AS GoodsID,LuckyGoodsCount AS GoodsCount FROM RedPacketConfig where isUse = @isUse
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 查询红包
CREATE PROC GSP_MB_QueryRedPacket
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
	-- 查询消耗
	DECLARE @Consume AS DECIMAL(18, 2)
	SELECT @Consume=Consume FROM RedPacketStorage WHERE Nullity=0

	-- 数据调整
	IF @Consume IS NULL SET @Consume=0
	
	-- 输出变量
	SELECT @Consume AS Consume
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 红包抽奖
create PROC GSP_MB_RedPacketLottery
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@wLotteryNum INT,							-- 抽奖次数
	@UseCharm TINYINT,							-- =1,魅力值抽奖
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @Beans AS DECIMAL(18, 2)
	DECLARE @Consume AS DECIMAL(18, 2)
	DECLARE @Deduct AS DECIMAL(18, 2)
	DECLARE @Storage AS DECIMAL(18, 2)


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

	
	-- 查询配置
	SELECT @Consume=Consume,@Deduct=Deduct,@Storage=Storage FROM RedPacketStorage WHERE Nullity=0

	-- 配置判断
	IF @Consume IS NULL OR @Deduct IS NULL OR @Storage IS NULL
	BEGIN
		SET @strErrorDescribe=N'抽奖配置信息有误，请联系客服解决！'
		RETURN 4
	END

	-- 查询当天用魅力值转红包转盘的次数
	declare @todays date
	declare @cts int
	declare @charm int
	declare @ischarm int
	set @ischarm = 1
	set @todays = convert(varchar,getdate(),23)
	select @cts = counts FROM LuckDraw(nolock) where [UserID] = @dwUserID and [dates] = @todays
	declare @gcts int 
	select @gcts=GoodsCount  FROM AccountsPackage(nolock) where [UserID] = @dwUserID and [GoodsID] = 1001
	if @gcts is null set @gcts = 0
	if @cts is null set @cts = 0
	-- if @cts < 3 and @gcts > 0
	if @UseCharm = 1
	begin
		-- 查询魅力值
		if @cts >= 3
		begin
			SET @strErrorDescribe=N'今日三次已用完，请明日再来！'
			RETURN 7
		end

		if @gcts = 0
		begin
			SET @strErrorDescribe=N'魅力值不足,请用钻石抽奖！'
			RETURN 8
		end

		update AccountsPackage set GoodsCount = GoodsCount - 10 WHERE UserID=@dwUserID and [GoodsID] = 1001
		if @@ROWCOUNT = 0
		begin
			SET @strErrorDescribe=N'魅力值不足,请用钻石抽奖！'
			RETURN 8
		end
		SELECT @charm=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID and [GoodsID] = 1001
		if @charm is null set @charm = 0
		set @ischarm = 1

		if @charm < 0
		begin
			update AccountsPackage set GoodsCount = GoodsCount + 10 WHERE UserID=@dwUserID and [GoodsID] = 1001
			SET @strErrorDescribe=N'魅力值不足,请用钻石抽奖！'
			RETURN 8
		end
		else
		begin
			INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,1001,10)
			update LuckDraw set counts = counts+1 where UserID = @dwUserID and dates = @todays
			if @@ROWCOUNT = 0
			insert into LuckDraw(UserID,counts,dates) values(@dwUserID,1,@todays)
		end
	end
	else
	begin

		-- 查询宝石
		declare @baos int
		update THTreasureDB.dbo.UserCurrencyInfo set Currency = Currency - @Consume WHERE UserID=@dwUserID
		set @baos=@@rowcount
		IF @baos=0 
		BEGIN
			SET @strErrorDescribe=N'您的钻石数量不足 ' + CONVERT(NVARCHAR,@Consume) + N' 个，请进入游戏充值页面进行充值！'
			RETURN 6
		END

		SELECT @Beans=Currency FROM THTreasureDB.dbo.UserCurrencyInfo WHERE UserID=@dwUserID
		set @ischarm = 2

	    -- 数据调整
		IF @Beans IS NULL SET @Beans=0
		IF @Consume IS NULL SET @Consume=0

		-- 宝石判断
		IF @Beans<0 
		BEGIN
			update THTreasureDB.dbo.UserCurrencyInfo set Currency = Currency + @Consume WHERE UserID=@dwUserID
			SET @strErrorDescribe=N'您的钻石数量不足 ' + CONVERT(NVARCHAR,@Consume) + N' 个，请进入游戏充值页面进行充值！'
			RETURN 5
		END
	end

	-- 变量定义
	DECLARE @RandRange AS INT
	DECLARE @MaxRange AS INT
	DECLARE @ItemIndex AS INT
	DECLARE @dwLuckyGoodsID AS INT
	DECLARE @dwLuckyGoodsCount AS INT

	-- 抽奖次数
	-- DECLARE @LotteryCount AS INT
	-- SELECT @LotteryCount=COUNT(*) FROM RedPacketLotteryRecord WHERE UserID=@dwUserID

	-- 次数判断
	-- IF @LotteryCount=0
	-- BEGIN
		-- SET @RandRange=CAST(FLOOR(RAND()*100) AS INT)
		-- IF @RandRange<30
		-- BEGIN
			-- SET @ItemIndex=9
			-- SET @dwLuckyGoodsID=901
			-- SET @dwLuckyGoodsCount=2
		-- END
		-- ELSE
		-- BEGIN
			-- SET @ItemIndex=4
			-- SET @dwLuckyGoodsID=901
			-- SET @dwLuckyGoodsCount=5
		-- END
	-- END
	-- ELSE
	-- BEGIN

		declare @isUse int
		select @isUse=isUse  FROM [THPlatformDB].[dbo].[SelectPlatform](nolock) where ID = 1 
		if @isUse is null set @isUse = 0

		-- 随机上限
		SELECT @MaxRange=MAX(RangeEnd) FROM RedPacketConfig where isUse = @isUse

		WHILE 1=1
		BEGIN
			-- 随机数据
			SET @RandRange=CAST(CEILING(RAND()*@MaxRange) AS INT)

		

			-- 中奖物品
			SELECT @ItemIndex=ItemIndex,@dwLuckyGoodsID=LuckyGoodsID,@dwLuckyGoodsCount=LuckyGoodsCount 
			FROM RedPacketConfig WHERE @RandRange>=RangeStart AND @RandRange<=RangeEnd and isUse = @isUse

--			IF @ItemIndex=2 OR @ItemIndex=4 OR @ItemIndex=6 OR @ItemIndex=7 OR @ItemIndex=8 OR @ItemIndex=9 OR @ItemIndex=10 OR @ItemIndex=12
--			BEGIN
--				CONTINUE
--			END

			-- 判断库存
			IF @dwLuckyGoodsID=901 AND @dwLuckyGoodsCount>@Storage
			BEGIN
				CONTINUE
			END

			BREAK
		END

		-- 更新库存
		IF @dwLuckyGoodsID=901
		BEGIN
			UPDATE RedPacketStorage SET Storage=Storage-@dwLuckyGoodsCount WHERE Nullity=0
		END
		UPDATE RedPacketStorage SET Storage=Storage+@Consume*(1.0-@Deduct) WHERE Nullity=0
	-- END

	-- 数据调整
	IF @ItemIndex IS NULL OR @dwLuckyGoodsID IS NULL OR @dwLuckyGoodsCount IS NULL
	BEGIN
		SET @ItemIndex=4
		SET @dwLuckyGoodsID=501
		SET @dwLuckyGoodsCount=20000
	END

	-- 更新物品
	UPDATE AccountsPackage SET GoodsCount=GoodsCount+@dwLuckyGoodsCount WHERE UserID=@dwUserID AND GoodsID=@dwLuckyGoodsID

	-- 插入物品
	IF @@ROWCOUNT=0
	BEGIN
		INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@dwLuckyGoodsID,@dwLuckyGoodsCount)
	END

	-- 背包记录
	DECLARE @RecordNote AS NVARCHAR(32)
	-- SET @RecordNote = N'红包抽奖获得'
	 SET @RecordNote = N'幸运转盘二号获得'
	INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@dwUserID,2,@dwLuckyGoodsID,@dwLuckyGoodsCount,@RecordNote)

	-- 抽奖记录
	INSERT RedPacketLotteryRecord(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@dwLuckyGoodsID,@dwLuckyGoodsCount)

	-- 输出变量
	SELECT @ItemIndex AS ItemIndex,GoodsID,GoodsName,GoodsType,@dwLuckyGoodsCount AS GoodsCount,@ischarm as ischarm
	FROM PackageGoodsInfo WHERE Nullity=0 AND GoodsID=@dwLuckyGoodsID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 支付宝查询
CREATE PROC GSP_MB_AliPayQuery
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @BindingStatus AS TINYINT
	DECLARE @PayeeAccount AS NVARCHAR(100)
	DECLARE @PayeeRealName AS NVARCHAR(100)

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
	
	-- 支付宝查询
	SELECT @PayeeAccount=PayeeAccount,@PayeeRealName=PayeeRealName FROM AliPayBindingInfo WHERE UserID=@dwUserID

	-- 绑定判断
	IF @PayeeAccount IS NULL OR @PayeeRealName IS NULL
	BEGIN
		SET @BindingStatus=0
	END
	ELSE
	BEGIN
		SET @BindingStatus=1
	END

	-- 数据调整
	IF @PayeeAccount IS NULL SET @PayeeAccount=N''
	IF @PayeeRealName IS NULL SET @PayeeRealName=N''

	-- 输出变量
	SELECT @BindingStatus AS BindingStatus,@PayeeAccount AS PayeeAccount,@PayeeRealName AS PayeeRealName
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 支付宝更新
CREATE PROC GSP_MB_AliPayUpdate
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strPayeeAccount NVARCHAR(100),				-- 支付宝账号
	@strPayeeRealName NVARCHAR(100),			-- 支付宝姓名
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @BindingStatus AS TINYINT
	DECLARE @PayeeAccount AS NVARCHAR(100)
	DECLARE @PayeeRealName AS NVARCHAR(100)

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

	-- 支付宝账号
	IF @strPayeeAccount=N''
	BEGIN
		SET @strErrorDescribe=N'您的支付宝账号输入有误，请查证后再次尝试！'
		RETURN 3
	END

	-- 支付宝姓名
	IF @PayeeRealName=N''
	BEGIN
		SET @strErrorDescribe=N'您的支付宝姓名输入有误，请查证后再次尝试！'
		RETURN 4
	END

	-- 支付宝更新
	UPDATE AliPayBindingInfo SET PayeeAccount=@strPayeeAccount,PayeeRealName=@strPayeeRealName WHERE UserID=@dwUserID
	
	-- 支付宝写入
	IF @@ROWCOUNT=0
	BEGIN
		INSERT AliPayBindingInfo(UserID,PayeeAccount,PayeeRealName) VALUES (@dwUserID,@strPayeeAccount,@strPayeeRealName)
	END
	
	-- 支付宝查询
	SELECT @PayeeAccount=PayeeAccount,@PayeeRealName=PayeeRealName FROM AliPayBindingInfo WHERE UserID=@dwUserID

	-- 绑定判断
	IF @PayeeAccount IS NULL OR @PayeeRealName IS NULL
	BEGIN
		SET @BindingStatus=0
	END
	ELSE
	BEGIN
		SET @BindingStatus=1
	END

	-- 数据调整
	IF @PayeeAccount IS NULL SET @PayeeAccount=N''
	IF @PayeeRealName IS NULL SET @PayeeRealName=N''

	-- 输出变量
	SELECT @BindingStatus AS BindingStatus,@PayeeAccount AS PayeeAccount,@PayeeRealName AS PayeeRealName
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------