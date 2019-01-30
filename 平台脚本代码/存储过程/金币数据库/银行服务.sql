
----------------------------------------------------------------------------------------------------

USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_UserEnableInsure]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_UserEnableInsure]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_UserSaveScore]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_UserSaveScore]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_UserTakeScore]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_UserTakeScore]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_UserTransferScore_NZBY]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_UserTransferScore_NZBY]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_UserTransferScoreGameID]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_UserTransferScoreGameID]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_UserTransferScore]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_UserTransferScore]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_QueryUserInsureInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_QueryUserInsureInfo]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_LogonInsure]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_LogonInsure]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

-- 开通银行
CREATE PROC GSP_GR_UserEnableInsure
	@dwUserID INT,								-- 用户 I D
	@strLogonPass NCHAR(32),					-- 登录密码
	@strInsurePass NCHAR(32),					-- 银行密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN

	-- 查询用户
	IF NOT Exists(SELECT * FROM THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID AND LogonPass=@strLogonPass)
	BEGIN
		SET @strErrorDescribe=N'密码验证失败，无法开通银行！'
		RETURN 1		
	END
	
	if @strLogonPass = @strInsurePass
	begin
		SET @strErrorDescribe=N'银行密码和登录密码不能一样！'
		RETURN 1
	end
	
	
	-- 设置密码
	UPDATE THAccountsDB.dbo.AccountsInfo SET InsurePass=@strInsurePass	WHERE UserID=@dwUserID		

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 存入金币
CREATE PROC GSP_GR_UserSaveScore
	@dwUserID INT,								-- 用户 I D
	@lSaveScore BIGINT,							-- 金币数目
	@wKindID SMALLINT,							-- 游戏 I D
	@wServerID SMALLINT,						-- 房间 I D
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 金币变量
DECLARE @SourceScore BIGINT
DECLARE @SourceInsure BIGINT
DECLARE @InsureRevenue BIGINT
DECLARE @VariationScore BIGINT
DECLARE @VariationInsure BIGINT

-- 执行逻辑
BEGIN

	-- 辅助变量
	DECLARE @EnjoinLogon INT
	DECLARE @EnjoinInsure INT

	-- 系统暂停
	SELECT @EnjoinInsure=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'EnjoinInsure'
	IF @EnjoinInsure IS NOT NULL AND @EnjoinInsure<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'EnjoinInsure'
		RETURN 2
	END

	-- 效验地址
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您所在的 IP 地址的游戏服务权限，请联系客户服务中心了解详细情况！'
		RETURN 4
	END
	
	-- 效验机器
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineID AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您的机器的游戏服务权限，请联系客户服务中心了解详细情况！'
		RETURN 7
	END
 
	-- 查询用户
	DECLARE @UserID INT
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	DECLARE	@MachineID NVARCHAR(32)
	DECLARE @MoorMachine AS TINYINT
	declare @IsBindMobile as tinyint
	SELECT @UserID=UserID, @Nullity=Nullity, @StunDown=StunDown, @MoorMachine=MoorMachine, @MachineID=LastLogonMachine,@IsBindMobile= (case when len(RegisterMobile) > 0 then 1 else 0 end)
	FROM THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在或者密码输入有误，请查证后再次尝试登录！'
		RETURN 1
	END	
	
	--if @IsBindMobile = 0
	--begin
	--	SET @strErrorDescribe=N'请先绑定手机号再尝试此操作！'
	--	RETURN 1
	--end

	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 2
	END	

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 2
	END	

	IF @MachineID<>@strMachineID
	BEGIN
		SET @strErrorDescribe=N'请重新登录！'
		RETURN 1
	END
	
	-- 固定机器
	IF @MoorMachine=1
	BEGIN
		IF @MachineID<>@strMachineID
		BEGIN
			SET @strErrorDescribe=N'您的帐号使用固定机器登录功能，您现所使用的机器不是所指定的机器！'
			RETURN 1
		END
	END
	
	-- 金币判断
	DECLARE @BankPrerequisite AS INT
	SELECT @BankPrerequisite=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'BankPrerequisite'
	IF @BankPrerequisite IS NULL SET @BankPrerequisite=0
	IF @lSaveScore<@BankPrerequisite
	BEGIN
		SET @strErrorDescribe=N'存入银行的游戏币数目不能少于 '+LTRIM(STR(@BankPrerequisite))+'，游戏币存入失败！'
		RETURN 4
	END

	-- 游戏信息
	SELECT @SourceScore=Score, @SourceInsure=InsureScore FROM GameScoreInfo WHERE UserID=@dwUserID

	-- 金币判断
	IF @SourceScore IS NULL OR @SourceScore<@lSaveScore
	BEGIN
		-- 错误信息
		SET @strErrorDescribe=N'您当前游戏币的可用余额不足，游戏币存入失败！'
		RETURN 4
	END

	-- 查询锁定
	DECLARE @LockKindID INT
	DECLARE @LockServerID INT
	SELECT @LockKindID=KindID, @LockServerID=ServerID FROM GameScoreLocker WHERE UserID=@dwUserID

	-- 锁定调整
	IF @LockKindID IS NULL SET @LockKindID=0
	IF @LockServerID IS NULL SET @LockServerID=0

	-- 锁定判断
	IF (@LockKindID<>0 and @LockKindID<>@wKindID) OR (@LockServerID<>0 and @LockServerID<>@wServerID)
	BEGIN
		-- 查询类型
		IF @LockKindID<>0 AND @LockServerID<>0
		BEGIN
			-- 查询信息
			DECLARE @KindName NVARCHAR(31)
			DECLARE @ServerName NVARCHAR(31)
			SELECT @KindName=KindName FROM THPlatformDB.dbo.GameKindItem WHERE KindID=@LockKindID
			SELECT @ServerName=ServerName FROM THPlatformDB.dbo.GameRoomInfo WHERE ServerID=@LockServerID

			-- 错误信息
			IF @KindName IS NULL SET @KindName=N'未知游戏'
			IF @ServerName IS NULL SET @ServerName=N'未知房间'
			SET @strErrorDescribe=N'您正在 [ '+@KindName+N' ] 的 [ '+@ServerName+N' ] 游戏房间中，不能进行当前的银行操作！'
			RETURN 4

		END
		ELSE
		BEGIN
			-- 提示消息
			SELECT [ErrorDescribe]=N'您正在使用网站页面进行银行处理过程中，不能进行当前的银行操作！'
			SET @strErrorDescribe=N'您正在使用网站页面进行银行处理过程中，不能进行当前的银行操作！'
			RETURN 4
		END
	END

	-- 计算变量
	SET @InsureRevenue=0
	SET @VariationScore=-@lSaveScore
	SET @VariationInsure=@lSaveScore

	-- 设置信息
	SET @strErrorDescribe=N'游戏币存入银行操作成功，请查验您的帐户信息！'

	-- 更新数据
	UPDATE GameScoreInfo SET Score=Score+@VariationScore, InsureScore=InsureScore+@VariationInsure, Revenue=Revenue+@InsureRevenue	
	WHERE UserID=@dwUserID

	-- 记录日志
	INSERT INTO RecordInsure(KindID,ServerID,SourceUserID,SourceGold,SourceBank,
		SwapScore,Revenue,IsGamePlaza,TradeType,ClientIP)
	VALUES(@wKindID,@wServerID,@UserID,@SourceScore,@SourceInsure,@lSaveScore,@InsureRevenue,0,1,@strClientIP)		


	-- 输出结果
	SELECT @dwUserID AS UserID, @SourceScore AS SourceScore, @SourceInsure AS SourceInsure, @VariationScore AS VariationScore,
		@VariationInsure AS VariationInsure, @InsureRevenue AS InsureRevenue, @LockKindID AS KindID, @LockServerID AS ServerID

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 提取金币
CREATE PROC GSP_GR_UserTakeScore
	@dwUserID INT,								-- 用户 I D
	@lTakeScore BIGINT,							-- 金币数目
	@strPassword NCHAR(32),						-- 用户密码
	@wKindID SMALLINT,							-- 游戏 I D
	@wServerID SMALLINT,						-- 房间 I D
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 金币变量
DECLARE @SourceScore BIGINT
DECLARE @SourceInsure BIGINT
DECLARE @InsureRevenue BIGINT
DECLARE @VariationScore BIGINT
DECLARE @VariationInsure BIGINT

