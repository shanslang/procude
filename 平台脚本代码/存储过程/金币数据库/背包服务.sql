
----------------------------------------------------------------------------------------------------

USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_GetPackageConfig]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_GetPackageConfig]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_GetPackageInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_GetPackageInfo]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_OpenBox]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_OpenBox]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_SetLuckyGoods]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_SetLuckyGoods]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_ExchangeReward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_ExchangeReward]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_DiscardGoods]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_DiscardGoods]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 背包配置
CREATE PROC GSP_GP_GetPackageConfig
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	-- 删除物品
	DELETE FROM PackageInfo WHERE GoodsID NOT IN (SELECT GoodsID FROM PackageConfig WHERE Nullity=0)

	-- 输出变量
	SELECT GoodsID,GoodsName,GoodsType,GoodsPrice,RewardScore,Storage,Probability FROM PackageConfig WHERE Nullity=0 ORDER BY GoodsID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 背包信息
CREATE PROC GSP_GP_GetPackageInfo
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
	SELECT @LogonPass=LogonPass FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	
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
	DELETE FROM PackageInfo WHERE UserID=@dwUserID AND GoodsCount=0
	
	-- 输出变量
	SELECT A.GoodsID AS GoodsID,GoodsName,GoodsType,GoodsPrice,GoodsCount,LuckyGoodsID
	FROM PackageInfo A,PackageConfig (NOLOCK) B WHERE A.GoodsID=B.GoodsID AND B.Nullity=0 AND A.UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 开启宝箱
CREATE PROC GSP_GP_OpenBox
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@cbOperateType TINYINT,						-- 操作类型
	@dwOperateGoodsID INT,						-- 物品 I D
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsCount INT
	DECLARE @Beans DECIMAL(18, 2)
	DECLARE @GoodsPrice DECIMAL(18, 2)
	
	-- 查询密码
	SELECT @LogonPass=LogonPass FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	
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

	-- 查询游戏豆
	SELECT @Beans=Currency FROM UserCurrencyInfo WHERE UserID=@dwUserID

	-- 查询物品
	SELECT @GoodsPrice=GoodsPrice FROM PackageConfig (NOLOCK) WHERE GoodsID=@dwOperateGoodsID

	-- 查询数量
	SELECT @GoodsCount=GoodsCount FROM PackageInfo WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

	-- 数据调整
	IF @Beans IS NULL SET @Beans=0
	IF @GoodsCount IS NULL SET @GoodsCount=0

	-- 物品判断
	IF @GoodsPrice IS NULL OR @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'您操作的物品不存在，请查证后再次尝试！'
		RETURN 3
	END

	-- 价格判断
	IF @Beans<@GoodsPrice
	BEGIN
		SET @strErrorDescribe=N'您的钻石数量不足，请进入游戏充值页面进行充值！'
		RETURN 4
	END

	-- 删除物品
	DELETE FROM PackageInfo WHERE UserID=@dwUserID AND GoodsCount=0
	
	-- 输出变量
	SELECT A.GoodsID AS GoodsID,GoodsName,GoodsType,GoodsPrice,GoodsCount,LuckyGoodsID
	FROM PackageInfo A,PackageConfig (NOLOCK) B WHERE A.GoodsID=B.GoodsID AND B.Nullity=0 AND A.UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 中奖物品
