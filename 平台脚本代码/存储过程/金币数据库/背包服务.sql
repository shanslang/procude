
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

-- ��������
CREATE PROC GSP_GP_GetPackageConfig
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	-- ɾ����Ʒ
	DELETE FROM PackageInfo WHERE GoodsID NOT IN (SELECT GoodsID FROM PackageConfig WHERE Nullity=0)

	-- �������
	SELECT GoodsID,GoodsName,GoodsType,GoodsPrice,RewardScore,Storage,Probability FROM PackageConfig WHERE Nullity=0 ORDER BY GoodsID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- ������Ϣ
CREATE PROC GSP_GP_GetPackageInfo
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	
	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	
	-- �˻��ж�
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'�����˻���Ϣ�������֤���ٴγ��ԣ�'
		RETURN 1
	END

	-- �����ж�
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'�������������������֤���ٴγ��ԣ�'
		RETURN 2
	END

	-- ɾ����Ʒ
	DELETE FROM PackageInfo WHERE UserID=@dwUserID AND GoodsCount=0
	
	-- �������
	SELECT A.GoodsID AS GoodsID,GoodsName,GoodsType,GoodsPrice,GoodsCount,LuckyGoodsID
	FROM PackageInfo A,PackageConfig (NOLOCK) B WHERE A.GoodsID=B.GoodsID AND B.Nullity=0 AND A.UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- ��������
CREATE PROC GSP_GP_OpenBox
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@cbOperateType TINYINT,						-- ��������
	@dwOperateGoodsID INT,						-- ��Ʒ I D
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsCount INT
	DECLARE @Beans DECIMAL(18, 2)
	DECLARE @GoodsPrice DECIMAL(18, 2)
	
	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	
	-- �˻��ж�
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'�����˻���Ϣ�������֤���ٴγ��ԣ�'
		RETURN 1
	END

	-- �����ж�
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'�������������������֤���ٴγ��ԣ�'
		RETURN 2
	END

	-- ��ѯ��Ϸ��
	SELECT @Beans=Currency FROM UserCurrencyInfo WHERE UserID=@dwUserID

	-- ��ѯ��Ʒ
	SELECT @GoodsPrice=GoodsPrice FROM PackageConfig (NOLOCK) WHERE GoodsID=@dwOperateGoodsID

	-- ��ѯ����
	SELECT @GoodsCount=GoodsCount FROM PackageInfo WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

	-- ���ݵ���
	IF @Beans IS NULL SET @Beans=0
	IF @GoodsCount IS NULL SET @GoodsCount=0

	-- ��Ʒ�ж�
	IF @GoodsPrice IS NULL OR @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'����������Ʒ�����ڣ����֤���ٴγ��ԣ�'
		RETURN 3
	END

	-- �۸��ж�
	IF @Beans<@GoodsPrice
	BEGIN
		SET @strErrorDescribe=N'������ʯ�������㣬�������Ϸ��ֵҳ����г�ֵ��'
		RETURN 4
	END

	-- ɾ����Ʒ
	DELETE FROM PackageInfo WHERE UserID=@dwUserID AND GoodsCount=0
	
	-- �������
	SELECT A.GoodsID AS GoodsID,GoodsName,GoodsType,GoodsPrice,GoodsCount,LuckyGoodsID
	FROM PackageInfo A,PackageConfig (NOLOCK) B WHERE A.GoodsID=B.GoodsID AND B.Nullity=0 AND A.UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- �н���Ʒ