-- 执行逻辑
BEGIN

	-- 辅助变量
	DECLARE @EnjoinLogon INT
	DECLARE @EnjoinInsure INT

	-- 系统暂停
	SELECT @EnjoinInsure=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'EnjoinInsure'
	IF @EnjoinInsure IS NOT NULL AND @EnjoinInsure<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'EnjoinInsure'
		RETURN 2
	END

	-- 效验地址
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您所在的 IP 地址的游戏服务权限，请联系客户服务中心了解详细情况！'
		RETURN 4
	END
	
	-- 效验机器
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineID AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您的机器的游戏服务权限，请联系客户服务中心了解详细情况！'
		RETURN 7
	END
 
	-- 查询用户
	DECLARE @UserID INT
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	DECLARE @InsurePass AS NCHAR(32)
	DECLARE	@MachineID NVARCHAR(32)
	DECLARE @MoorMachine AS TINYINT
	declare @IsBindMobile as tinyint
	SELECT @UserID=UserID, @InsurePass=InsurePass, @Nullity=Nullity, @StunDown=StunDown, @MoorMachine=MoorMachine, @MachineID=LastLogonMachine,@IsBindMobile= (case when len(RegisterMobile) > 0 then 1 else 0 end)
	FROM THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在或者密码输入有误，请查证后再次尝试登录！'
		RETURN 1
	END	
	
	--if @IsBindMobile = 0
	--begin
	--	SET @strErrorDescribe=N'请先绑定手机号再尝试此操作！'
	--	RETURN 1
	--end

	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 2
	END	

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 2
	END	

	IF @MachineID<>@strMachineID
	BEGIN
		SET @strErrorDescribe=N'请重新登录！'
		RETURN 1
	END
	
	-- 固定机器
	IF @MoorMachine=1
	BEGIN
		IF @MachineID<>@strMachineID
		BEGIN
			SET @strErrorDescribe=N'您的帐号使用固定机器登录功能，您现所使用的机器不是所指定的机器！'
			RETURN 1
		END
	END

	-- 密码判断
	IF @InsurePass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的保险箱密码不正确或者输入有误，请查证后再次尝试！'
		RETURN 3
	END

	-- 金币判断
	DECLARE @BankPrerequisite AS INT
	SELECT @BankPrerequisite=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'BankPrerequisite'
	IF @BankPrerequisite IS NULL SET @BankPrerequisite=0
	IF @lTakeScore<@BankPrerequisite
	BEGIN
		SET @strErrorDescribe=N'从银行取出的游戏币数目不能少于 '+LTRIM(STR(@BankPrerequisite))+'，游戏币提取失败！'
		RETURN 4
	END

	-- 查询锁定
	DECLARE @LockKindID INT
	DECLARE @LockServerID INT
	SELECT @LockKindID=KindID, @LockServerID=ServerID FROM GameScoreLocker WHERE UserID=@dwUserID

	-- 锁定调整
	IF @LockKindID IS NULL SET @LockKindID=0
	IF @LockServerID IS NULL SET @LockServerID=0

	-- 锁定判断
	IF (@LockKindID<>0 and @LockKindID<>@wKindID) OR (@LockServerID<>0 and @LockServerID<>@wServerID)
	BEGIN
		-- 查询类型
		IF @LockKindID<>0 AND @LockServerID<>0
		BEGIN
			-- 查询信息
			DECLARE @KindName NVARCHAR(31)
			DECLARE @ServerName NVARCHAR(31)
			SELECT @KindName=KindName FROM THPlatformDB.dbo.GameKindItem WHERE KindID=@LockKindID
			SELECT @ServerName=ServerName FROM THPlatformDB.dbo.GameRoomInfo WHERE ServerID=@LockServerID

			-- 错误信息
			IF @KindName IS NULL SET @KindName=N'未知游戏'
			IF @ServerName IS NULL SET @ServerName=N'未知房间'
			SET @strErrorDescribe=N'您正在 [ '+@KindName+N' ] 的 [ '+@ServerName+N' ] 游戏房间中，不能进行当前的银行操作！'
			RETURN 4

		END
		ELSE
		BEGIN
			-- 提示消息
			SELECT [ErrorDescribe]=N'您正在使用网站页面进行银行处理过程中，不能进行当前的银行操作！'
			SET @strErrorDescribe=N'您正在使用网站页面进行银行处理过程中，不能进行当前的银行操作！'
			RETURN 4
		END
	END

	-- 银行税收
	DECLARE @RevenueRate INT
	SELECT @RevenueRate=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'RevenueRateTake'

	-- 税收调整
	IF @RevenueRate>300 SET @RevenueRate=300
	IF @RevenueRate IS NULL SET @RevenueRate=1
	SELECT @SourceScore=Score, @SourceInsure=InsureScore FROM GameScoreInfo WHERE UserID=@dwUserID

	-- 游戏信息
	declare @OPScore bigint
	set @OPScore = -@lTakeScore
	declare @Ret int
	exec @Ret=proc_BankOp @dwUserID,@OPScore
	if @Ret <> 0
	BEGIN
		-- 错误信息
		SET @strErrorDescribe=N'您当前银行的游戏币余额不足，游戏币提取失败！'
		RETURN 4
	END

	-- 计算变量
	SET @InsureRevenue=@lTakeScore*@RevenueRate/1000
	SET @VariationScore=@lTakeScore-@InsureRevenue
	SET @VariationInsure=-@lTakeScore

	-- 设置信息
	SET @strErrorDescribe=N'银行提取游戏币操作成功，请查验您的帐户信息！'

	-- 更新数据
	UPDATE GameScoreInfo SET Score=Score+@VariationScore, Revenue=Revenue+@InsureRevenue
	WHERE UserID=@dwUserID

	-- 记录日志
	INSERT INTO RecordInsure(KindID,ServerID,SourceUserID,SourceGold,SourceBank,
		SwapScore,Revenue,IsGamePlaza,TradeType,ClientIP)
	VALUES(@wKindID,@wServerID,@UserID,@SourceScore,@SourceInsure,@lTakeScore,@InsureRevenue,0,2,@strClientIP)	

	-- 输出结果
	SELECT @dwUserID AS UserID, @SourceScore AS SourceScore, @SourceInsure AS SourceInsure, @VariationScore AS VariationScore,
		@VariationInsure AS VariationInsure, @InsureRevenue AS InsureRevenue, @LockKindID AS KindID, @LockServerID AS ServerID

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 转账金币
CREATE PROC GSP_GR_UserTransferScore_NZBY
	@dwUserID INT,								-- 用户 I D
	@lTransferScore BIGINT,						-- 金币数目
	@strPassword NCHAR(32),						-- 用户密码
	@strNickName NVARCHAR(31),					-- 用户昵称
	@strTransRemark NVARCHAR(32),				-- 转账备注
	@wKindID SMALLINT,							-- 游戏 I D
	@wServerID SMALLINT,						-- 房间 I D
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 金币变量
DECLARE @SourceScore BIGINT
DECLARE @SourceInsure BIGINT

DECLARE @InsureRevenue BIGINT
DECLARE @VariationInsure BIGINT

-- 执行逻辑
BEGIN
	-- 辅助变量
	DECLARE @EnjoinLogon INT
	DECLARE @EnjoinInsure INT
	DECLARE @EnjoinTransfer INT

	-- 系统暂停
	SELECT @EnjoinInsure=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'EnjoinInsure'
	IF @EnjoinInsure IS NOT NULL AND @EnjoinInsure<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'EnjoinInsure'
		RETURN 2
	END	
	
	-- 转账暂停
	SELECT @EnjoinTransfer=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferStauts'
	IF @EnjoinTransfer IS NOT NULL AND @EnjoinTransfer<>1
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferStauts'
		RETURN 3
	END	

	-- 效验地址
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您所在的 IP 地址的游戏服务权限，请联系客户服务中心了解详细情况！'
		RETURN 4
	END
	
	-- 效验机器
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineID AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您的机器的游戏服务权限，请联系客户服务中心了解详细情况！'
		RETURN 7
	END

	-- 查询用户
	DECLARE @UserID INT
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	DECLARE @InsurePass AS NCHAR(32)
	DECLARE	@MachineID NVARCHAR(32)
	DECLARE @MemberOrder AS TINYINT
	DECLARE @MoorMachine AS TINYINT
	DECLARE @PlatformID AS INT
	SELECT @UserID=UserID, @InsurePass=InsurePass, @Nullity=Nullity, @StunDown=StunDown, @MoorMachine=MoorMachine, 
	@MemberOrder=MemberOrder, @MachineID=LastLogonMachine, @PlatformID=PlatformID
	FROM THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在或者密码输入有误，请查证后再次尝试！'
		RETURN 1
	END	

	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 2
	END	

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 2
	END	

	IF @MachineID<>@strMachineID
	BEGIN
		SET @strErrorDescribe=N'请重新登录！'
		RETURN 1
	END
	
	-- 固定机器
	IF @MoorMachine=1
	BEGIN
		IF @MachineID<>@strMachineID
		BEGIN
			SET @strErrorDescribe=N'您的帐号使用固定机器登录功能，您现所使用的机器不是所指定的机器！'
			RETURN 1
		END
	END

	-- 密码判断
	IF @InsurePass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的保险箱密码不正确或者输入有误，请查证后再次尝试！'
		RETURN 3
	END

	-- 金币判断
	DECLARE @TransferPrerequisite AS BIGINT
	SELECT @TransferPrerequisite=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferPrerequisite'
	IF @TransferPrerequisite IS NULL SET @TransferPrerequisite=0
	IF @lTransferScore<@TransferPrerequisite
	BEGIN
		SET @strErrorDescribe=N'从银行转账的游戏币数目不能少于 '+LTRIM(STR(@TransferPrerequisite))+'，游戏币转账失败！'
		RETURN 4
	END

	-- 目标用户
	DECLARE @TargetUserID INT
	DECLARE @TargetMemberOrder AS TINYINT
	DECLARE @TargetPlatformID AS INT
	SELECT @TargetUserID=UserID, @TargetMemberOrder=MemberOrder, @TargetPlatformID=PlatformID FROM THAccountsDB.dbo.AccountsInfo WHERE NickName=@strNickName	