CREATE PROC GSP_GP_SetLuckyGoods
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@cbOperateType TINYINT,						-- 操作类型
	@dwOperateGoodsID INT,						-- 物品 I D
	@dwLuckyGoodsID INT,						-- 中奖物品
	@dwLeftStorage INT,							-- 剩余库存
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsCount INT
	DECLARE @Beans DECIMAL(18, 2)
	DECLARE @GoodsPrice DECIMAL(18, 2)
	DECLARE @GoodsType TINYINT
	DECLARE @RewardScore BIGINT
	DECLARE @RewardExcharge INT
	
	-- 查询密码
	SELECT @LogonPass=LogonPass FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	
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

	-- 查询游戏豆
	SELECT @Beans=Currency FROM UserCurrencyInfo WHERE UserID=@dwUserID

	-- 查询物品
	SELECT @GoodsPrice=GoodsPrice FROM PackageConfig (NOLOCK) WHERE GoodsID=@dwOperateGoodsID

	-- 查询数量
	SELECT @GoodsCount=GoodsCount FROM PackageInfo WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

	-- 奖励物品
	SELECT @GoodsType=GoodsType,@RewardScore=RewardScore,@RewardExcharge=RewardExcharge 
	FROM PackageConfig (NOLOCK) WHERE GoodsID=@dwLuckyGoodsID

	-- 数据调整
	IF @Beans IS NULL SET @Beans=0
	IF @GoodsCount IS NULL SET @GoodsCount=0
	IF @GoodsType IS NULL SET @GoodsType=0
	IF @RewardScore IS NULL SET @RewardScore=0

	-- 物品判断
	IF @GoodsPrice IS NULL OR @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'您操作的物品不存在，请查证后再次尝试！'
		RETURN 3
	END

	-- 价格判断
	IF @Beans<@GoodsPrice
	BEGIN
		SET @strErrorDescribe=N'您的钻石数量不足，请进入游戏充值页面进行充值！'
		RETURN 4
	END

	-- 更新游戏豆
	UPDATE UserCurrencyInfo SET Currency=Currency-@GoodsPrice WHERE UserID=@dwUserID

	-- 更新库存
	UPDATE PackageConfig SET Storage=@dwLeftStorage WHERE GoodsID=@dwLuckyGoodsID

	-- 类型判断
	IF @GoodsType&0x02<>0 OR @GoodsType&0x04<>0
	BEGIN
		-- 奖励金币
		IF @GoodsType&0x02<>0
		BEGIN
			-- 更新物品
			UPDATE GameScoreInfo SET InsureScore=InsureScore+@RewardScore WHERE UserID=@dwUserID

			-- 插入物品
			IF @@ROWCOUNT=0
			BEGIN
				INSERT GameScoreInfo(UserID,InsureScore) VALUES (@dwUserID,@RewardScore)
			END
		END
		
		-- 奖励充值卡
		IF @GoodsType&0x04<>0
		BEGIN
			-- 更新物品
			UPDATE PackageInfo SET GoodsCount=GoodsCount+@RewardExcharge WHERE UserID=@dwUserID AND GoodsID=50

			-- 插入物品
			IF @@ROWCOUNT=0
			BEGIN
				INSERT PackageInfo(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,50,@RewardExcharge)
			END
		END
	END
	ELSE
	BEGIN
		-- 奖励物品
		UPDATE PackageInfo SET GoodsCount=GoodsCount+1 WHERE UserID=@dwUserID AND GoodsID=@dwLuckyGoodsID

		-- 插入物品
		IF @@ROWCOUNT=0
		BEGIN
			INSERT PackageInfo(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@dwLuckyGoodsID,1)
		END
	END
	
	-- 任务类型
	DECLARE @wKindID INT
	IF @dwOperateGoodsID=1 SET @wKindID=3004
	ELSE IF @dwOperateGoodsID=2 SET @wKindID=3005
	ELSE SET @wKindID=0

	-- 任务推进
	IF @wKindID<>0
	BEGIN
		EXEC THPlatformDBLink.THPlatformDB.dbo.GSP_GR_TaskForward @dwUserID,@wKindID,0,1,0,0
	END

	-- 更新物品
	UPDATE PackageInfo SET GoodsCount=GoodsCount-1,LuckyGoodsID=0 WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

	-- 操作记录
	INSERT RecordPackageInfo(UserID,GoodsID,OperateType,LuckyGoodsID) VALUES (@dwUserID,@dwOperateGoodsID,@cbOperateType,@dwLuckyGoodsID)

	-- 删除物品
	DELETE FROM PackageInfo WHERE UserID=@dwUserID AND GoodsCount=0

	-- 输出变量
	SELECT A.GoodsID AS GoodsID,GoodsName,GoodsType,GoodsPrice,GoodsCount,LuckyGoodsID
	FROM PackageInfo A,PackageConfig (NOLOCK) B WHERE A.GoodsID=B.GoodsID AND B.Nullity=0 AND A.UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 兑换奖励
