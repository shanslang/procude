----------------------------------------------------------------------------------------------------
-- 版权：2016
-- 时间：2016-12-20
-- 用途：快速注册
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_MB_FastRegister') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_MB_FastRegister
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 快速注册
CREATE PROCEDURE GSP_MB_FastRegister
	@dwPlatformID INT,							-- 平台编号
	@dwSpreaderID INT,							-- 渠道标识
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NCHAR(32),					-- 机器标识
	@strDeviceModel NVARCHAR(64),				-- 设备型号
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @LogonPass NCHAR(32)

-- 附加信息
DECLARE @GameID INT

-- 辅助变量
DECLARE @EnjoinLogon AS INT
DECLARE @EnjoinRegister AS INT

-- 奖励信息
DECLARE @RewardGoodsID INT
DECLARE @RewardGoodsCount INT

-- 执行逻辑
BEGIN
	SET @UserID=0
	-- 查询用户
	SELECT TOP 1 @UserID=UserID, @GameID=GameID, @Accounts=Accounts, @LogonPass=LogonPass FROM AccountsInfo(NOLOCK) WHERE RegisterMachine=@strMachineID

	IF @UserID>0
	BEGIN
		-- 输出变量
		SELECT TOP 1 @dwSpreaderID=ChannelID from THRecordDB.[dbo].[RecordChannelOpen] WHERE IP=@strClientIP ORDER BY RecordID DESC
		IF (SELECT COUNT(*) FROM AccountsInfo WHERE UserID=@UserID AND SpreaderID<>@dwSpreaderID)>0
		BEGIN
			UPDATE AccountsInfo SET SpreaderID=@dwSpreaderID WHERE UserID=@UserID AND SpreaderID<>@dwSpreaderID
			UPDATE AccountsChannel SET ChannelID=@dwSpreaderID WHERE UserID=@UserID AND ChannelID<>@dwSpreaderID
			IF (SELECT COUNT(*) FROM AccountsChannel WHERE UserID=@UserID AND ChannelID=@dwSpreaderID)=0 INSERT AccountsChannel (UserID,ChannelID) VALUES (@UserID,@dwSpreaderID)
			EXEC THRecordDB.dbo.GSP_GR_DJ_Reg @dwSpreaderID,@dwPlatformID,@strClientIP,@strMachineID
		END
		SELECT @UserID AS UserID, @Accounts AS Accounts, @LogonPass AS LogonPass
		RETURN 0
	END

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

	-- 效验地址
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您所在的 IP 地址的注册功能，请联系客户服务中心了解详细情况！'
		RETURN 5
	END
	
	-- 效验机器
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineID AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您的机器的注册功能，请联系客户服务中心了解详细情况！'
		RETURN 6
	END

	-- 生成昵称
	DECLARE	@strAccounts NVARCHAR(31)
	DECLARE	@strNickname NVARCHAR(31)
	DECLARE	@strLogonPass NCHAR(32)
	DECLARE @strRand NVARCHAR(6)
	
	-- 生成密码