--	IF @cbByNickName=1
--		SELECT @TargetUserID=UserID FROM THAccountsDB.dbo.AccountsInfo WHERE NickName=@strNickName
--	ELSE
--		SELECT @TargetUserID=UserID FROM THAccountsDB.dbo.AccountsInfo WHERE GameID=@strNickName	

	-- 查询用户
	IF @TargetUserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'您所要转账的用户“'+@strNickName+'”不存在或者输入有误，请查证后再次尝试！'
		RETURN 5
	END

	-- 相同判断
	IF @TargetUserID=@dwUserID
	BEGIN
		SET @strErrorDescribe=N'不能使用自己的帐号为自己转账游戏币，请查证后再次尝试！'
		RETURN 6
	END

	-- 会员判断
	IF @MemberOrder<>10 AND @TargetMemberOrder<>10 AND @MemberOrder<>5 AND @TargetMemberOrder<>5
	BEGIN
		SET @strErrorDescribe=N'抱歉，您不是超级会员，没有此功能权限！'
		RETURN 7
	END

	-- 金币查询
	DECLARE @TargetScore BIGINT
	DECLARE @TargetInsure BIGINT
	SELECT @TargetScore=Score, @TargetInsure=InsureScore FROM GameScoreInfo(NOLOCK) WHERE UserID=@TargetUserID

	-- 插入判断
	IF @TargetScore IS NULL
	BEGIN
		-- 插入资料
		INSERT INTO GameScoreInfo (UserID,LastLogonIP,RegisterIP) VALUES (@TargetUserID,@strClientIP,@strClientIP)

		-- 游戏信息
		SELECT @TargetScore=Score, @TargetInsure=InsureScore FROM GameScoreInfo(NOLOCK) WHERE UserID=@TargetUserID
	END

	-- 银行税收	
	DECLARE @MaxTax BIGINT
	DECLARE @RevenueRate INT
	IF @MemberOrder = 0
	BEGIN
		SELECT @MaxTax=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferMaxTax'
		SELECT @RevenueRate=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'RevenueRateTransfer'

		-- 税收调整
		IF @RevenueRate IS NULL SET @RevenueRate=1
	END ELSE
	BEGIN
		SELECT @MaxTax=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferMaxTax'
		SELECT @RevenueRate=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'RevenueRateTransferMember'		
		
		-- 税收调整
		IF @RevenueRate IS NULL SET @RevenueRate=0
	END	
	
	-- 税收调整
	IF @RevenueRate>300 SET @RevenueRate=300	

	-- 银行保留
	DECLARE @TransferRetention INT	-- 至少保留
	DECLARE @SurplusScore BIGINT	-- 转后银行
	SELECT @TransferRetention=ISNULL(StatusValue,0) FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferRetention'

	SELECT @SourceScore=Score, @SourceInsure=InsureScore FROM GameScoreInfo WHERE UserID=@dwUserID

	-- 银行保留
	IF @TransferRetention<>0
	BEGIN
		SET @SurplusScore=@SourceInsure-@lTransferScore
		IF @SurplusScore<@TransferRetention
		BEGIN
			SET @strErrorDescribe=N'非常抱歉,转账后您银行的余额不能少于'+LTRIM(@TransferRetention)+'金币'
			RETURN 7
		END
	END

	declare @Ret int
	declare @ScoreOP bigint
	set @ScoreOP = -@lTransferScore
	exec @Ret = proc_BankOp @dwUserID,@ScoreOP
	-- 金币判断
	if @Ret <> 0
	BEGIN
		-- 错误信息
		SET @strErrorDescribe=N'您当前银行的游戏币余额不足，游戏币转账失败！'
		RETURN 4
	END

	-- 查询锁定
	DECLARE @LockKindID INT
	DECLARE @LockServerID INT
	SELECT @LockKindID=KindID, @LockServerID=ServerID FROM GameScoreLocker(nolock) WHERE UserID=@dwUserID

	-- 设置信息
	SET @strErrorDescribe=N'转账 '+LTRIM(STR(@lTransferScore))+' 游戏币到“'+@strNickName+'”的银行操作成功，请查验您的帐户信息！'

	-- 计算变量
	SET @InsureRevenue=0
	IF (@MemberOrder=10 OR @MemberOrder=5) AND (@TargetMemberOrder<>5 AND @TargetMemberOrder<>10)
	BEGIN
		SET @InsureRevenue=@lTransferScore*@RevenueRate/1000
		--退税
		exec proc_BankOp @dwUserID,@InsureRevenue
		set @VariationInsure+=@InsureRevenue
	END
	SET @VariationInsure=-@lTransferScore

--ROLLBACK TRAN
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--SET @strErrorDescribe=N'手续费'+LTRIM(@VariationInsure)+'金币'+LTRIM(@RevenueRate)+'_'+LTRIM(@lTransferScore)
--RETURN 7

	-- 税收封顶
	IF @MaxTax<>0
	BEGIN
		IF @InsureRevenue > @MaxTax
			SET @InsureRevenue=@MaxTax
	END

	-- 扣除金币
--	UPDATE GameScoreInfo SET InsureScore=InsureScore+@VariationInsure,Revenue=Revenue+@InsureRevenue WHERE UserID=@dwUserID
	UPDATE GameScoreInfo SET Revenue=Revenue+@InsureRevenue WHERE UserID=@dwUserID

	set @ScoreOP=@lTransferScore-@InsureRevenue
	exec proc_BankOp @TargetUserID,@ScoreOP

	DECLARE @ScoreFrom BIGINT
	DECLARE @ScoreTo BIGINT
	SET @ScoreFrom=@lTransferScore
	SET @ScoreTo=@lTransferScore-@InsureRevenue
	EXEC THRecordDB.dbo.GSP_GR_DJ_PuTong2PuTong @dwUserID,@TargetUserID,@ScoreFrom,@ScoreTo

	-- 记录日志
	INSERT INTO RecordInsure(KindID,ServerID,SourceUserID,SourceGold,SourceBank,
		TargetUserID,TargetGold,TargetBank,SwapScore,Revenue,IsGamePlaza,TradeType,ClientIP,CollectNote)
	VALUES(@wKindID,@wServerID,@dwUserID,@SourceScore,@SourceInsure,@TargetUserID,@TargetScore,@TargetInsure,
		@lTransferScore-@InsureRevenue,@InsureRevenue,0,3,@strClientIP,@strTransRemark)

	DECLARE @Insure_ID INT
	SET @Insure_ID=0
	SELECT @Insure_ID=@@identity
	UPDATE THAccountsDB.dbo.AccountsInfo SET SourceInsureID=@Insure_ID WHERE UserID=@dwUserID
	UPDATE THAccountsDB.dbo.AccountsInfo SET TargetInsureID=@Insure_ID WHERE UserID=@TargetUserID


	-- 会员转入
	IF @MemberOrder<>10 AND @TargetMemberOrder=10 AND (@PlatformID=1002 OR @PlatformID=2001)
	BEGIN
		DECLARE @ChannelID AS INT
		SELECT @ChannelID=ChannelID FROM THAccountsDB.dbo.AccountsChannel WHERE UserID=@dwUserID
		IF @ChannelID IS NOT NULL
		BEGIN
			DECLARE @ChannelNullity AS TINYINT
			SELECT @ChannelNullity=Nullity FROM THAccountsDB.dbo.ChannelConfig WHERE ChannelID=@ChannelID
			IF @ChannelNullity IS NOT NULL
			BEGIN
				INSERT RecordChannelInScore(PlatformID,ChannelID,UserID,VIPUserID,TransferScore,Nullity)
				VALUES (@PlatformID,@ChannelID,@dwUserID,@TargetUserID,@lTransferScore,@ChannelNullity)
			END
		END
	END

	-- 会员转出
	IF @MemberOrder=10 AND @TargetMemberOrder<>10 AND (@TargetPlatformID=1002 OR @TargetPlatformID=2001)
	BEGIN
		DECLARE @TargetChannelID AS INT
		SELECT @TargetChannelID=ChannelID FROM THAccountsDB.dbo.AccountsChannel WHERE UserID=@TargetUserID
		IF @TargetChannelID IS NOT NULL
		BEGIN
			DECLARE @TargetNullity AS TINYINT
			SELECT @TargetNullity=Nullity FROM THAccountsDB.dbo.ChannelConfig WHERE ChannelID=@TargetChannelID
			IF @TargetNullity IS NOT NULL
			BEGIN
				INSERT RecordChannelOutScore(PlatformID,ChannelID,UserID,VIPUserID,TransferScore,Nullity)
				VALUES (@TargetPlatformID,@TargetChannelID,@TargetUserID,@dwUserID,@lTransferScore,@TargetNullity)
			END
		END
	END

	-- 输出结果
	SELECT @dwUserID AS UserID, @SourceScore AS SourceScore, @SourceInsure AS SourceInsure, 0 AS VariationScore,
		@VariationInsure AS VariationInsure, @InsureRevenue AS InsureRevenue, @LockKindID AS KindID, @LockServerID AS ServerID

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 查询银行
CREATE PROC GSP_GR_QueryUserInsureInfo
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @Score BIGINT
DECLARE @Insure BIGINT
DECLARE @Beans DECIMAL(18, 2)
DECLARE @ServerID SMALLINT