CREATE PROC GSP_GP_SetLuckyGoods
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@cbOperateType TINYINT,						-- ��������
	@dwOperateGoodsID INT,						-- ��Ʒ I D
	@dwLuckyGoodsID INT,						-- �н���Ʒ
	@dwLeftStorage INT,							-- ʣ����
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsCount INT
	DECLARE @Beans DECIMAL(18, 2)
	DECLARE @GoodsPrice DECIMAL(18, 2)
	DECLARE @GoodsType TINYINT
	DECLARE @RewardScore BIGINT
	DECLARE @RewardExcharge INT
	
	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	
	-- �˻��ж�
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'�����˻���Ϣ�������֤���ٴγ��ԣ�'
		RETURN 1
	END

	-- �����ж�
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'�������������������֤���ٴγ��ԣ�'
		RETURN 2
	END

	-- ��ѯ��Ϸ��
	SELECT @Beans=Currency FROM UserCurrencyInfo WHERE UserID=@dwUserID

	-- ��ѯ��Ʒ
	SELECT @GoodsPrice=GoodsPrice FROM PackageConfig (NOLOCK) WHERE GoodsID=@dwOperateGoodsID

	-- ��ѯ����
	SELECT @GoodsCount=GoodsCount FROM PackageInfo WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

	-- ������Ʒ
	SELECT @GoodsType=GoodsType,@RewardScore=RewardScore,@RewardExcharge=RewardExcharge 
	FROM PackageConfig (NOLOCK) WHERE GoodsID=@dwLuckyGoodsID

	-- ���ݵ���
	IF @Beans IS NULL SET @Beans=0
	IF @GoodsCount IS NULL SET @GoodsCount=0
	IF @GoodsType IS NULL SET @GoodsType=0
	IF @RewardScore IS NULL SET @RewardScore=0

	-- ��Ʒ�ж�
	IF @GoodsPrice IS NULL OR @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'����������Ʒ�����ڣ����֤���ٴγ��ԣ�'
		RETURN 3
	END

	-- �۸��ж�
	IF @Beans<@GoodsPrice
	BEGIN
		SET @strErrorDescribe=N'������ʯ�������㣬�������Ϸ��ֵҳ����г�ֵ��'
		RETURN 4
	END

	-- ������Ϸ��
	UPDATE UserCurrencyInfo SET Currency=Currency-@GoodsPrice WHERE UserID=@dwUserID

	-- ���¿��
	UPDATE PackageConfig SET Storage=@dwLeftStorage WHERE GoodsID=@dwLuckyGoodsID

	-- �����ж�
	IF @GoodsType&0x02<>0 OR @GoodsType&0x04<>0
	BEGIN
		-- �������
		IF @GoodsType&0x02<>0
		BEGIN
			-- ������Ʒ
			UPDATE GameScoreInfo SET InsureScore=InsureScore+@RewardScore WHERE UserID=@dwUserID

			-- ������Ʒ
			IF @@ROWCOUNT=0
			BEGIN
				INSERT GameScoreInfo(UserID,InsureScore) VALUES (@dwUserID,@RewardScore)
			END
		END
		
		-- ������ֵ��
		IF @GoodsType&0x04<>0
		BEGIN
			-- ������Ʒ
			UPDATE PackageInfo SET GoodsCount=GoodsCount+@RewardExcharge WHERE UserID=@dwUserID AND GoodsID=50

			-- ������Ʒ
			IF @@ROWCOUNT=0
			BEGIN
				INSERT PackageInfo(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,50,@RewardExcharge)
			END
		END
	END
	ELSE
	BEGIN
		-- ������Ʒ
		UPDATE PackageInfo SET GoodsCount=GoodsCount+1 WHERE UserID=@dwUserID AND GoodsID=@dwLuckyGoodsID

		-- ������Ʒ
		IF @@ROWCOUNT=0
		BEGIN
			INSERT PackageInfo(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@dwLuckyGoodsID,1)
		END
	END
	
	-- ��������
	DECLARE @wKindID INT
	IF @dwOperateGoodsID=1 SET @wKindID=3004
	ELSE IF @dwOperateGoodsID=2 SET @wKindID=3005
	ELSE SET @wKindID=0

	-- �����ƽ�
	IF @wKindID<>0
	BEGIN
		EXEC THPlatformDBLink.THPlatformDB.dbo.GSP_GR_TaskForward @dwUserID,@wKindID,0,1,0,0
	END

	-- ������Ʒ
	UPDATE PackageInfo SET GoodsCount=GoodsCount-1,LuckyGoodsID=0 WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

	-- ������¼
	INSERT RecordPackageInfo(UserID,GoodsID,OperateType,LuckyGoodsID) VALUES (@dwUserID,@dwOperateGoodsID,@cbOperateType,@dwLuckyGoodsID)

	-- ɾ����Ʒ
	DELETE FROM PackageInfo WHERE UserID=@dwUserID AND GoodsCount=0

	-- �������
	SELECT A.GoodsID AS GoodsID,GoodsName,GoodsType,GoodsPrice,GoodsCount,LuckyGoodsID
	FROM PackageInfo A,PackageConfig (NOLOCK) B WHERE A.GoodsID=B.GoodsID AND B.Nullity=0 AND A.UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- �һ�����
