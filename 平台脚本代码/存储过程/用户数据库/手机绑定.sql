
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_QueryBinding]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_QueryBinding]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_BindingMobile]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_BindingMobile]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 查询绑定
CREATE PROC GSP_GP_QueryBinding
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码			
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN

	-- 变量定义
	DECLARE @UserID INT
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	DECLARE @LogonPass NCHAR(32)
	DECLARE @BindingFlag TINYINT

	-- 查询用户
	SELECT @UserID=UserID, @LogonPass=LogonPass, @Nullity=Nullity, @StunDown=StunDown
	FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

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
	
	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在或者密码输入有误，请查证后再次尝试！'
		RETURN 3
	END
	
	-- 查询绑定
	DECLARE @MobilePhone NVARCHAR(11)
	SELECT @MobilePhone=MobilePhone FROM MobileBindingInfo WHERE UserID=@dwUserID AND Nullity = 0
	
	-- 绑定判断
	IF @MobilePhone IS NULL
	BEGIN
		SET @BindingFlag=0
	END
	ELSE
	BEGIN
		SET @BindingFlag=1
	END
	
	-- 输出变量
	SELECT @BindingFlag AS BindingFlag
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 绑定手机
CREATE PROC GSP_GP_BindingMobile
	@dwUserID INT,								-- 用户 I D
	@dwValidateCode INT,						-- 校验密码
	@strMobilePhone NVARCHAR(11),				-- 移动电话
	@strPassword NCHAR(32),						-- 用户密码			
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN

	-- 变量定义
	DECLARE @UserID INT
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	DECLARE @LogonPass NCHAR(32)

	-- 查询用户
	SELECT @UserID=UserID, @LogonPass=LogonPass, @Nullity=Nullity, @StunDown=StunDown
	FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

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
	
	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在或者密码输入有误，请查证后再次尝试！'
		RETURN 3
	END

	-- 绑定判断
	IF EXISTS (SELECT UserID FROM MobileBindingInfo WHERE MobilePhone=@strMobilePhone AND Nullity = 0)
	BEGIN
		SET @strErrorDescribe=N'该手机号码已经绑定其它帐号，请查证后再次尝试！'
		RETURN 4
	END

	-- 查询验证
	DECLARE @ValidateCode INT
	SELECT TOP 1 @ValidateCode=ValidateCode FROM MobileValidateCode 
	WHERE CodeType=1 AND MobilePhone=@strMobilePhone AND GETDATE()<ValidDate ORDER BY ValidDate DESC

	-- 验证判断
	IF @ValidateCode IS NULL OR @ValidateCode<>@dwValidateCode
	BEGIN
		SET @strErrorDescribe=N'您的输入的验证码不正确，请查证后再次尝试！'
		RETURN 5
	END
	
	-- 查询绑定
	DECLARE @MobilePhone NVARCHAR(11)
	SELECT @MobilePhone=MobilePhone FROM MobileBindingInfo WHERE UserID=@dwUserID AND Nullity = 0

	-- 绑定判断
	IF @MobilePhone IS NOT NULL
	BEGIN
		SET @strErrorDescribe=N'您的帐号已经绑定过手机号码，请查证后再次尝试！'
		RETURN 6
	END

	-- 修改绑定
	UPDATE MobileBindingInfo SET MobilePhone = @strMobilePhone, BindingDate = GETDATE(), Nullity = 0 WHERE UserID=@dwUserID
		
	-- 插入绑定
	IF @@ROWCOUNT=0
	BEGIN
		INSERT MobileBindingInfo (UserID, MobilePhone) VALUES (@dwUserID, @strMobilePhone)
	END

	-- 设置信息
	IF @@ERROR=0 SET @strErrorDescribe=N'您的手机已绑定成功！'

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