-- 执行逻辑
BEGIN

	-- 查询用户
--	DECLARE @LogonPass AS NCHAR(32)
--	SELECT @LogonPass=LogonPass FROM THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 密码判断
--	IF @LogonPass<>@strPassword
--	BEGIN
--		SET @strErrorDescribe=N'您的银行查询密码不正确，银行信息查询失败！'
--		RETURN 1
--	END

	-- 银行税率
	DECLARE @RevenueRateTake AS INT
	DECLARE @RevenueRateTransfer AS INT
	DECLARE @RevenueRateTransferMember AS INT
	DECLARE @TransferPrerequisite AS BIGINT  
	DECLARE	@EnjoinTransfer AS TINYINT
	SELECT @RevenueRateTake=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'RevenueRateTake'
	SELECT @RevenueRateTransfer=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'RevenueRateTransfer'
	SELECT @RevenueRateTransferMember=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'RevenueRateTransferMember'
	SELECT @TransferPrerequisite=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferPrerequisite'
	SELECT @EnjoinTransfer=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferStauts'

	-- 参数调整
	IF @EnjoinTransfer IS NULL SET @EnjoinTransfer=0
	IF @RevenueRateTake IS NULL SET @RevenueRateTake=1
	IF @RevenueRateTransfer IS NULL SET @RevenueRateTransfer=1	
	IF @TransferPrerequisite IS NULL SET @TransferPrerequisite=0	
	IF @RevenueRateTransferMember IS NULL SET @RevenueRateTransfer=0

	-- 查询房间
	SELECT @ServerID=ServerID FROM GameScoreLocker(NOLOCK) WHERE UserID=@dwUserID

	-- 查询积分
	SELECT @Score=Score, @Insure=InsureScore FROM GameScoreInfo(NOLOCK) WHERE UserID=@dwUserID

	-- 查询游戏豆
	SELECT @Beans=Currency FROM UserCurrencyInfo(NOLOCK) WHERE UserID=@dwUserID

	-- 数据调整
	IF @Score IS NULL SET @Score=0
	IF @Insure IS NULL SET @Insure=0
	IF @Beans IS NULL SET @Beans=0
	IF @ServerID IS NULL SET @ServerID=0

	-- 输出结果
	SELECT @dwUserID AS UserID, @Score AS Score, @Insure AS Insure, @Beans AS Beans, @ServerID AS ServerID, @RevenueRateTake AS RevenueTake, 
		   @RevenueRateTransfer AS RevenueTransfer, @RevenueRateTransferMember AS RevenueTransferMember, @TransferPrerequisite AS TransferPrerequisite,
		   @EnjoinTransfer AS EnjoinTransfer

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 银行登录
CREATE PROC GSP_GR_LogonInsure
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

	-- 查询用户
	DECLARE @UserID INT
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	DECLARE @InsurePass AS NCHAR(32)
	DECLARE	@MachineID NVARCHAR(32)
	DECLARE @MoorMachine AS TINYINT
	SELECT @UserID=UserID, @InsurePass=InsurePass, @Nullity=Nullity, @StunDown=StunDown, @MoorMachine=MoorMachine, @MachineID=LastLogonMachine
	FROM THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在或者密码输入有误，请查证后再次尝试！'
		RETURN 1
	END	

	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 2
	END	

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 2
	END	

	-- 固定机器
	IF @MoorMachine=1
	BEGIN
		IF @MachineID<>@strMachineID
		BEGIN
			SET @strErrorDescribe=N'您的帐号已开通“绑定主机”服务，请登录原主机进入“个人信息”自行解绑！谢谢！'
			RETURN 1
		END
	END

	-- 密码判断
	IF @InsurePass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的保险箱密码不正确，请查证后再次尝试！'
		RETURN 3
	END

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------

-- 转账金币
CREATE PROC GSP_GR_UserTransferScore
	@dwUserID INT,								-- 用户 I D
	@lTransferScore BIGINT,						-- 金币数目
	@strPassword NCHAR(32),						-- 用户密码
	@strNickName NVARCHAR(31),					-- 用户昵称
	@strTransRemark NVARCHAR(32),				-- 转账备注
	@wKindID SMALLINT,							-- 游戏 I D
	@wServerID SMALLINT,						-- 房间 I D
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 金币变量
DECLARE @SourceScore BIGINT
DECLARE @SourceInsure BIGINT

DECLARE @InsureRevenue BIGINT
DECLARE @VariationInsure BIGINT

-- 执行逻辑
BEGIN
	-- 辅助变量
	DECLARE @EnjoinLogon INT
	DECLARE @EnjoinInsure INT
	DECLARE @EnjoinTransfer INT

	-- 系统暂停
	SELECT @EnjoinInsure=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'EnjoinInsure'
	IF @EnjoinInsure IS NOT NULL AND @EnjoinInsure<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'EnjoinInsure'
		RETURN 2
	END	
	
	-- 转账暂停
	SELECT @EnjoinTransfer=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferStauts'
	IF @EnjoinTransfer IS NOT NULL AND @EnjoinTransfer<>1
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferStauts'
		RETURN 3
	END	

	-- 效验地址
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您所在的 IP 地址的游戏服务权限，请联系客户服务中心了解详细情况！'
		RETURN 4
	END
	
	-- 效验机器
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineID AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您的机器的游戏服务权限，请联系客户服务中心了解详细情况！'
		RETURN 7
	END

	-- 查询用户
	DECLARE @UserID INT
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	DECLARE @InsurePass AS NCHAR(32)
	DECLARE	@MachineID NVARCHAR(32)
	DECLARE @MemberOrder AS TINYINT
	DECLARE @MoorMachine AS TINYINT
	DECLARE @PlatformID AS INT
	SELECT @UserID=UserID, @InsurePass=InsurePass, @Nullity=Nullity, @StunDown=StunDown, @MoorMachine=MoorMachine, 
	@MemberOrder=MemberOrder, @MachineID=LastLogonMachine, @PlatformID=PlatformID
	FROM THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在或者密码输入有误，请查证后再次尝试！'
		RETURN 1
	END	

	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 2
	END	

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 2
	END	

	IF @MachineID<>@strMachineID
	BEGIN
		SET @strErrorDescribe=N'请重新登录！'
		RETURN 1
	END
	
	-- 固定机器
	IF @MoorMachine=1
	BEGIN
		IF @MachineID<>@strMachineID
		BEGIN
			SET @strErrorDescribe=N'您的帐号使用固定机器登录功能，您现所使用的机器不是所指定的机器！'
			RETURN 1
		END
	END

	-- 密码判断
	IF @InsurePass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的保险箱密码不正确或者输入有误，请查证后再次尝试！'
		RETURN 3
	END

	-- 金币判断
	DECLARE @TransferPrerequisite AS BIGINT
	SELECT @TransferPrerequisite=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferPrerequisite'
	IF @TransferPrerequisite IS NULL SET @TransferPrerequisite=0
	IF @lTransferScore<@TransferPrerequisite
	BEGIN
		SET @strErrorDescribe=N'从银行转账的游戏币数目不能少于 '+LTRIM(STR(@TransferPrerequisite))+'，游戏币转账失败！'
		RETURN 4
	END

	-- 目标用户
	DECLARE @TargetUserID INT
	DECLARE @TargetMemberOrder AS TINYINT
	DECLARE @TargetPlatformID AS INT
	SELECT @TargetUserID=UserID, @TargetMemberOrder=MemberOrder, @TargetPlatformID=PlatformID FROM THAccountsDB.dbo.AccountsInfo WHERE NickName=@strNickName	