--	SELECT @strLogonPass = CONVERT(NVARCHAR(32),REPLACE(newid(),'-',''))
	SELECT @strLogonPass = 'E10ADC3949BA59ABBE56E057F20F883E'


	DECLARE @R1 INT
	DECLARE @R2 INT
	SET @R1=FLOOR(RAND()*4)
	SET @R2=FLOOR(RAND()*4)
	SET @strNickname=NULL
	SET @strAccounts=NULL
	WHILE @strNickname IS NULL OR (SELECT COUNT(*) FROM THAccountsDB.dbo.AccountsInfo WHERE NickName=@strNickname)>0
	BEGIN
		SELECT @strNickname=NickName FROM THAccountsDB.dbo.Accounts_Nickname0 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname0 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname0)) AND @R1=0
		SELECT @strNickname=NickName FROM THAccountsDB.dbo.Accounts_Nickname1 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname1 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname1)) AND @R1=1
		SELECT @strNickname=NickName FROM THAccountsDB.dbo.Accounts_Nickname2 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname2 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname2)) AND @R1=2
		SELECT @strNickname=NickName FROM THAccountsDB.dbo.Accounts_Nickname3 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname3 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname3)) AND @R1=3
		SELECT @strNickname=NickName+@strNickname FROM THAccountsDB.dbo.Accounts_Nickname0 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname0 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname0)) AND @R2=0
		SELECT @strNickname=NickName+@strNickname FROM THAccountsDB.dbo.Accounts_Nickname1 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname1 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname1)) AND @R2=1
		SELECT @strNickname=NickName+@strNickname FROM THAccountsDB.dbo.Accounts_Nickname2 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname2 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname2)) AND @R2=2
		SELECT @strNickname=NickName+@strNickname FROM THAccountsDB.dbo.Accounts_Nickname3 WHERE id=(SELECT MAX(id) FROM Accounts_Nickname3 WHERE id<=(SELECT FLOOR(MAX(id)*RAND())+1 FROM THAccountsDB.dbo.Accounts_Nickname3)) AND @R2=3
	END

	WHILE @strAccounts IS NULL OR (SELECT COUNT(*) FROM THAccountsDB.dbo.AccountsInfo WHERE Accounts=@strAccounts)>0
	BEGIN
		-- 生成账号
		SET @strAccounts = CONVERT(NVARCHAR(4),@dwPlatformID) + N'Fast' + CONVERT(NVARCHAR(6),REPLACE(newid(),'-',''))
	END

