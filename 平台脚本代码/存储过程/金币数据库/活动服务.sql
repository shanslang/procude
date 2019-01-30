
----------------------------------------------------------------------------------------------------

USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_ActivityQuery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_ActivityQuery]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_ActivityTakeReward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_ActivityTakeReward]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 活动查询
CREATE PROC GSP_GP_ActivityQuery
	@wActivityID INT,							-- 活动标识
	@dwUserID INT,								-- 用户 I D
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @TakeStatus TINYINT

	-- 用户判断
	IF NOT EXISTS (SELECT UserID FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID)
	BEGIN
		SET @strErrorDescribe=N'您的账户信息有误，请查证后再次尝试！'
		RETURN 1
	END

	-- 活动判断
	IF @wActivityID=1
	BEGIN
		-- 统计次数
		DECLARE @ActivityRewardCount AS INT
		SELECT @ActivityRewardCount=COUNT(RecordID) FROM RecordActivityReward WHERE UserID=@dwUserID AND ActivityID=@wActivityID

		-- 次数判断
		IF @ActivityRewardCount<>0
		BEGIN
			SET @TakeStatus=1
		END
		ELSE
		BEGIN
			SET @TakeStatus=0
		END
	END
	ELSE
	BEGIN
		SET @strErrorDescribe=N'您的活动标识有误，请查证后再次尝试！'
		RETURN 2
	END

	-- 输出校验
	IF @wActivityID IS NULL SET @wActivityID=0
	IF @TakeStatus IS NULL SET @TakeStatus=0

	-- 输出变量
	SELECT @wActivityID AS ActivityID, @TakeStatus AS TakeStatus
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 领取奖励
CREATE PROC GSP_GP_ActivityTakeReward
	@wActivityID INT,							-- 活动标识
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

	-- 活动判断
	IF @wActivityID=1
	BEGIN
		-- 活动过期
		SET @strErrorDescribe=N'抱歉，该活动已过期，请留意最新活动消息！'
		RETURN 3
		
		-- 统计次数
		DECLARE @ActivityRewardCount AS INT
		SELECT @ActivityRewardCount=COUNT(RecordID) FROM RecordActivityReward WHERE UserID=@dwUserID AND ActivityID=@wActivityID

		-- 次数判断
		IF @ActivityRewardCount<>0
		BEGIN
			SET @strErrorDescribe=N'抱歉，您已经领取过该活动奖励，不能再次领取！'
			RETURN 3
		END

		-- 设置奖励
		DECLARE @RewardGoodsID INT
		DECLARE @RewardGoodsCount INT
		SET @RewardGoodsID=50
		SET @RewardGoodsCount=5

		-- 更新物品
		UPDATE PackageInfo SET GoodsCount=GoodsCount+@RewardGoodsCount WHERE UserID=@dwUserID AND GoodsID=@RewardGoodsID

		-- 插入物品
		IF @@ROWCOUNT=0
		BEGIN
			INSERT PackageInfo(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@RewardGoodsID,@RewardGoodsCount)
		END

		-- 写入记录
		INSERT RecordActivityReward (ActivityID,UserID,GoodsID,GoodsCount,OperateMachine) VALUES (1,@dwUserID,@RewardGoodsID,@RewardGoodsCount,@strMachineID)

		-- 输出变量
		SET @strErrorDescribe=N'恭喜您，活动奖励领取成功！'
	END
	ELSE
	BEGIN
		SET @strErrorDescribe=N'您的活动标识有误，请查证后再次尝试！'
		RETURN 4
	END
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------