--	IF @cbByNickName=1
--		SELECT @TargetUserID=UserID FROM THAccountsDB.dbo.AccountsInfo WHERE NickName=@strNickName
--	ELSE
--		SELECT @TargetUserID=UserID FROM THAccountsDB.dbo.AccountsInfo WHERE GameID=@strNickName	

	-- 查询用户
	IF @TargetUserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'您所要转账的用户“'+@strNickName+'”不存在或者输入有误，请查证后再次尝试！'
		RETURN 5
	END

	-- 相同判断
	IF @TargetUserID=@dwUserID
	BEGIN
		SET @strErrorDescribe=N'不能使用自己的帐号为自己转账游戏币，请查证后再次尝试！'
		RETURN 6
	END

	-- 会员判断
	IF @MemberOrder<>10 AND @TargetMemberOrder<>10 AND @MemberOrder<>5 AND @TargetMemberOrder<>5
	BEGIN
		SET @strErrorDescribe=N'抱歉，您不是超级会员，没有此功能权限！'
		RETURN 7
	END

	-- 金币查询
	DECLARE @TargetScore BIGINT
	DECLARE @TargetInsure BIGINT
	SELECT @TargetScore=Score, @TargetInsure=InsureScore FROM GameScoreInfo(NOLOCK) WHERE UserID=@TargetUserID

	-- 插入判断
	IF @TargetScore IS NULL
	BEGIN
		-- 插入资料
		INSERT INTO GameScoreInfo (UserID,LastLogonIP,RegisterIP) VALUES (@TargetUserID,@strClientIP,@strClientIP)

		-- 游戏信息
		SELECT @TargetScore=Score, @TargetInsure=InsureScore FROM GameScoreInfo(NOLOCK) WHERE UserID=@TargetUserID
	END

	-- 银行税收	
	DECLARE @MaxTax BIGINT
	DECLARE @RevenueRate INT
	IF @MemberOrder = 0
	BEGIN
		SELECT @MaxTax=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferMaxTax'
		SELECT @RevenueRate=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'RevenueRateTransfer'

		-- 税收调整
		IF @RevenueRate IS NULL SET @RevenueRate=1
	END ELSE
	BEGIN
		SELECT @MaxTax=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferMaxTax'
		SELECT @RevenueRate=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'RevenueRateTransferMember'		
		
		-- 税收调整
		IF @RevenueRate IS NULL SET @RevenueRate=0
	END	
	
	-- 税收调整
	IF @RevenueRate>300 SET @RevenueRate=300	

	-- 银行保留
	DECLARE @TransferRetention INT	-- 至少保留
	DECLARE @SurplusScore BIGINT	-- 转后银行
	SELECT @TransferRetention=ISNULL(StatusValue,0) FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferRetention'

	-- 游戏信息
	SELECT @SourceScore=Score, @SourceInsure=InsureScore FROM GameScoreInfo WHERE UserID=@dwUserID
	if @SourceInsure is null
		set @SourceInsure = 0
	
	-- 银行保留
	IF @TransferRetention<>0
	BEGIN
		SET @SurplusScore=@SourceInsure-@lTransferScore
		IF @SurplusScore<@TransferRetention
		BEGIN
			SET @strErrorDescribe=N'非常抱歉,转账后您银行的余额不能少于'+LTRIM(@TransferRetention)+'金币'
			RETURN 7
		END
	END

	declare @Ret int
	exec @Ret=proc_BankOp @dwUserID,0
	
	if @Ret <> 0
	BEGIN
		-- 错误信息
		SET @strErrorDescribe=N'您当前银行的游戏币余额不足，游戏币转账失败！'
		RETURN 4
	END


	-- 查询锁定
	DECLARE @LockKindID INT
	DECLARE @LockServerID INT
	SELECT @LockKindID=KindID, @LockServerID=ServerID FROM GameScoreLocker WHERE UserID=@dwUserID

	-- 设置信息
	SET @strErrorDescribe=N'转账 '+LTRIM(STR(@lTransferScore))+' 游戏币到“'+@strNickName+'”的银行操作成功，请查验您的帐户信息！'

	-- 计算变量
	SET @InsureRevenue=0
	IF (@MemberOrder=10 OR @MemberOrder=5) AND (@TargetMemberOrder<>5 AND @TargetMemberOrder<>10)
	BEGIN
		SET @InsureRevenue=@lTransferScore*@RevenueRate/1000
	END
	SET @VariationInsure=-@lTransferScore
--ROLLBACK TRAN
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--SET @strErrorDescribe=N'手续费'+LTRIM(@VariationInsure)+'金币'+LTRIM(@RevenueRate)+'_'+LTRIM(@lTransferScore)
--RETURN 7

	-- 税收封顶
	IF @MaxTax<>0
	BEGIN
		IF @InsureRevenue > @MaxTax
			SET @InsureRevenue=@MaxTax
	END

	-- 扣除金币
--	UPDATE GameScoreInfo SET InsureScore=InsureScore+@VariationInsure,Revenue=Revenue+@InsureRevenue WHERE UserID=@dwUserID
--	UPDATE GameScoreInfo SET InsureScore=InsureScore+@VariationInsure,Revenue=Revenue+@InsureRevenue WHERE UserID=@dwUserID

	-- 增加金币
--	UPDATE GameScoreInfo SET InsureScore=InsureScore+@lTransferScore-@InsureRevenue WHERE UserID=@TargetUserID

	DECLARE @ScoreFrom BIGINT
	DECLARE @ScoreTo BIGINT
	SET @ScoreFrom=@lTransferScore
	SET @ScoreTo=@lTransferScore-@InsureRevenue
	EXEC THRecordDB.dbo.GSP_GR_DJ_PuTong2PuTong @dwUserID,@TargetUserID,@ScoreFrom,@ScoreTo

	-- 记录日志
	INSERT INTO RecordInsure(KindID,ServerID,SourceUserID,SourceGold,SourceBank,
		TargetUserID,TargetGold,TargetBank,SwapScore,Revenue,IsGamePlaza,TradeType,ClientIP,CollectNote)
	VALUES(@wKindID,@wServerID,@dwUserID,@SourceScore,@SourceInsure,@TargetUserID,@TargetScore,@TargetInsure,
		@lTransferScore-@InsureRevenue,@InsureRevenue,0,3,@strClientIP,@strTransRemark)

	DECLARE @Insure_ID INT
	SET @Insure_ID=0
	SELECT @Insure_ID=@@identity
	UPDATE THAccountsDB.dbo.AccountsInfo SET SourceInsureID=@Insure_ID WHERE UserID=@dwUserID
	UPDATE THAccountsDB.dbo.AccountsInfo SET TargetInsureID=@Insure_ID WHERE UserID=@TargetUserID

	-- 会员转入
	IF @MemberOrder<>10 AND @TargetMemberOrder=10 AND (@PlatformID=1002 OR @PlatformID=2001)
	BEGIN
		DECLARE @ChannelID AS INT
		SELECT @ChannelID=ChannelID FROM THAccountsDB.dbo.AccountsChannel WHERE UserID=@dwUserID
		IF @ChannelID IS NOT NULL
		BEGIN
			DECLARE @ChannelNullity AS TINYINT
			SELECT @ChannelNullity=Nullity FROM THAccountsDB.dbo.ChannelConfig WHERE ChannelID=@ChannelID
			IF @ChannelNullity IS NOT NULL
			BEGIN
				INSERT RecordChannelInScore(PlatformID,ChannelID,UserID,VIPUserID,TransferScore,Nullity)
				VALUES (@PlatformID,@ChannelID,@dwUserID,@TargetUserID,@lTransferScore,@ChannelNullity)
			END
		END
	END

	-- 会员转出
	IF @MemberOrder=10 AND @TargetMemberOrder<>10 AND (@TargetPlatformID=1002 OR @TargetPlatformID=2001)
	BEGIN
		DECLARE @TargetChannelID AS INT
		SELECT @TargetChannelID=ChannelID FROM THAccountsDB.dbo.AccountsChannel WHERE UserID=@TargetUserID
		IF @TargetChannelID IS NOT NULL
		BEGIN
			DECLARE @TargetNullity AS TINYINT
			SELECT @TargetNullity=Nullity FROM THAccountsDB.dbo.ChannelConfig WHERE ChannelID=@TargetChannelID
			IF @TargetNullity IS NOT NULL
			BEGIN
				INSERT RecordChannelOutScore(PlatformID,ChannelID,UserID,VIPUserID,TransferScore,Nullity)
				VALUES (@TargetPlatformID,@TargetChannelID,@TargetUserID,@dwUserID,@lTransferScore,@TargetNullity)
			END
		END
	END

	-- 输出结果
	SELECT @dwUserID AS UserID, @SourceScore AS SourceScore, @SourceInsure AS SourceInsure, 0 AS VariationScore,
		@VariationInsure AS VariationInsure, @InsureRevenue AS InsureRevenue, @LockKindID AS KindID, @LockServerID AS ServerID

