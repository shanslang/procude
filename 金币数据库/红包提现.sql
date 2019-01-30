----------------------------------------------------------------------
-- 版权：2017
-- 时间：2017-08-08
-- 用途：红包提现
----------------------------------------------------------------------

USE [THTreasureDB]
GO

-- 提现订单
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_WithdrawOrder') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_WithdrawOrder
GO

-- 提现入账
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_WithdrawRecorded') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_WithdrawRecorded
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

---------------------------------------------------------------------------------------
-- 提现订单
CREATE PROCEDURE NET_PW_WithdrawOrder
	@strOrderID	NVARCHAR(32),					-- 订单标识
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@dwAmount INT,								-- 提现金额
	@strClientIP NVARCHAR(15)					-- 连接地址
--	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsCount AS INT
	DECLARE @PayeeAccount AS NVARCHAR(100)
	DECLARE @PayeeRealName AS NVARCHAR(100)
	DECLARE @Amount AS DECIMAL(18, 2)

	-- 查询密码
	SELECT @LogonPass=LogonPass FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 账户判断
	IF @LogonPass IS NULL
	BEGIN
		select 1 as ret
	        --SET @strErrorDescribe=N'您的账户信息有误，请查证后再次尝试！'
		RETURN 1
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		select 2 as ret
		--  SET @strErrorDescribe=N'您的密码输入有误，请查证后再次尝试！'
		RETURN 2
	END

	-- 查询锁定
	DECLARE @LockKindID INT
	DECLARE @LockServerID INT
	SELECT @LockKindID=KindID, @LockServerID=ServerID FROM GameScoreLocker WHERE UserID=@dwUserID

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
		--  SET @strErrorDescribe=N'您正在 [ '+@KindName+N' ] 的 [ '+@ServerName+N' ] 游戏房间中，不能进行当前操作！'
	        select 3 as ret
		RETURN 3
	END

	-- 查询支付宝
	SELECT @PayeeAccount=PayeeAccount,@PayeeRealName=PayeeRealName FROM THAccountsDB.dbo.AliPayBindingInfo WHERE UserID=@dwUserID

	-- 支付宝判断
	IF @PayeeAccount IS NULL OR @PayeeRealName IS NULL
	BEGIN
		select 4 as ret
		-- SET @strErrorDescribe=N'您的尚未绑定支付宝账号，请先绑定支付宝账号再进行操作！'
		RETURN 4
	END
	
	-- 查询红包
	update THAccountsDB.dbo.AccountsPackage set GoodsCount=GoodsCount-@dwAmount WHERE UserID=@dwUserID AND GoodsID=901
	SELECT @GoodsCount=GoodsCount FROM THAccountsDB.dbo.AccountsPackage WHERE UserID=@dwUserID AND GoodsID=901

	-- 提现判断
	IF @GoodsCount is null or @GoodsCount < 0
	BEGIN
		select 5 as ret
		update THAccountsDB.dbo.AccountsPackage set GoodsCount=GoodsCount+@dwAmount WHERE UserID=@dwUserID AND GoodsID=901
		-- SET @strErrorDescribe=N'您的提现金额大于红包数目，请查证后再次尝试！'
		RETURN 5
	END
	
	-- 提现时间
	DECLARE @RecordDate AS DATETIME
	SELECT TOP 1 @RecordDate=RecordDate FROM RecordRedPacketTransfer WHERE PayeeAccount=@PayeeAccount AND PayeeRealName=@PayeeRealName ORDER BY RecordDate DESC
	IF @RecordDate IS NOT NULL
	BEGIN
		IF DateDiff(dd,@RecordDate,GetDate())=0
		BEGIN
	                select 6 as ret
			update THAccountsDB.dbo.AccountsPackage set GoodsCount=GoodsCount+@dwAmount WHERE UserID=@dwUserID AND GoodsID=901   
			-- SET @strErrorDescribe=N'当日提现次数已达上限，请明日再来！'
			RETURN 6
		END
	END
	
	-- 提现金额
	SET @Amount = @dwAmount
	
	-- 生成订单
	INSERT RecordAliPayTransfer (OrderID,UserID,PayeeAccount,PayeeRealName,Amount,TransferStatus) 
	VALUES (@strOrderID,@dwUserID,@PayeeAccount,@PayeeRealName,@Amount,0)

	-- 输出变量
	-- SELECT @PayeeAccount AS PayeeAccount,@PayeeRealName AS PayeeRealName,@Amount AS Amount
	SELECT '0' as ret,@PayeeAccount AS PayeeAccount,@PayeeRealName AS PayeeRealName,@Amount AS Amount
	
END

RETURN 0

GO

---------------------------------------------------------------------------------------

-- 提现入账
CREATE PROCEDURE NET_PW_WithdrawRecorded
	@strOrderID	NVARCHAR(32)					-- 订单标识
	-- @strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @UserID AS INT
	DECLARE @Amount AS DECIMAL(18, 2)
	DECLARE @TransferStatus AS TINYINT
	
	-- 查询订单
	SELECT @UserID=UserID,@Amount=Amount,@TransferStatus=TransferStatus FROM RecordAliPayTransfer WHERE OrderID=@strOrderID
	IF @UserID IS NULL OR @Amount IS NULL OR @TransferStatus IS NULL
	BEGIN
	        select 11 as ret
		-- SET @strErrorDescribe=N'入账订单不存在，请查证后再次尝试！'
		RETURN 11
	END

	-- 状态判断
	IF @TransferStatus=1
	BEGIN
	        select 12 as ret
		-- SET @strErrorDescribe=N'该笔订单已经入账，无需重复入账！'
		RETURN 12
	END

	-- 更新订单
	UPDATE RecordAliPayTransfer SET TransferStatus=1,SuccessDate=GETDATE() WHERE OrderID=@strOrderID

	-- 更新背包
	--UPDATE THAccountsDBLink.THAccountsDB.dbo.AccountsPackage SET GoodsCount=GoodsCount-CAST(@Amount AS INT) WHERE UserID=@UserID AND GoodsID=901

	-- 背包记录
	DECLARE @RecordNote AS NVARCHAR(32)
	SET @RecordNote = N'红包提现'
	INSERT THAccountsDBLink.THAccountsDB.dbo.PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@UserID,1,901,CAST(@Amount AS INT),@RecordNote)

	-- 提现记录
	INSERT RecordRedPacketTransfer(OrderID,UserID,PayeeAccount,PayeeRealName,Amount) 
	SELECT OrderID,UserID,PayeeAccount,PayeeRealName,Amount FROM RecordAliPayTransfer WHERE OrderID=@strOrderID

	-- 删除物品
	DELETE FROM THAccountsDBLink.THAccountsDB.dbo.AccountsPackage WHERE UserID=@UserID AND GoodsCount=0

        -- 输出变量
	SELECT '0' as ret
END

RETURN 0

GO

---------------------------------------------------------------------------------------