USE [THAccountsDB]
GO

/****** Object:  StoredProcedure [dbo].[NET_PW_RegisterAccounts1]    Script Date: 2018/10/11 10:23:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











----------------------------------------------------------------------------------------------------

-- 帐号注册
ALTER PROCEDURE [dbo].[NET_PW_RegisterAccounts1]
	@strAccounts NVARCHAR(31),					-- 用户帐号
	@strNickname NVARCHAR(31),					-- 用户昵称
	@strLogonPass NCHAR(32),					-- 用户密码
	@strInsurePass NCHAR(32),					-- 用户密码
	@dwFaceID INT,								-- 头像标识
	@dwGender TINYINT,							-- 用户性别
	@strSpreader NVARCHAR(31),					-- 推广员名
	@strCompellation NVARCHAR(16),				-- 真实姓名
	@strPassPortID NVARCHAR(18),				-- 身份证号
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strAdID INT,								-- 推广来源ID
	@strPCEggsPCID	INT,						-- PC蛋蛋PCID
	@strPCEggsADID	NVARCHAR(255),				-- PC蛋蛋ADID
	@RegDeviceType int,						-- 新版设备ID（0：PC，16：安卓，32：IOS)
	@RegKindID int,							    -- 游戏ID 378 - 血流  6 - 赢三张  27  -牛牛
	@Regmark int,								--1、手机一键注册，0、其他注册
	@externalMsg Nvarchar(50)='',					--扩展字段
	@RealName nvarchar(10)='',					--真实姓名
	@IdentityCard nvarchar(18)='',				--身份证号
	@WeiXinName   nvarchar(31)=N'',				--微信昵称
	@RegisterMachine nvarchar(32)=N'',
	@strErrorDescribe	NVARCHAR(127) OUTPUT	-- 输出信息
 AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @FaceID INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @Nickname NVARCHAR(31) 
DECLARE @UnderWrite NVARCHAR(63)

-- 扩展信息
DECLARE @GameID INT
DECLARE @SpreaderID INT
DECLARE @Gender TINYINT
DECLARE @Experience INT
DECLARE @Loveliness INT
DECLARE @MemberOrder INT
DECLARE @MemberOverDate DATETIME
DECLARE @CustomFaceVer TINYINT
DECLARE @Compellation NVARCHAR(16)
DECLARE @PassPortID NVARCHAR(18)
DECLARE @OpType int
SET @Loveliness = 0 -- 魅力值默认值

-- 辅助变量
DECLARE @EnjoinLogon AS INT
DECLARE @EnjoinRegister AS INT

-- 执行逻辑
BEGIN
	IF @strNickname='AppServicesRegister'
	BEGIN
		SET @UserID=0
		SET @GameID=0
		SELECT @UserID=UserID,@GameID=GameID
		FROM AccountsInfo(NOLOCK) WHERE Nickname='AppServicesRegister'
		--手游一键注册
		IF(@UserID>0)
		BEGIN
			UPDATE AccountsInfo
			SET Nickname='贵宾1123'+ CONVERT(VARCHAR(30),@UserID)
			WHERE UserID=@UserID
			SET @UserID=0
			SET @GameID=0
		END
	--set @Nickname='贵宾581'+cast((select max(userid) FROM AccountsInfo(NOLOCK)) as nvarchar)
	--set @strAccounts='yjzc2016'+cast((select max(userid) FROM AccountsInfo(NOLOCK)) as nvarchar)
	declare @maxuserid nvarchar(10)
	set @maxuserid=cast((select max(userid)+1 FROM AccountsInfo(NOLOCK)) as nvarchar)
	set @Nickname='贵宾'+@maxuserid
	set @strAccounts='dwj'+@maxuserid
	set @strInsurePass=''
	END
	else
	   BEGIN
		 set @strInsurePass=@strLogonPass
		 set @Nickname=@strNickname
	   END

	-- 校验账号6-12位字母和数字的组合
	-- declare @sz_zh int
	-- declare @zm_zh int
	-- declare @len_zh int
	-- select  @sz_zh = PATINDEX('%[A-Za-z]%', @strAccounts)
	-- select  @zm_zh = PATINDEX('%[0-9]%', @strAccounts)
	-- select  @len_zh = len(@strAccounts)
	-- if @sz_zh < 1 or @zm_zh < 1 or @len_zh > 12 or @len_zh < 6
	-- begin
		-- SET @strErrorDescribe=N'账号必须是6-12位字母和数字的组合！'
		-- RETURN 1
	-- end

	-- 注册暂停
	SELECT @EnjoinRegister=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinRegister'
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinRegister'
		RETURN 1
	END

	-- 登录暂停
	SELECT @EnjoinLogon=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinLogon'
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinLogon'
		RETURN 2
	END

	-- 效验名字
	IF EXISTS (SELECT [String] FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strAccounts)>0 AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL))
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，您所输入的帐号名含有限制字符串，请更换帐号名后再次申请帐号！'
		RETURN 1
	END

	-- 效验昵称
	IF EXISTS (SELECT [String] FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strNickname)>0 AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL))
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，您所输入的昵称含有限制字符串，请更换昵称后再次申请帐号！'
		RETURN 1
	END
	
	-- 效验地址
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您所在的 IP 地址的注册功能，请联系客户服务中心了解详细情况！'
		RETURN 2
	END
	-- 效验机器
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@RegisterMachine AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您的机器的注册功能，请联系客户服务中心了解详细情况！'
		RETURN 6
	END

	-- 机器码限制,一个机器码只能注册3个   -- 8.31因测试暂时注释掉
	--IF 2< (select count([RegisterMachine]) FROM [THAccountsDB].[dbo].[AccountsInfo](nolock) where [RegisterMachine] = @RegisterMachine)
	--BEGIN
		--SET @strErrorDescribe=N'抱歉地通知您，同一机器码只能注册3个号！'
		--RETURN 3
	--END

	-- 查询用户
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts)
	BEGIN
		SET @strErrorDescribe=N'此帐号名已被注册，请换另一帐号名字尝试再次注册！'
		RETURN 3
	END

	IF @Nickname<>'AppServicesRegister' AND EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE NickName=@Nickname)
	BEGIN
		SET @strErrorDescribe=N'此帐号名或者昵称已被注册，请换另一帐号尝试再次注册！'
		RETURN 3
	END

	 --每个IP最大注册人数
	IF 100<(SELECT COUNT(*) FROM AccountsInfo WHERE CONVERT(NVARCHAR(30),registerdate,23) = CONVERT(NVARCHAR(30),getdate(),23) AND registerip=@strClientIP)
	BEGIN
		SET @strErrorDescribe=N'您所在的 IP 地址的注册人数过多！'
		RETURN 3
	END

	-- 查推广员
	IF @strSpreader<>''
	BEGIN
		-- 查推广员
		SELECT @SpreaderID=UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strSpreader

		-- 结果处理
		IF @SpreaderID IS NULL
		BEGIN
			SET @strErrorDescribe=N'您所填写的推荐人不存在或者填写错误，请检查后再次注册！'
			RETURN 4
		END
	END
	ELSE SET @SpreaderID=0

	 declare @NoviceAward int 
	 set @NoviceAward=0
	 if @RegKindID not in(378,200)
	  set @NoviceAward=1
	set @dwFaceID=1
	declare @i int
	set @i=0
	retry:
	-- 注册用户
	INSERT AccountsInfo (Accounts,Nickname,RegAccounts,LogonPass,InsurePass,SpreaderID,Gender,FaceID,WebLogonTimes,RegisterIP,LastLogonIP,Compellation,PassPortID,RegisterMachine)
	VALUES (@strAccounts,@Nickname,@strAccounts,@strLogonPass,@strInsurePass,@SpreaderID,@dwGender,@dwFaceID,1,@strClientIP,@strClientIP,@strCompellation,@strPassPortID,@RegisterMachine)
	-- 获取自动增长UserID
	DECLARE @NewUserID INT
	SET @NewUserID = @@IDENTITY

	--  注册成功就插入数据到[RecordUserCountInfo]
	insert into [THRecordDB].[dbo].[RecordUserCountInfo]([UserID],[RechargeSum],[RechargeCount],[GameSum],[GameSumDay],[ZzSum],[ZzCount],[ZcPtSum],[ZcPtCount],[ZcVipSum],
  [ZcVipCount],[ZrPtSum],[ZrPtCount],[ZrVipSum],[ZrVipCount],[InsertDate],[DezSum],[Status]) 
  values(@NewUserID,0,0,0,0,0,0,0,0,0,0,0,0,0,0,getdate(),0,0)

	-- 错误判断
	IF @@ERROR<>0
	BEGIN
		SET @strErrorDescribe=N'帐号已存在，请换另一帐号名字尝试再次注册！'
		RETURN 5
	END
	set @i=@i+1
	SELECT @GameID=GameID FROM GameIdentifier(NOLOCK) WHERE UserID=@NewUserID
		IF @GameID IS NULL or @GameID=0
		BEGIN
			SET @GameID=0
			SET @strErrorDescribe=N'注册失败，请重新注册！'
			UPDATE AccountsInfo SET RegisterMachine='',Accounts=substring(replace(newid(), '-', ''),1,31),Nullity=1 WHERE UserID=@NewUserID
			if @i>1 
			begin
				return 1
			end
		    goto retry
		END
		ELSE UPDATE AccountsInfo SET GameID=@GameID WHERE UserID=@NewUserID


	-- 查询用户
	SELECT @UserID=UserID, @Accounts=Accounts, @Nickname=Nickname,@UnderWrite=UnderWrite, @Gender=Gender, @FaceID=FaceID, @Experience=Experience,
		@MemberOrder=MemberOrder, @MemberOverDate=MemberOverDate, /*@Loveliness=Loveliness,*/@CustomFaceVer=CustomFaceVer,
		@Compellation=Compellation,@PassPortID=PassPortID
	FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts


	 
	--手游一键注册
	IF(@strNickname='AppServicesRegister')
	BEGIN
		UPDATE AccountsInfo
		SET Nickname='贵宾'+ CONVERT(VARCHAR(30),@NewUserID)
		WHERE UserID=@UserID
	END
	
	-- 记录日志
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE SystemStreamInfo SET WebRegisterSuccess=WebRegisterSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT SystemStreamInfo (DateID, WebRegisterSuccess) VALUES (@DateID, 1)

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	-- 注册赠送

	-- 读取变量
	DECLARE @GrantScoreCount AS BIGINT
	DECLARE @GrantIPCount AS BIGINT
	SELECT @GrantScoreCount=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'GrantScoreCount'
	SELECT @GrantIPCount=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'GrantIPCount'

	-- 输出变量
	SELECT @UserID AS UserID,@strAccounts as strAccounts
	set @strErrorDescribe='注册成功'
End 

RETURN 0

GO