END

RETURN 0

GO




----------------------------------------------------------------------------------------------------
-- 转账金币
create PROC GSP_GR_UserTransferScoreGameID
	@dwUserID INT,								-- 用户 I D
	@lTransferScore BIGINT,						-- 金币数目
	@strPassword NCHAR(32),						-- 用户密码
	@strDynamicPassword NCHAR(32),				-- 动态密码
	@dwGameID INT,								-- 用户GameID
	@strTransRemark NVARCHAR(32),				-- 转账备注
	@wKindID SMALLINT,							-- 游戏 I D
	@wServerID SMALLINT,						-- 房间 I D
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 金币变量
DECLARE @SourceScore BIGINT
DECLARE @SourceInsure BIGINT

DECLARE @InsureRevenue BIGINT
DECLARE @VariationInsure BIGINT

-- 执行逻辑
BEGIN
	-- 辅助变量
	DECLARE @EnjoinLogon INT
	DECLARE @EnjoinInsure INT
	DECLARE @EnjoinTransfer INT

	-- 系统暂停
	SELECT @EnjoinInsure=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'EnjoinInsure'
	IF @EnjoinInsure IS NOT NULL AND @EnjoinInsure<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'EnjoinInsure'
		RETURN 2
	END	
	
	-- 转账暂停
	SELECT @EnjoinTransfer=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferStauts'
	IF @EnjoinTransfer IS NOT NULL AND @EnjoinTransfer<>1
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferStauts'
		RETURN 3
	END	

	-- 效验地址
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您所在的 IP 地址的游戏服务权限，请联系客户服务中心了解详细情况！'
		RETURN 4
	END
	
	-- 效验机器
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineID AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您的机器的游戏服务权限，请联系客户服务中心了解详细情况！'
		RETURN 7
	END

	-- 查询用户
	DECLARE @UserID INT
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	DECLARE @InsurePass AS NCHAR(32)
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE	@MachineID NVARCHAR(32)
	DECLARE @MemberOrder AS TINYINT
	DECLARE @MoorMachine AS TINYINT
	DECLARE @PlatformID AS INT
	declare @IsBindMobile as tinyint
	declare @MustChangePWD tinyint
	declare @SourceNick as NVARCHAR(32)
	declare @memIdent1 int
	declare @memIdent2 int
	declare @DynamicPass as NVARCHAR(32)
	SELECT @DynamicPass=DynamicPass,@UserID=UserID, @InsurePass=InsurePass, @Nullity=Nullity, @StunDown=StunDown, @MoorMachine=MoorMachine,@IsBindMobile= (case when len(RegisterMobile) > 0 then 1 else 0 end), 
	@MemberOrder=MemberOrder, @MachineID=LastLogonMachine, @PlatformID=PlatformID,@SourceNick=NickName,@LogonPass=LogonPass,@MustChangePWD=MustChangePassWord,@memIdent1=memIdent
	FROM THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在或者密码输入有误，请查证后再次尝试！'
		RETURN 1
	END	
	
	-- -- if @LogonPass = @InsurePass
	-- BEGIN
	-- 	SET @strErrorDescribe=N'银行密码和登录密码不能一样！'
	--	RETURN 1
	-- END	
	
	if @MustChangePWD <> 0
	begin
		SET @strErrorDescribe=N'请先开通保险箱再操作！'
		RETURN 1
	end
	
	--if @IsBindMobile = 0
	--begin
	--	SET @strErrorDescribe=N'请先绑定手机号再尝试此操作！'
	--	RETURN 1
	--end
	
	

	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 2
	END	
	
	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 2
	END	

	IF @MachineID<>@strMachineID
	BEGIN
		SET @strErrorDescribe=N'请重新登录！'
		RETURN 1
	END

	-- 固定机器
	IF @MoorMachine=1
	BEGIN
		IF @MachineID<>@strMachineID
		BEGIN
			SET @strErrorDescribe=N'您的帐号使用固定机器登录功能，您现所使用的机器不是所指定的机器！'
			RETURN 1
		END
	END

	-- 密码判断
	IF @InsurePass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的保险箱密码不正确或者输入有误，请查证后再次尝试！'
		RETURN 3
	END
	
	-- 动态密码判断
	IF @DynamicPass<>@strDynamicPassword
	BEGIN
		SET @strErrorDescribe=N'密码错误，请查证后再次尝试！'
		RETURN 11
	END

	-- 金币判断
	DECLARE @TransferPrerequisite AS BIGINT
	SELECT @TransferPrerequisite=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferPrerequisite'
	IF @TransferPrerequisite IS NULL SET @TransferPrerequisite=0
	IF @lTransferScore<@TransferPrerequisite
	BEGIN
		SET @strErrorDescribe=N'从银行转账的游戏币数目不能少于 '+LTRIM(STR(@TransferPrerequisite))+'，游戏币转账失败！'
		RETURN 4
	END


	-- 目标用户
	DECLARE @strNickName NVARCHAR(31)
	DECLARE @TargetUserID INT
	DECLARE @TargetMemberOrder AS TINYINT
	DECLARE @TargetPlatformID AS INT
	SELECT @TargetUserID=UserID, @TargetMemberOrder=MemberOrder, @TargetPlatformID=PlatformID, @strNickName=NickName,@memIdent2=memIdent FROM THAccountsDB.dbo.AccountsInfo WHERE GameID=@dwGameID	
--	IF @cbByNickName=1
--		SELECT @TargetUserID=UserID FROM THAccountsDB.dbo.AccountsInfo WHERE NickName=@strNickName
--	ELSE
--		SELECT @TargetUserID=UserID FROM THAccountsDB.dbo.AccountsInfo WHERE GameID=@strNickName	

	-- 查询用户
	IF @TargetUserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'您所要转账的用户“'+@strNickName+'”不存在或者输入有误，请查证后再次尝试！'
		RETURN 5
	END

	-- 相同判断
	IF @TargetUserID=@dwUserID
	BEGIN
		SET @strErrorDescribe=N'不能使用自己的帐号为自己转账游戏币，请查证后再次尝试！'
		RETURN 6
	END

	-- 会员判断
	IF @MemberOrder<>10 AND @TargetMemberOrder<>10 AND @MemberOrder<>5 AND @TargetMemberOrder<>5
	BEGIN
		SET @strErrorDescribe=N'抱歉，您不是超级会员，没有此功能权限！'
		RETURN 7
	END
	
	-- 会员等级判断,1 是最高级；10和2是同级关系，只不过10是奖励VIP的；3，4，5是同级；
	if @MemberOrder > 0 and @TargetMemberOrder > 0
	begin
		if @memIdent2 = @memIdent1 or (@memIdent2 > 2 and @memIdent2 < 10 and @memIdent1 > 2 and @memIdent1 < 10) or (@memIdent1 = 2 and @memIdent2 =10) or (@memIdent2=2 and @memIdent1 =10)
		begin
			SET @strErrorDescribe=N'抱歉，同级不能赠送！'
			RETURN 8
		end
	end

	-- 金币查询
	DECLARE @TargetScore BIGINT
	DECLARE @TargetInsure BIGINT
	SELECT @TargetScore=Score, @TargetInsure=InsureScore FROM GameScoreInfo(NOLOCK) WHERE UserID=@TargetUserID

	-- 插入判断
	IF @TargetScore IS NULL
	BEGIN
		-- 插入资料
		INSERT INTO GameScoreInfo (UserID,LastLogonIP,RegisterIP) VALUES (@TargetUserID,@strClientIP,@strClientIP)

		-- 游戏信息
		SELECT @TargetScore=Score, @TargetInsure=InsureScore FROM GameScoreInfo(NOLOCK) WHERE UserID=@TargetUserID
	END

	-- 银行税收	
	DECLARE @MaxTax BIGINT
	DECLARE @RevenueRate INT
	IF @MemberOrder = 0
	BEGIN
		SELECT @MaxTax=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferMaxTax'
		SELECT @RevenueRate=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'RevenueRateTransfer'

		-- 税收调整
		IF @RevenueRate IS NULL SET @RevenueRate=1
	END ELSE
	BEGIN
		SELECT @MaxTax=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferMaxTax'
		SELECT @RevenueRate=StatusValue FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'RevenueRateTransferMember'		
		
		-- 税收调整
		IF @RevenueRate IS NULL SET @RevenueRate=0
	END	

	-- 税收调整
	IF @RevenueRate>300 SET @RevenueRate=300	

	-- 银行保留
	DECLARE @TransferRetention INT	-- 至少保留
	DECLARE @SurplusScore BIGINT	-- 转后银行
	SELECT @TransferRetention=ISNULL(StatusValue,0) FROM THAccountsDB.dbo.SystemStatusInfo WHERE StatusName=N'TransferRetention'

	-- 游戏信息
	SELECT @SourceScore=Score, @SourceInsure=InsureScore FROM GameScoreInfo WHERE UserID=@dwUserID

	if @SourceInsure is null
		set @SourceInsure = 0
	
	-- 银行保留
	IF @TransferRetention<>0
	BEGIN
		SET @SurplusScore=@SourceInsure-@lTransferScore
		IF @SurplusScore<@TransferRetention
		BEGIN
			SET @strErrorDescribe=N'非常抱歉,转账后您银行的余额不能少于'+LTRIM(@TransferRetention)+'金币'
			RETURN 7
		END
	END
	declare @Ret int
	declare @ScoreOp bigint
	set @ScoreOp = -@lTransferScore
	exec @Ret=proc_BankOp @dwUserID,@ScoreOp
	-- 金币判断
	IF @Ret <> 0
	BEGIN
		-- 错误信息
		SET @strErrorDescribe=N'您当前银行的游戏币余额不足，游戏币转账失败！'
		RETURN 4
	END

	-- 查询锁定
	DECLARE @LockKindID INT
	DECLARE @LockServerID INT
	SELECT @LockKindID=KindID, @LockServerID=ServerID FROM GameScoreLocker(nolock) WHERE UserID=@dwUserID

	-- 设置信息
	SET @strErrorDescribe=N'转账 '+LTRIM(STR(@lTransferScore))+' 游戏币到“'+@strNickName+'”的银行操作成功，请查验您的帐户信息！'

	-- 计算变量
	SET @InsureRevenue=0
	IF (@MemberOrder=10 OR @MemberOrder=5) AND (@TargetMemberOrder<>5 AND @TargetMemberOrder<>10)
	BEGIN
		SET @InsureRevenue=@lTransferScore*@RevenueRate/1000
		exec proc_BankOp @dwUserID,@InsureRevenue
		set @VariationInsure+=@InsureRevenue
		update [THAccountsDB].[dbo].[AccountsInfo] set [Payed] = 1 where UserID=@TargetUserID
	END
	SET @VariationInsure=-@lTransferScore