CREATE PROC GSP_GP_ExchangeReward
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@cbOperateType TINYINT,						-- ��������
	@dwOperateGoodsID INT,						-- ��Ʒ I D
	@szMobilePhone NVARCHAR(11),				-- �ƶ��绰
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsCount INT
	
	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	
	-- �˻��ж�
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'�����˻���Ϣ�������֤���ٴγ��ԣ�'
		RETURN 1
	END

	-- �����ж�
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'�������������������֤���ٴγ��ԣ�'
		RETURN 2
	END

	-- �ֻ��ж�
	IF LEN(@szMobilePhone)<11
	BEGIN
		SET @strErrorDescribe=N'�����ֻ����������������֤���ٴγ��ԣ�'
		RETURN 3
	END

	-- ��ѯ����
	SELECT @GoodsCount=GoodsCount FROM PackageInfo WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

	-- ���ݵ���
	IF @GoodsCount IS NULL SET @GoodsCount=0

	-- �����ж�
	IF @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'����������Ʒ�����ڣ����֤���ٴγ��ԣ�'
		RETURN 4
	END

	-- ��ֵ�ۼƿ�
	IF @dwOperateGoodsID=50
	BEGIN
		-- �һ�����
		DECLARE @ExchangeCount INT
		SET @ExchangeCount=50

		-- �����ж�
		IF @GoodsCount<@ExchangeCount
		BEGIN
			SET @strErrorDescribe=N'���һ����ۼƿ���������50Ԫ���뼯��50Ԫ���ٽ��жһ���'
			RETURN 5
		END

		-- 50Ԫ��ֵ��
		DECLARE @RechargeCardID INT

		-- ��ѯ��Ʒ
		SELECT @RechargeCardID=GoodsID FROM PackageConfig (NOLOCK) WHERE GoodsType&0x04<>0 AND RewardExcharge=@ExchangeCount

		IF @RechargeCardID IS NULL SET @RechargeCardID=@dwOperateGoodsID
		
		-- ������¼
		INSERT RecordExchangeReward (UserID,GoodsID,MobilePhone) VALUES (@dwUserID,@RechargeCardID,@szMobilePhone)

		-- ������Ʒ
		UPDATE PackageInfo SET GoodsCount=GoodsCount-@ExchangeCount WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

		-- ������¼
		INSERT RecordPackageInfo(UserID,GoodsID,OperateType,LuckyGoodsID) VALUES (@dwUserID,@RechargeCardID,@cbOperateType,0)
	END
	ELSE
	BEGIN
		-- ������¼
		INSERT RecordExchangeReward (UserID,GoodsID,MobilePhone) VALUES (@dwUserID,@dwOperateGoodsID,@szMobilePhone)

		-- ������Ʒ
		UPDATE PackageInfo SET GoodsCount=GoodsCount-1 WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

		-- ������¼
		INSERT RecordPackageInfo(UserID,GoodsID,OperateType,LuckyGoodsID) VALUES (@dwUserID,@dwOperateGoodsID,@cbOperateType,0)
	END

	-- ɾ����Ʒ
	DELETE FROM PackageInfo WHERE UserID=@dwUserID AND GoodsCount=0

	-- �������
	SELECT A.GoodsID AS GoodsID,GoodsName,GoodsType,GoodsPrice,GoodsCount,LuckyGoodsID
	FROM PackageInfo A,PackageConfig (NOLOCK) B WHERE A.GoodsID=B.GoodsID AND B.Nullity=0 AND A.UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- ������Ʒ
CREATE PROC GSP_GP_DiscardGoods
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@cbOperateType TINYINT,						-- ��������
	@dwOperateGoodsID INT,						-- ��Ʒ I D
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsCount INT
	
	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	
	-- �˻��ж�
	IF @LogonPass IS NULL
	BEGIN
		SET @strErrorDescribe=N'�����˻���Ϣ�������֤���ٴγ��ԣ�'
		RETURN 1
	END

	-- �����ж�
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'�������������������֤���ٴγ��ԣ�'
		RETURN 2
	END

	-- ��ѯ����
	SELECT @GoodsCount=GoodsCount FROM PackageInfo WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

	-- ���ݵ���
	IF @GoodsCount IS NULL SET @GoodsCount=0

	-- �����ж�
	IF @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'����������Ʒ�����ڣ����֤���ٴγ��ԣ�'
		RETURN 3
	END

	-- ������Ʒ
	UPDATE PackageInfo SET GoodsCount=GoodsCount-1 WHERE UserID=@dwUserID AND GoodsID=@dwOperateGoodsID

	-- ������¼
	INSERT RecordPackageInfo(UserID,GoodsID,OperateType,LuckyGoodsID) VALUES (@dwUserID,@dwOperateGoodsID,@cbOperateType,0)

	-- ɾ����Ʒ
	DELETE FROM PackageInfo WHERE UserID=@dwUserID AND GoodsCount=0

	-- �������
	SELECT A.GoodsID AS GoodsID,GoodsName,GoodsType,GoodsPrice,GoodsCount,LuckyGoodsID
	FROM PackageInfo A,PackageConfig (NOLOCK) B WHERE A.GoodsID=B.GoodsID AND B.Nullity=0 AND A.UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------