CREATE PROC GSP_GP_ExchangeReward
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@cbOperateType TINYINT,						-- 操作类型
	@dwOperateGoodsID INT,						-- 物品 I D
	@szMobilePhone NVARCHAR(11),				-- 移动电话
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsCount INT
	
	-- 查询密码
	SELECT @LogonPass=LogonPass FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	
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

	-- 手机判断
	IF LEN(@szMobilePhone)<11
	BEGIN
		SET @strErrorDescribe=N'您的手机号码输入有误，请查证后再次尝试！'
		RETURN 3
	END

	-- 查询数量
	SELECT @GoodsCount=GoodsCount FROM PackageInfo WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

	-- 数据调整
	IF @GoodsCount IS NULL SET @GoodsCount=0

	-- 数量判断
	IF @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'您操作的物品不存在，请查证后再次尝试！'
		RETURN 4
	END

	-- 充值累计卡
	IF @dwOperateGoodsID=50
	BEGIN
		-- 兑换数量
		DECLARE @ExchangeCount INT
		SET @ExchangeCount=50

		-- 数量判断
		IF @GoodsCount<@ExchangeCount
		BEGIN
			SET @strErrorDescribe=N'您兑换的累计卡数量不足50元，请集齐50元后再进行兑换！'
			RETURN 5
		END

		-- 50元充值卡
		DECLARE @RechargeCardID INT

		-- 查询物品
		SELECT @RechargeCardID=GoodsID FROM PackageConfig (NOLOCK) WHERE GoodsType&0x04<>0 AND RewardExcharge=@ExchangeCount

		IF @RechargeCardID IS NULL SET @RechargeCardID=@dwOperateGoodsID
		
		-- 奖励记录
		INSERT RecordExchangeReward (UserID,GoodsID,MobilePhone) VALUES (@dwUserID,@RechargeCardID,@szMobilePhone)

		-- 更新物品
		UPDATE PackageInfo SET GoodsCount=GoodsCount-@ExchangeCount WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

		-- 操作记录
		INSERT RecordPackageInfo(UserID,GoodsID,OperateType,LuckyGoodsID) VALUES (@dwUserID,@RechargeCardID,@cbOperateType,0)
	END
	ELSE
	BEGIN
		-- 奖励记录
		INSERT RecordExchangeReward (UserID,GoodsID,MobilePhone) VALUES (@dwUserID,@dwOperateGoodsID,@szMobilePhone)

		-- 更新物品
		UPDATE PackageInfo SET GoodsCount=GoodsCount-1 WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

		-- 操作记录
		INSERT RecordPackageInfo(UserID,GoodsID,OperateType,LuckyGoodsID) VALUES (@dwUserID,@dwOperateGoodsID,@cbOperateType,0)
	END

	-- 删除物品
	DELETE FROM PackageInfo WHERE UserID=@dwUserID AND GoodsCount=0

	-- 输出变量
	SELECT A.GoodsID AS GoodsID,GoodsName,GoodsType,GoodsPrice,GoodsCount,LuckyGoodsID
	FROM PackageInfo A,PackageConfig (NOLOCK) B WHERE A.GoodsID=B.GoodsID AND B.Nullity=0 AND A.UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 丢弃物品
CREATE PROC GSP_GP_DiscardGoods
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@cbOperateType TINYINT,						-- 操作类型
	@dwOperateGoodsID INT,						-- 物品 I D
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsCount INT
	
	-- 查询密码
	SELECT @LogonPass=LogonPass FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	
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

	-- 查询数量
	SELECT @GoodsCount=GoodsCount FROM PackageInfo WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

	-- 数据调整
	IF @GoodsCount IS NULL SET @GoodsCount=0

	-- 数量判断
	IF @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'您操作的物品不存在，请查证后再次尝试！'
		RETURN 3
	END

	-- 更新物品
	UPDATE PackageInfo SET GoodsCount=GoodsCount-1 WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

	-- 操作记录
	INSERT RecordPackageInfo(UserID,GoodsID,OperateType,LuckyGoodsID) VALUES (@dwUserID,@dwOperateGoodsID,@cbOperateType,0)

	-- 删除物品
	DELETE FROM PackageInfo WHERE UserID=@dwUserID AND GoodsCount=0

	-- 输出变量
	SELECT A.GoodsID AS GoodsID,GoodsName,GoodsType,GoodsPrice,GoodsCount,LuckyGoodsID
	FROM PackageInfo A,PackageConfig (NOLOCK) B WHERE A.GoodsID=B.GoodsID AND B.Nullity=0 AND A.UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------