--ROLLBACK TRAN
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--SET @strErrorDescribe=N'手续费'+LTRIM(@VariationInsure)+'金币'+LTRIM(@RevenueRate)+'_'+LTRIM(@lTransferScore)
--RETURN 7

	-- 税收封顶
	IF @MaxTax<>0
	BEGIN
		IF @InsureRevenue > @MaxTax
			SET @InsureRevenue=@MaxTax
	END
	
	declare @scvipid int
	declare @stat int
	declare @vipuid int
	declare @ycscores bigint
	declare @ycye bigint
	declare @zzjbs bigint
	declare @abnormalID int
	declare @zzjbsI bigint
	declare @bsI int
	declare @ss bigint
	declare @vipuuid int
	declare @ycrec int

	--  pt 转到VIP
	if @MemberOrder = 0 and @TargetMemberOrder > 0
	begin
		 select @zzjbsI=[scores],@bsI=[isyc],@vipuuid=[vipUID] FROM [THRecordDB].[dbo].[abnormalIdent](nolock) where [UserID] = @dwUserID
		 select @ycrec=[status] FROM [THRecordDB].[dbo].[abnormalExamine](nolock) where [UserID] = @dwUserID and [status] = 3 
		 if @ycrec is null set @ycrec = 0
		 if @bsI is null
		 begin
			select top 1 @scvipid=[SourceUserID],@zzjbs=[SwapScore],@ss=[Revenue] FROM [THTreasureDB].[dbo].[RecordInsure](nolock) where [TradeType] = 3 and [TargetUserID] = @dwUserID order by [RecordID] desc
			if @scvipid is not null
			begin
				if ((@SourceScore+@SourceInsure) > (@zzjbs+@ss)*0.4) and (@scvipid <> @TargetUserID)
				begin
					insert into [THRecordDB].[dbo].[abnormalIdent] values(@dwUserID,@zzjbs+@ss,1,@scvipid)
					insert into [THRecordDB].[dbo].[abnormalExamine]([UserID],[targetUID],[status],[inserttime],[scores],[Revenue]) 
					values(@dwUserID,@TargetUserID,3,GETDATE(),@lTransferScore,0)
					set @abnormalID = @@identity
					-- 记录日志
					INSERT INTO RecordInsure(KindID,ServerID,SourceUserID,SourceGold,SourceBank,
					TargetUserID,TargetGold,TargetBank,SwapScore,Revenue,IsGamePlaza,TradeType,ClientIP,CollectNote,SourceMember,TargetMember,SourceMemIdent,TargetMemIdent,yvbs)
					VALUES(@wKindID,@wServerID,@dwUserID,@SourceScore,@SourceInsure,@TargetUserID,@TargetScore,@TargetInsure,
					@lTransferScore,@InsureRevenue,0,4,@strClientIP,@strTransRemark,@MemberOrder,@TargetMemberOrder,@memIdent1,@memIdent2,@abnormalID)

				
					SELECT @dwUserID AS UserID, @SourceScore AS SourceScore, @SourceInsure AS SourceInsure, 0 AS VariationScore,
					@VariationInsure AS VariationInsure, @InsureRevenue AS InsureRevenue, @LockKindID AS KindID, @LockServerID AS ServerID
					return 9
				end	
			end
		 end
		 else if @bsI = 1
		 begin
			insert into [THRecordDB].[dbo].[abnormalExamine]([UserID],[targetUID],[status],[inserttime],[scores],[Revenue]) 
			values(@dwUserID,@TargetUserID,3,GETDATE(),@lTransferScore,@InsureRevenue)
			set @abnormalID = @@identity
			-- 记录日志
			INSERT INTO RecordInsure(KindID,ServerID,SourceUserID,SourceGold,SourceBank,
			TargetUserID,TargetGold,TargetBank,SwapScore,Revenue,IsGamePlaza,TradeType,ClientIP,CollectNote,SourceMember,TargetMember,SourceMemIdent,TargetMemIdent,yvbs)
			VALUES(@wKindID,@wServerID,@dwUserID,@SourceScore,@SourceInsure,@TargetUserID,@TargetScore,@TargetInsure,
			@lTransferScore,@InsureRevenue,0,4,@strClientIP,@strTransRemark,@MemberOrder,@TargetMemberOrder,@memIdent1,@memIdent2,@abnormalID)
		
			SELECT @dwUserID AS UserID, @SourceScore AS SourceScore, @SourceInsure AS SourceInsure, 0 AS VariationScore,
			@VariationInsure AS VariationInsure, @InsureRevenue AS InsureRevenue, @LockKindID AS KindID, @LockServerID AS ServerID
			return 9
		 end
		 else if @bsI = 0 
		 begin
			if (((@SourceScore+@SourceInsure) > (@zzjbsI*0.4)) and (@vipuuid <> @TargetUserID)) or (@ycrec > 1)
			begin
				--set @strErrorDescribe = 'ptzhuan'
				insert into [THRecordDB].[dbo].[abnormalExamine]([UserID],[targetUID],[status],[inserttime],[scores],[Revenue]) 
				values(@dwUserID,@TargetUserID,3,GETDATE(),@lTransferScore,0)
				set @abnormalID = @@identity
				-- 记录日志
				INSERT INTO RecordInsure(KindID,ServerID,SourceUserID,SourceGold,SourceBank,
				TargetUserID,TargetGold,TargetBank,SwapScore,Revenue,IsGamePlaza,TradeType,ClientIP,CollectNote,SourceMember,TargetMember,SourceMemIdent,TargetMemIdent,yvbs)
				VALUES(@wKindID,@wServerID,@dwUserID,@SourceScore,@SourceInsure,@TargetUserID,@TargetScore,@TargetInsure,
				@lTransferScore,@InsureRevenue,0,4,@strClientIP,@strTransRemark,@MemberOrder,@TargetMemberOrder,@memIdent1,@memIdent2,@abnormalID)
			
				SELECT @dwUserID AS UserID, @SourceScore AS SourceScore, @SourceInsure AS SourceInsure, 0 AS VariationScore,
				@VariationInsure AS VariationInsure, @InsureRevenue AS InsureRevenue, @LockKindID AS KindID, @LockServerID AS ServerID
				return 9
			end
		 end 
		 else if @bsI = 2 and @ycrec > 0
		 begin
				--set @strErrorDescribe = 'ptzhuan'
				insert into [THRecordDB].[dbo].[abnormalExamine]([UserID],[targetUID],[status],[inserttime],[scores],[Revenue]) 
				values(@dwUserID,@TargetUserID,3,GETDATE(),@lTransferScore,0)
				set @abnormalID = @@identity
				-- 记录日志
				INSERT INTO RecordInsure(KindID,ServerID,SourceUserID,SourceGold,SourceBank,
				TargetUserID,TargetGold,TargetBank,SwapScore,Revenue,IsGamePlaza,TradeType,ClientIP,CollectNote,SourceMember,TargetMember,SourceMemIdent,TargetMemIdent,yvbs)
				VALUES(@wKindID,@wServerID,@dwUserID,@SourceScore,@SourceInsure,@TargetUserID,@TargetScore,@TargetInsure,
				@lTransferScore,@InsureRevenue,0,4,@strClientIP,@strTransRemark,@MemberOrder,@TargetMemberOrder,@memIdent1,@memIdent2,@abnormalID)
			
				SELECT @dwUserID AS UserID, @SourceScore AS SourceScore, @SourceInsure AS SourceInsure, 0 AS VariationScore,
				@VariationInsure AS VariationInsure, @InsureRevenue AS InsureRevenue, @LockKindID AS KindID, @LockServerID AS ServerID
				return 9
		 end
	end
	
	declare @ycc int
	--  vip 转到普通
	if @MemberOrder > 0 and @TargetMemberOrder = 0
	begin
		 select @zzjbsI=[scores],@bsI=[isyc],@vipuuid=[vipUID] FROM [THRecordDB].[dbo].[abnormalIdent](nolock) where [UserID] = @TargetUserID
		 select @ycrec=[status] FROM [THRecordDB].[dbo].[abnormalExamine](nolock) where [UserID] = @TargetUserID and [status] = 3 
		 if @ycrec is null set @ycrec = 0
		 if @zzjbsI is null
		 begin
			select top 1 @scvipid=[SourceUserID],@zzjbs=[SwapScore],@ss=[Revenue] FROM [THTreasureDB].[dbo].[RecordInsure](nolock) where [TradeType] = 3 and [TargetUserID] = @TargetUserID order by [RecordID] desc
			if @scvipid is null
			begin
				insert into [THRecordDB].[dbo].[abnormalIdent] values(@TargetUserID,@lTransferScore,0,@dwUserID)
			end
			else
			begin
				if (@TargetScore+@TargetInsure) > (@zzjbs+@ss)*0.4 and @scvipid <> @dwUserID
				begin
					insert into [THRecordDB].[dbo].[abnormalIdent] values(@TargetUserID,@lTransferScore,1,@dwUserID)
				end
			end
		 end
		 else if @bsI = 0
		 begin
			if ((@TargetScore+@TargetInsure) > (@zzjbsI*0.4)) and (@vipuuid <> @dwUserID)
			begin
			    -- 异常
				update [THRecordDB].[dbo].[abnormalIdent] set [isyc] = 1 where [UserID] = @TargetUserID
			end
			else
			begin
				update [THRecordDB].[dbo].[abnormalIdent] set scores=@lTransferScore,vipUID=@dwUserID where [UserID] = @TargetUserID
			end
		 end
		 else if @bsI = 2 and @ycrec = 0
		 begin
			update [THRecordDB].[dbo].[abnormalIdent] set [isyc] = 0,scores = @lTransferScore,vipUID = @dwUserID  where [UserID] = @TargetUserID
		 end
	end

	-- 扣除金币
