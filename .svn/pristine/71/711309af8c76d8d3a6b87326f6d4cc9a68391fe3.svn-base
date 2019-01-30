
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_KZ_EfficacyAccounts]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_KZ_EfficacyAccounts]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 帐号登录
CREATE PROC GSP_KZ_EfficacyAccounts
	@strAccounts NVARCHAR(31),					-- 用户帐号
	@strPassword NCHAR(32),						-- 用户密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @Accounts NVARCHAR(31)

-- 辅助变量
DECLARE @EnjoinLogon AS INT

-- 执行逻辑
BEGIN
	-- 系统暂停
	SELECT @EnjoinLogon=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinLogon'
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinLogon'
		RETURN 2
	END

	-- 效验地址
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您所在的 IP 地址的登录功能，请联系客户服务中心了解详细情况！'
		RETURN 4
	END
	
	-- 效验机器
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineID AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您的机器的登录功能，请联系客户服务中心了解详细情况！'
		RETURN 7
	END

	-- 查询用户
	DECLARE @Nullity TINYINT
	DECLARE @StunDown TINYINT
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @InsurePass AS NCHAR(32)
	DECLARE	@MachineSerial NCHAR(32)
	DECLARe @strLastLogonIP NCHAR(15)
	DECLARE @MoorMachine AS TINYINT
	SELECT @UserID=UserID, @Accounts=Accounts, @LogonPass=LogonPass,@InsurePass=InsurePass,
		@Nullity=Nullity, @StunDown=StunDown,
		@strLastLogonIP=LastLogonIP,
		@MoorMachine=MoorMachine, @MachineSerial=LastLogonMachine
	FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在或者密码输入有误，请查证后再次尝试登录！'
		RETURN 3
	END

	-- 固定机器
	IF @MoorMachine=2
	BEGIN
		SET @MoorMachine=1
		SET @strErrorDescribe=N'您的帐号成功使用了固定机器登录功能！'
		UPDATE AccountsInfo SET MoorMachine=@MoorMachine, LastLogonMachine=@strMachineID WHERE UserID=@UserID
	END

	-- 更新信息
	UPDATE AccountsInfo SET GameLogonTimes=GameLogonTimes+1,LastLogonDate=GETDATE(), LastLogonIP=@strClientIP,DynamicPassTime=GETDATE(),
		DynamicPass=CONVERT(nvarchar(32),REPLACE(newid(),'-','')),LastLogonMachine=@strMachineID 
	WHERE UserID=@UserID

	-- 动态密码
	DECLARE @szDynamicPass  nchar(32)
	SELECT @szDynamicPass=DynamicPass FROM AccountsInfo WHERE UserID=@UserID

	-- 记录日志
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE SystemStreamInfo SET GameLogonSuccess=GameLogonSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT SystemStreamInfo (DateID, GameLogonSuccess) VALUES (@DateID, 1)

	-- 银行标识
	DECLARE @InsureEnabled TINYINT
	SET @InsureEnabled=0
	IF @InsurePass <> '' SET @InsureEnabled=1
	
	-- 输出变量
	SELECT @UserID AS UserID, @Accounts AS Accounts, @MoorMachine AS MoorMachine, @InsureEnabled AS InsureEnabled
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
