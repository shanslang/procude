
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_ChannelQuery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_ChannelQuery]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_ChannelBinding]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_ChannelBinding]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 渠道查询
CREATE PROC GSP_MB_ChannelQuery
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
	DECLARE @ChannelReward AS INT
	DECLARE @PlatformID AS INT

	-- 查询密码
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

	-- 账户判断
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的账户信息有误，请查证后再次尝试！'
		RETURN 1
	END

	-- 密码判断
--	IF @LogonPass<>@strPassword
--	BEGIN
--		SET @strErrorDescribe=N'您的密码输入有误，请查证后再次尝试111！'+@LogonPass+'___'+@strPassword
--		RETURN 2
--	END

	-- 查询状态
	SELECT @BindingStatus=BindingStatus FROM AccountsChannel WHERE UserID=@dwUserID

	-- 查询奖励
	SELECT @ChannelReward=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'ChannelReward'

	-- 数据调整
	IF @BindingStatus IS NULL SET @BindingStatus=0
	IF @ChannelReward IS NULL SET @ChannelReward=0

	-- 查询平台
	SELECT @PlatformID=PlatformID FROM AccountsInfo WHERE UserID=@dwUserID
	IF @PlatformID<>1002 AND @PlatformID<>2001
	BEGIN
		SET @BindingStatus=2
	END

	-- 输出变量
	SELECT @BindingStatus AS BindingStatus, @ChannelReward AS ChannelReward
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 渠道绑定
CREATE PROC GSP_MB_ChannelBinding
	@dwUserID INT,								-- 用户 I D
	@dwChannelID INT,							-- 渠道标识
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
	DECLARE @BindingStatus AS TINYINT
	DECLARE @ChannelReward AS INT
	DECLARE @PlatformID AS INT
	DECLARE @UserScore AS BIGINT
	DECLARE @SetBindingStatus AS TINYINT

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

	declare @chid int
	SELECT TOP 1 @chid=ChannelID from [THRecordDB].[dbo].[RecordMachineCountInfo](nolock) WHERE [RegisterMachine]=@strMachineID and ChannelID <>0  and (ChannelID < 1000 or  ChannelID > 4000) ORDER BY ID DESC
	if @chid is not null 
	begin 
		SET @strErrorDescribe=N'此设备已绑定过渠道！'
		RETURN 3
	end

	-- 查询平台
	SELECT @PlatformID=PlatformID FROM AccountsInfo WHERE UserID=@dwUserID
	--IF @PlatformID<>1002 AND @PlatformID<>2001
	--BEGIN
	--	SET @strErrorDescribe=N'对不起，您的游戏账号为第三方授权账号，非官方账号无法领取奖励！'
	--	RETURN 3
	--END

	-- 设置状态
	SET @SetBindingStatus=2

	-- 查询状态
	SELECT @BindingStatus=BindingStatus FROM AccountsChannel WHERE UserID=@dwUserID

	-- 数据调整
	IF @BindingStatus IS NULL SET @BindingStatus=0

	-- 状态判断
	IF @BindingStatus=0
	BEGIN
		-- 渠道判断
		IF NOT EXISTS (SELECT * FROM ChannelConfig WHERE ChannelID=@dwChannelID AND Nullity=0)
		BEGIN
			SET @strErrorDescribe=N'对不起，您输入的渠道标识尚未启用，请查证后再次尝试！'
			RETURN 4
		END

		-- 绑定渠道
		-- UPDATE AccountsInfo SET SpreaderID=@dwChannelID WHERE UserID=@dwUserID AND SpreaderID=@dwChannelID
		UPDATE AccountsInfo SET SpreaderID=@dwChannelID WHERE UserID=@dwUserID 
		EXEC THRecordDB.dbo.GSP_GR_DJ_Reg @dwChannelID,@PlatformID,@strClientIP,@strMachineID
		UPDATE AccountsChannel SET ChannelID=@dwChannelID,BindingStatus=@SetBindingStatus WHERE UserID=@dwUserID
		IF @@ROWCOUNT=0
		BEGIN
			INSERT AccountsChannel (UserID,ChannelID,BindingStatus) VALUES (@dwUserID,@dwChannelID,@SetBindingStatus)
		END
	END
	ELSE IF @BindingStatus=1
	BEGIN
		-- 更新状态
		UPDATE AccountsChannel SET BindingStatus=@SetBindingStatus WHERE UserID=@dwUserID
	END
	ELSE IF @BindingStatus=2
	BEGIN
		SET @strErrorDescribe=N'您已经绑定过渠道，无法再次绑定！'
		RETURN 5
	END
	ELSE
	BEGIN
		SET @strErrorDescribe=N'您的绑定状态异常，请联系客服解决！'
		RETURN 6
	END

	-- 查询奖励
	SELECT @ChannelReward=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'ChannelReward'

	-- 数据调整
	IF @ChannelReward IS NULL SET @ChannelReward=0

	-- 赠送金币
	UPDATE THTreasureDB.dbo.GameScoreInfo SET Score=Score+@ChannelReward WHERE UserID=@dwUserID
	IF @@ROWCOUNT=0
	BEGIN
		INSERT THTreasureDB.dbo.GameScoreInfo(UserID,Score,RegisterIP,LastLogonIP) VALUES (@dwUserID,@ChannelReward,@strClientIP,@strClientIP)
	END
	--  赠送金币记录
	insert into [THRecordDB].[dbo].[RecordGrantGameScore]([MasterID],[ClientIP],[CollectDate],[UserID],[KindID],[CurScore],[AddScore],[Reason]) values(0,'',getdate(),@dwUserID,6,0,@ChannelReward,'绑定渠道')

	-- 查询分数
	SELECT @UserScore=Score FROM THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID

	-- 数据调整
	IF @UserScore IS NULL SET @UserScore=0

	-- 输出信息
	SELECT @SetBindingStatus AS BindingStatus, @UserScore AS UserScore
	SET @strErrorDescribe=N'恭喜您，奖励领取成功！'
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------