--	UPDATE GameScoreInfo SET InsureScore=InsureScore+@VariationInsure,Revenue=Revenue+@InsureRevenue WHERE UserID=@dwUserID
	UPDATE GameScoreInfo SET Revenue=Revenue+@InsureRevenue WHERE UserID=@dwUserID

	set @ScoreOp = @lTransferScore-@InsureRevenue
	exec proc_BankOp @TargetUserID,@ScoreOp

	DECLARE @ScoreFrom BIGINT
	DECLARE @ScoreTo BIGINT
	SET @ScoreFrom=@lTransferScore
	SET @ScoreTo=@lTransferScore-@InsureRevenue
	EXEC THRecordDB.dbo.GSP_GR_DJ_PuTong2PuTong @dwUserID,@TargetUserID,@ScoreFrom,@ScoreTo

	-- 记录日志
	INSERT INTO RecordInsure(KindID,ServerID,SourceUserID,SourceGold,SourceBank,
		TargetUserID,TargetGold,TargetBank,SwapScore,Revenue,IsGamePlaza,TradeType,ClientIP,CollectNote,SourceMember,TargetMember,SourceMemIdent,TargetMemIdent,yvbs)
	VALUES(@wKindID,@wServerID,@dwUserID,@SourceScore,@SourceInsure,@TargetUserID,@TargetScore,@TargetInsure,
		@lTransferScore-@InsureRevenue,@InsureRevenue,0,3,@strClientIP,@strTransRemark,@MemberOrder,@TargetMemberOrder,@memIdent1,@memIdent2,0)

	DECLARE @Insure_ID INT
	SET @Insure_ID=0
	SELECT @Insure_ID=@@identity
	UPDATE THAccountsDB.dbo.AccountsInfo SET SourceInsureID=@Insure_ID WHERE UserID=@dwUserID
	UPDATE THAccountsDB.dbo.AccountsInfo SET TargetInsureID=@Insure_ID WHERE UserID=@TargetUserID

	-- 会员转入
	IF @MemberOrder<>10 AND @TargetMemberOrder=10 AND (@PlatformID=1002 OR @PlatformID=2001)
	BEGIN
		DECLARE @ChannelID AS INT
		SELECT @ChannelID=ChannelID FROM THAccountsDB.dbo.AccountsChannel WHERE UserID=@dwUserID
		IF @ChannelID IS NOT NULL
		BEGIN
			DECLARE @ChannelNullity AS TINYINT
			SELECT @ChannelNullity=Nullity FROM THAccountsDB.dbo.ChannelConfig WHERE ChannelID=@ChannelID
			IF @ChannelNullity IS NOT NULL
			BEGIN
				INSERT RecordChannelInScore(PlatformID,ChannelID,UserID,VIPUserID,TransferScore,Nullity)
				VALUES (@PlatformID,@ChannelID,@dwUserID,@TargetUserID,@lTransferScore,@ChannelNullity)
			END
		END
	END

	-- 会员转出
	IF @MemberOrder=10 AND @TargetMemberOrder<>10 AND (@TargetPlatformID=1002 OR @TargetPlatformID=2001)
	BEGIN
		DECLARE @TargetChannelID AS INT
		SELECT @TargetChannelID=ChannelID FROM THAccountsDB.dbo.AccountsChannel WHERE UserID=@TargetUserID
		IF @TargetChannelID IS NOT NULL
		BEGIN
			DECLARE @TargetNullity AS TINYINT
			SELECT @TargetNullity=Nullity FROM THAccountsDB.dbo.ChannelConfig WHERE ChannelID=@TargetChannelID
			IF @TargetNullity IS NOT NULL
			BEGIN
				INSERT RecordChannelOutScore(PlatformID,ChannelID,UserID,VIPUserID,TransferScore,Nullity)
				VALUES (@TargetPlatformID,@TargetChannelID,@TargetUserID,@dwUserID,@lTransferScore,@TargetNullity)
			END
		END
	END
	
	-- update [THControlDB].[dbo].[UserCtlInfos] set [TransScore]=-@lTransferScore,TransCount=TransCount+1,LastTransNick=@strNickName where userid = @dwUserID 
	-- update [THControlDB].[dbo].[UserCtlInfos] set [TransScore]=@ScoreOp,TransCount=TransCount+1,LastTransNick=@SourceNick where userid = @TargetUserID
	update [THControlDB].[dbo].[UserCtlInfos] set [TransScore]=-@lTransferScore,LastTransNick=@strNickName where userid = @dwUserID
	update [THControlDB].[dbo].[UserCtlInfos] set [TransScore]=@ScoreOp,LastTransNick=@SourceNick where userid = @TargetUserID
	update [THControlDB].[dbo].[UserCtlInfos] set TransCount=TransCount+1 where userid = @TargetUserID and @MemberOrder > 0 and @TargetMemberOrder = 0
	

	-- 输出结果
	SELECT @dwUserID AS UserID, @SourceScore AS SourceScore, @SourceInsure AS SourceInsure, 0 AS VariationScore,
		@VariationInsure AS VariationInsure, @InsureRevenue AS InsureRevenue, @LockKindID AS KindID, @LockServerID AS ServerID

END

RETURN 0

GO