--	WHILE 1=1
--	BEGIN
--		-- 随机标识
--		SELECT @strRand = CONVERT(NVARCHAR(6),REPLACE(newid(),'-',''))
--
--		-- 生成账号
--		SET @strAccounts = CONVERT(NVARCHAR(4),@dwPlatformID) + N'Fast' + @strRand
--		
--		-- 生成昵称
--		SET @strNickname = CONVERT(NVARCHAR(4),@dwPlatformID) + N'Fast' + @strRand
--
--		-- 查询账号
--		IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts)
--		BEGIN
--			CONTINUE
--		END
--		
--		-- 查询昵称
--		IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE NickName=@strNickName)
--		BEGIN
--			CONTINUE
--		END
--
--		BREAK
--	END

	SELECT TOP 1 @dwSpreaderID=ChannelID from THRecordDB.[dbo].[RecordChannelOpen] WHERE IP=@strClientIP ORDER BY RecordID DESC

	-- 注册用户
	INSERT AccountsInfo (Accounts,NickName,RegAccounts,LogonPass,DynamicPass,Gender,FaceID,GameLogonTimes,LastLogonIP,LastLogonMachine,LastLogonModel,RegisterIP,RegisterMachine,RegisterModel,PlatformID,SpreaderID)
	VALUES (@strAccounts,@strNickName,@strAccounts,@strLogonPass,CONVERT(nvarchar(32),REPLACE(newid(),'-','')),1,1,1,@strClientIP,@strMachineID,@strDeviceModel,@strClientIP,@strMachineID,@strDeviceModel,@dwPlatformID,@dwSpreaderID)

	EXEC THRecordDB.dbo.GSP_GR_DJ_Reg @dwSpreaderID,@dwPlatformID,@strClientIP,@strMachineID

	-- 错误判断
	IF @@ERROR<>0
	BEGIN
		SET @strErrorDescribe=N'由于意外的原因，帐号注册失败，请尝试再次注册！'
		RETURN 8
	END

	-- 查询用户
	SELECT @UserID=UserID, @GameID=GameID, @Accounts=Accounts, @LogonPass=LogonPass FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts

	-- 分配标识
	SELECT @GameID=GameID FROM GameIdentifier(NOLOCK) WHERE UserID=@UserID
	IF @GameID IS NULL 
	BEGIN
		SET @GameID=0
		SET @strErrorDescribe=N'用户注册成功，但未成功获取游戏 ID 号码，系统稍后将给您分配！'
	END
	ELSE UPDATE AccountsInfo SET GameID=@GameID WHERE UserID=@UserID

	-- 记录日志
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE SystemStreamInfo SET GameRegisterSuccess=GameRegisterSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT SystemStreamInfo (DateID, GameRegisterSuccess) VALUES (@DateID, 1)

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	-- 注册赠送

	-- 读取变量
	DECLARE @GrantIPCount AS BIGINT
	DECLARE @GrantScoreCount AS BIGINT
	SELECT @GrantIPCount=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'GrantIPCount'
	SELECT @GrantScoreCount=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'GrantScoreCount'

	-- 赠送限制
	IF @GrantScoreCount IS NOT NULL AND @GrantScoreCount>0 AND @GrantIPCount IS NOT NULL AND @GrantIPCount>0
	BEGIN
		-- 赠送次数
		DECLARE @GrantCount AS BIGINT
		DECLARE @GrantMachineCount AS BIGINT
		SELECT @GrantCount=GrantCount FROM SystemGrantCount(NOLOCK) WHERE DateID=@DateID AND RegisterIP=@strClientIP
		SELECT @GrantMachineCount=GrantCount FROM SystemMachineGrantCount(NOLOCK) WHERE DateID=@DateID AND RegisterMachine=@strMachineID
	
		-- 次数判断
		IF (@GrantCount IS NOT NULL AND @GrantCount>=@GrantIPCount) OR (@GrantMachineCount IS NOT NULL AND @GrantMachineCount>=@GrantIPCount)
		BEGIN
			SET @GrantScoreCount=0
		END
	END

	-- 赠送金币
	IF @GrantScoreCount IS NOT NULL AND @GrantScoreCount>0
	BEGIN
		-- 更新记录
		UPDATE SystemGrantCount SET GrantScore=GrantScore+@GrantScoreCount, GrantCount=GrantCount+1 WHERE DateID=@DateID AND RegisterIP=@strClientIP

		-- 插入记录
		IF @@ROWCOUNT=0
		BEGIN
			INSERT SystemGrantCount (DateID, RegisterIP, RegisterMachine, GrantScore, GrantCount) VALUES (@DateID, @strClientIP, @strMachineID, @GrantScoreCount, 1)
		END

		-- 更新记录
		UPDATE SystemMachineGrantCount SET GrantScore=GrantScore+@GrantScoreCount, GrantCount=GrantCount+1 WHERE DateID=@DateID AND RegisterMachine=@strMachineID

		-- 插入记录
		IF @@ROWCOUNT=0
		BEGIN
			INSERT SystemMachineGrantCount (DateID, RegisterIP, RegisterMachine, GrantScore, GrantCount) VALUES (@DateID, @strClientIP, @strMachineID, @GrantScoreCount, 1)
		END

		-- 赠送金币
		INSERT THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo (UserID, Score, RegisterIP, LastLogonIP) VALUES (@UserID, @GrantScoreCount, @strClientIP, @strClientIP) 
	END

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	-- 机器统计

	-- 更新机器
	UPDATE RegisterMachineInfo SET RegisterCount=RegisterCount+1 WHERE RegisterMachine=@strMachineID

	-- 插入机器
	IF @@ROWCOUNT=0
	BEGIN
		INSERT RegisterMachineInfo (RegisterMachine,RegisterCount) VALUES (@strMachineID,1)
	END

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	-- 关联渠道
	
	-- 查询关联
	DECLARE @ChannelID AS INT
	SELECT @ChannelID=ChannelID FROM WebVisitInfo WHERE WebVisitIP=@strClientIP
	IF @ChannelID IS NOT NULL
	BEGIN
		-- 渠道判断
		IF EXISTS (SELECT * FROM ChannelConfig WHERE ChannelID=@ChannelID AND Nullity=0)
		BEGIN
			INSERT AccountsChannel (UserID,ChannelID) VALUES (@UserID,@ChannelID)
		END
	END

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------

	-- 输出变量
	SELECT @UserID AS UserID, @Accounts AS Accounts, @LogonPass AS LogonPass

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------