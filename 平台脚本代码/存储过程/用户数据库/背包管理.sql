----------------------------------------------------------------------------------------------------
-- ��Ȩ��2017
-- ʱ�䣺2017-06-26
-- ��;����������
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_QueryPackage]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_QueryPackage]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_OpenBox]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_OpenBox]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_ExchangeFee]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_ExchangeFee]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_ExchangeCurrency]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_ExchangeCurrency]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_PackageLottery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_PackageLottery]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_LoadLotteryConfig]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_LoadLotteryConfig]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_QueryLottery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_QueryLottery]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_OpenPacks]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_OpenPacks]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_RookiePacksTake]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_RookiePacksTake]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- ��ѯ����
CREATE PROCEDURE GSP_MB_QueryPackage
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
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

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
	DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsCount=0

	-- �������
	SELECT A.GoodsID,GoodsName,GoodsType,GoodsPrice,LimitCount,GoodsCount FROM AccountsPackage A,PackageGoodsInfo (NOLOCK) B 
	WHERE A.GoodsID=B.GoodsID AND B.Nullity=0 AND A.UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- ��������
CREATE PROC GSP_MB_OpenBox
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@dwGoodsID INT,								-- ��Ʒ I D
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @Beans AS DECIMAL(18, 2)
	DECLARE @GoodsName AS NVARCHAR(31)
	DECLARE @GoodsType AS TINYINT
	DECLARE @GoodsPrice AS DECIMAL(18, 2)
	DECLARE @GoodsCount AS INT

	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

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
	DECLARE @LockKindID INT
	DECLARE @LockServerID INT
	SELECT @LockKindID=KindID, @LockServerID=ServerID FROM THTreasureDBLink.THTreasureDB.dbo.GameScoreLocker WHERE UserID=@dwUserID

	-- �����ж�
	IF @LockKindID IS NOT NULL AND @LockServerID IS NOT NULL
	BEGIN
		-- ��ѯ��Ϣ
		DECLARE @KindName NVARCHAR(31)
		DECLARE @ServerName NVARCHAR(31)
		SELECT @KindName=KindName FROM THPlatformDBLink.THPlatformDB.dbo.GameKindItem WHERE KindID=@LockKindID
		SELECT @ServerName=ServerName FROM THPlatformDBLink.THPlatformDB.dbo.GameRoomInfo WHERE ServerID=@LockServerID

		-- ������Ϣ
		IF @KindName IS NULL SET @KindName=N'δ֪��Ϸ'
		IF @ServerName IS NULL SET @ServerName=N'δ֪����'
		SET @strErrorDescribe=N'������ [ '+@KindName+N' ] �� [ '+@ServerName+N' ] ��Ϸ�����У����ܽ��е�ǰ������'
		RETURN 3
	END

	-- ��ѯ��ʯ
	SELECT @Beans=Currency FROM THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo WHERE UserID=@dwUserID

	-- ��ѯ��Ʒ
	SELECT @GoodsName=GoodsName,@GoodsType=GoodsType,@GoodsPrice=GoodsPrice 
	FROM PackageGoodsInfo (NOLOCK) WHERE Nullity=0 AND GoodsID=@dwGoodsID

	-- ��ѯ����
	SELECT @GoodsCount=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- ���ݵ���
	IF @Beans IS NULL SET @Beans=0
	IF @GoodsCount IS NULL SET @GoodsCount=0

	-- ��Ʒ�ж�
	IF @GoodsName IS NULL OR @GoodsType IS NULL OR @GoodsPrice IS NULL OR @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'����������Ʒ�����ڣ����֤���ٴγ��ԣ�'
		RETURN 4
	END

	-- �����ж�
	IF @GoodsType<>2
	BEGIN
		SET @strErrorDescribe=N'����������Ʒ���ͷǱ���������Ʒ�����֤���ٴγ��ԣ�'
		RETURN 5
	END

	-- �۸��ж�
	IF @Beans<@GoodsPrice
	BEGIN
		SET @strErrorDescribe=N'������ʯ�������� ' + CONVERT(NVARCHAR,@GoodsPrice) + N' �����������Ϸ��ֵҳ����г�ֵ��'
		RETURN 6
	END
	
--���Զ���
--DECLARE @dwUserID AS INT
--DECLARE @dwGoodsID AS INT
--SET @dwUserID=15024
--SET @dwGoodsID=202

	-- ��������
	DECLARE @RandRange AS INT
	DECLARE @MaxRange AS INT
	DECLARE @dwLuckyGoodsID AS INT
	DECLARE @dwLuckyGoodsCount AS INT
	DECLARE @RechargeAmount AS DECIMAL(18, 2)
	DECLARE @RewardLimit AS INT
	DECLARE @OpenBoxCount AS INT
	DECLARE @PackageFee AS INT
	DECLARE @ExchangeFee AS INT
	DECLARE @FeeGoodsID AS INT
	
	-- ��ֵ���
	SELECT @RechargeAmount=ISNULL(SUM(PayAmount),0) FROM THTreasureDBLink.THTreasureDB.dbo.ShareDetailInfo WHERE UserID=@dwUserID

	declare @isUse int
	select @isUse=isUse  FROM [THPlatformDB].[dbo].[SelectPlatform](nolock) where ID = 1
	if @isUse is null set @isUse = 0

	-- ��������
	SELECT TOP 1 @RewardLimit=RewardLimit FROM RewardLimit WHERE RechargeAmount<=@RechargeAmount and isUse = @isUse ORDER BY RewardLimit DESC

	-- ��������
	SET @FeeGoodsID=301
	IF @RewardLimit IS NULL SET @RewardLimit=36

	-- �������
	SELECT @OpenBoxCount=COUNT(*) FROM PackageRecord WHERE UserID=@dwUserID AND RecordType=1 AND GoodsID=@dwGoodsID

	-- ��������
	SELECT @PackageFee=ISNULL(SUM(GoodsCount),0) FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@FeeGoodsID

	-- �һ�����
	SELECT @ExchangeFee=ISNULL(SUM(GoodsCount),0) FROM PackageExchangeFee WHERE UserID=@dwUserID AND GoodsID=@FeeGoodsID

	-- ���ݵ���
	IF @OpenBoxCount IS NULL SET @OpenBoxCount=0
	IF @PackageFee IS NULL SET @PackageFee=0
	IF @ExchangeFee IS NULL SET @ExchangeFee=0

	-- �����ж�
	IF @OpenBoxCount=0 AND (@PackageFee+@ExchangeFee+10<@RewardLimit) and @isUse = 0
	BEGIN
		-- �ƽ����״α�����Ԫ����
		IF @dwGoodsID=201 
		BEGIN
			SET @dwLuckyGoodsID=@FeeGoodsID
			SET @dwLuckyGoodsCount=5
		END

		-- ��ʯ�����״α���ʮԪ����
		ELSE IF @dwGoodsID=202 
		BEGIN
			SET @dwLuckyGoodsID=@FeeGoodsID
			SET @dwLuckyGoodsCount=10
		END
	END
	ELSE
	BEGIN
		-- �������
		SELECT @MaxRange=MAX(RangeEnd) FROM PackageBoxConfig WHERE GoodsID=@dwGoodsID and isUse = @isUse
		WHILE 1=1
		BEGIN
			-- �������
			SET @RandRange=CAST(CEILING(RAND()*@MaxRange) AS INT)

			-- �н���Ʒ
			SELECT @dwLuckyGoodsID=LuckyGoodsID,@dwLuckyGoodsCount=LuckyGoodsCount FROM PackageBoxConfig 
			WHERE GoodsID=@dwGoodsID AND @RandRange>=RangeStart AND @RandRange<=RangeEnd and isUse = @isUse
			
			-- ��������
			IF @dwLuckyGoodsID=@FeeGoodsID AND @PackageFee+@ExchangeFee+@dwLuckyGoodsCount>=@RewardLimit
			BEGIN
				CONTINUE
			END

			BREAK
		END
	END

	-- ���ݵ���
	IF @dwLuckyGoodsID IS NULL OR @dwLuckyGoodsCount IS NULL
	BEGIN
		SET @dwLuckyGoodsID=501
		SET @dwLuckyGoodsCount=20000		--THAccountsDB.dbo.PackagePacksConfig.PacksGoodsCount 701,501,20000
		-- return 1
	END

	-- ���±�ʯ
	UPDATE THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo SET Currency=Currency-@GoodsPrice WHERE UserID=@dwUserID

	-- ���±���
	UPDATE AccountsPackage SET GoodsCount=GoodsCount-1 WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	IF @dwLuckyGoodsID<>501
	BEGIN
		-- ������Ʒ
		UPDATE AccountsPackage SET GoodsCount=GoodsCount+@dwLuckyGoodsCount WHERE UserID=@dwUserID AND GoodsID=@dwLuckyGoodsID

		-- ������Ʒ
		IF @@ROWCOUNT=0
		BEGIN
			INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@dwLuckyGoodsID,@dwLuckyGoodsCount)
		END
	END

	-- ������¼
	DECLARE @RecordNote AS NVARCHAR(32)
	SET @RecordNote = N'���� ' + @GoodsName + N' ���'
	-- IF @dwLuckyGoodsID<>501
	-- BEGIN
		INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@dwUserID,2,@dwLuckyGoodsID,@dwLuckyGoodsCount,@RecordNote)
	-- END
	INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@dwGoodsID,1)

	-- ɾ����Ʒ
	DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsCount=0

	if @dwLuckyGoodsID= 501 and @dwLuckyGoodsCount > 0
	begin
		update [THTreasureDB].[dbo].[GameScoreInfo] set score=score+@dwLuckyGoodsCount where userid = @dwUserID
		INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@dwLuckyGoodsID,@dwLuckyGoodsCount)
	end
	-- ��������
	DECLARE @wKindID INT
	IF @dwGoodsID=201 SET @wKindID=3004
	ELSE IF @dwGoodsID=202 SET @wKindID=3005
	ELSE SET @wKindID=0

	-- �����ƽ�
	IF @wKindID<>0
	BEGIN
		EXEC GSP_MB_TaskForward @dwUserID,@wKindID,0,1,0,0
	END

	-- ������� dwGoodsID�����ı���id,dwGoodCt �����ı�������
	SELECT GoodsID,GoodsName,GoodsType,@dwLuckyGoodsCount AS GoodsCount,@dwGoodsID as dwGoodsID,1 as dwGoodCt  FROM PackageGoodsInfo WHERE Nullity=0 AND GoodsID=@dwLuckyGoodsID
	
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------

-- �һ�����
CREATE PROC GSP_MB_ExchangeFee
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@dwGoodsID INT,								-- ��Ʒ I D
	@szMobilePhone NVARCHAR(11),				-- �ƶ��绰
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsType AS TINYINT
	DECLARE @LimitCount AS INT
	DECLARE @GoodsCount AS INT

	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

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

	-- ��ѯ��Ʒ
	SELECT @GoodsType=GoodsType,@LimitCount=LimitCount FROM PackageGoodsInfo (NOLOCK) WHERE Nullity=0 AND GoodsID=@dwGoodsID

	-- ��ѯ����
	SELECT @GoodsCount=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- ���ݵ���
	IF @LimitCount IS NULL SET @LimitCount=0
	IF @GoodsCount IS NULL SET @GoodsCount=0

	-- ��Ʒ�ж�
	IF @GoodsType IS NULL OR @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'����������Ʒ�����ڣ����֤���ٴγ��ԣ�'
		RETURN 3
	END

	-- �����ж�
	IF @GoodsType<>3
	BEGIN
		SET @strErrorDescribe=N'����������Ʒ���ͷǻ���������Ʒ�����֤���ٴγ��ԣ�'
		RETURN 4
	END

	-- �һ�����
	IF @GoodsCount<@LimitCount OR @LimitCount=0
	BEGIN
		SET @strErrorDescribe=N'���һ��Ļ��ѿ��������� ' + CONVERT(NVARCHAR,@LimitCount) + N' Ԫ���뼯����ٽ��жһ���'
		RETURN 5
	END

	-- �ֻ��ж�
	IF LEN(@szMobilePhone)<>11
	BEGIN
		SET @strErrorDescribe=N'�����ֻ����������������֤���ٴγ��ԣ�'
		RETURN 6
	END

	-- ������Ʒ
	UPDATE AccountsPackage SET GoodsCount=GoodsCount-@LimitCount WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- ������¼
	INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@dwGoodsID,@LimitCount)

	-- �һ���¼
	INSERT PackageExchangeFee(UserID,MobilePhone,GoodsID,GoodsCount) VALUES (@dwUserID,@szMobilePhone,@dwGoodsID,@LimitCount)

	-- ɾ����Ʒ
	DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsCount=0

	-- ������Ϣ
	SET @strErrorDescribe=N'���Ѷһ��ɹ�������3-5���������ڵ��ˣ�'

	select @dwGoodsID as dwGoodsID,@GoodsCount as GoodsCount
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- �һ�����
CREATE PROC GSP_MB_ExchangeCurrency
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �Ƹ�����
DECLARE @Score BIGINT
DECLARE @Beans DECIMAL(18, 2)

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @BeansGoodsID AS INT
	DECLARE @ScoreGoodsID AS INT
	DECLARE @BeansGoodsCount AS INT
	DECLARE @ScoreGoodsCount AS INT

	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

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

	-- ��ѯ��ʯ
	SET @BeansGoodsID=401
	SELECT @BeansGoodsCount=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@BeansGoodsID

	-- �һ���ʯ
	IF @BeansGoodsCount IS NOT NULL
	BEGIN
		-- ���±�ʯ
		UPDATE THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo SET Currency=Currency+@BeansGoodsCount WHERE UserID=@dwUserID

		-- ���뱦ʯ
		IF @@ROWCOUNT=0
		BEGIN
			INSERT THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo(UserID,Currency) VALUES (@dwUserID,@BeansGoodsCount)
		END

		-- ɾ����Ʒ
		DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@BeansGoodsID

		-- ������¼
		INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@BeansGoodsID,@BeansGoodsCount)
	END

	-- ��ѯ���
	SET @ScoreGoodsID=501
	SELECT @ScoreGoodsCount=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@ScoreGoodsID

	-- �һ����
	IF @ScoreGoodsCount IS NOT NULL
	BEGIN
		-- ���½��
		UPDATE THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo SET Score=Score+@ScoreGoodsCount WHERE UserID=@dwUserID

		-- ������
		IF @@ROWCOUNT=0
		BEGIN
			INSERT THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo(UserID,Score) VALUES (@dwUserID,@ScoreGoodsCount)
		END

		-- ɾ����Ʒ
		DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@ScoreGoodsID

		-- ������¼
		INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@ScoreGoodsID,@ScoreGoodsCount)
	END
	
	-- ��ѯ����
	SELECT @Score=Score FROM THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID

	-- ��ѯ��ʯ
	SELECT @Beans=Currency FROM THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo WHERE UserID=@dwUserID

	-- ���ݵ���
	IF @Score IS NULL SET @Score=0
	IF @Beans IS NULL SET @Beans=0

	-- �������
	SELECT @Score AS Score, @Beans AS Beans
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- �����齱
CREATE PROC GSP_MB_PackageLottery
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@dwGoodsID INT,								-- ��Ʒ I D
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsType AS TINYINT
	DECLARE @GoodsName AS NVARCHAR(31)
	DECLARE @GoodsCount AS INT

	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

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

	-- ��ѯ��Ʒ
	SELECT @GoodsName=GoodsName,@GoodsType=GoodsType FROM PackageGoodsInfo (NOLOCK) WHERE Nullity=0 AND GoodsID=@dwGoodsID

	-- ��ѯ����
	SELECT @GoodsCount=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- ���ݵ���
	IF @GoodsCount IS NULL OR @GoodsCount<0 SET @GoodsCount=0

	-- ��Ʒ�ж�
	IF @GoodsCount<10
	BEGIN
		SET @strErrorDescribe=N'���Ľ�ȯ����10�ţ�'
		RETURN 3
	END

	-- ��Ʒ�ж�
	IF @GoodsName IS NULL OR @GoodsType IS NULL OR @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'����������Ʒ�����ڣ����֤���ٴγ��ԣ�'
		RETURN 3
	END

	-- �����ж�
	IF @GoodsType<>8
	BEGIN
		SET @strErrorDescribe=N'����������Ʒ���ͷǳ齱������Ʒ�����֤���ٴγ��ԣ�'
		RETURN 4
	END

--���Զ���
--DECLARE @dwUserID AS INT
--DECLARE @dwGoodsID AS INT
--SET @dwUserID=15024
--SET @dwGoodsID=202

	-- ��������
	DECLARE @RandRange AS INT
	DECLARE @MaxRange AS INT
	DECLARE @ItemIndex AS INT
	DECLARE @dwLuckyGoodsID AS INT
	DECLARE @dwLuckyGoodsCount AS INT
	DECLARE @RechargeAmount AS DECIMAL(18, 2)
	DECLARE @RewardLimit AS INT
	DECLARE @PackageFee AS INT
	DECLARE @ExchangeFee AS INT
	DECLARE @TotalScore AS BIGINT
	DECLARE @FeeGoodsID AS INT
	DECLARE @ScoreGoodsID AS INT
	DECLARE @LotteryTimes AS INT
	
	-- ��ֵ���
	SELECT @RechargeAmount=ISNULL(SUM(PayAmount),0) FROM THTreasureDBLink.THTreasureDB.dbo.ShareDetailInfo WHERE UserID=@dwUserID

	-- ��������
	SELECT TOP 1 @RewardLimit=RewardLimit FROM RewardLimit WHERE RechargeAmount<=@RechargeAmount ORDER BY RewardLimit DESC

	-- ��������
	SET @FeeGoodsID=301
	IF @RewardLimit IS NULL SET @RewardLimit=36

	-- ��������
	SELECT @PackageFee=ISNULL(SUM(GoodsCount),0) FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@FeeGoodsID

	-- �һ�����
	SELECT @ExchangeFee=ISNULL(SUM(GoodsCount),0) FROM PackageExchangeFee WHERE UserID=@dwUserID AND GoodsID=@FeeGoodsID

	-- ��ҽ��
	SET @ScoreGoodsID=501
	SELECT @TotalScore=Score+InsureScore FROM THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID

	-- ���ݵ���
	IF @PackageFee IS NULL SET @PackageFee=0
	IF @ExchangeFee IS NULL SET @ExchangeFee=0
	IF @TotalScore IS NULL SET @TotalScore=0

	-- �������
	SELECT @MaxRange=MAX(RangeEnd) FROM LotteryConfig
	WHILE 1=1
	BEGIN
		-- �������
		SET @RandRange=CAST(CEILING(RAND()*@MaxRange) AS INT)

		-- �н���Ʒ
		SELECT @ItemIndex=ItemIndex,@dwLuckyGoodsID=LuckyGoodsID,@dwLuckyGoodsCount=LuckyGoodsCount FROM LotteryConfig 
		WHERE @RandRange>=RangeStart AND @RandRange<=RangeEnd
		
		-- ��������
		IF @dwLuckyGoodsID=@FeeGoodsID AND @PackageFee+@ExchangeFee+@dwLuckyGoodsCount>=@RewardLimit
		BEGIN
			CONTINUE
		END

		-- ���ѱ���
		IF @TotalScore>10000 AND @dwLuckyGoodsID<>@FeeGoodsID AND @PackageFee+@ExchangeFee<=10
		BEGIN
			CONTINUE
		END

		-- �������
		IF @TotalScore<3000 AND @dwLuckyGoodsID<>@ScoreGoodsID
		BEGIN
			CONTINUE
		END

		-- �������
		IF @TotalScore>20000 AND @dwLuckyGoodsID=@ScoreGoodsID
		BEGIN
			CONTINUE
		END

		BREAK
	END

	-- ���ݵ���
	IF @ItemIndex IS NULL OR @dwLuckyGoodsID IS NULL OR @dwLuckyGoodsCount IS NULL
	BEGIN
		SET @ItemIndex=2
		SET @dwLuckyGoodsID=501
		SET @dwLuckyGoodsCount=2888
	END

--�������
--SELECT @RandRange,@dwLuckyGoodsID,@dwLuckyGoodsCount

	-- ���³齱
	UPDATE AccountsPackage SET GoodsCount=GoodsCount-10 WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- ������Ʒ
	UPDATE AccountsPackage SET GoodsCount=GoodsCount+@dwLuckyGoodsCount WHERE UserID=@dwUserID AND GoodsID=@dwLuckyGoodsID

	-- ������Ʒ
	IF @@ROWCOUNT=0
	BEGIN
		INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@dwLuckyGoodsID,@dwLuckyGoodsCount)
	END

	-- ������¼
	DECLARE @RecordNote AS NVARCHAR(32)
	SET @RecordNote = N'ʹ�� ' + @GoodsName + N' ���'
	INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@dwGoodsID,1)
	INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@dwUserID,2,@dwLuckyGoodsID,@dwLuckyGoodsCount,@RecordNote)

	-- ɾ����Ʒ
	DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsCount=0
	
	-- �齱����
	SELECT @LotteryTimes=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID
	
	-- ���ݵ���
	IF @LotteryTimes IS NULL SET @LotteryTimes=0

	-- �������
	SELECT @LotteryTimes AS LotteryTimes,@ItemIndex AS ItemIndex,GoodsID,GoodsName,GoodsType,@dwLuckyGoodsCount AS GoodsCount,
	@GoodsCount as consumeGoodsCount,@dwGoodsID as consumedwGoodsID
	FROM PackageGoodsInfo WHERE Nullity=0 AND GoodsID=@dwLuckyGoodsID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- �齱����
CREATE PROC GSP_MB_LoadLotteryConfig
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	-- �������
	SELECT ItemIndex,LuckyGoodsID AS GoodsID,LuckyGoodsCount AS GoodsCount FROM LotteryConfig
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- ��ѯ�齱
CREATE PROC GSP_MB_QueryLottery
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strMachineID NVARCHAR(32),					-- ������ʶ
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)

	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

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

	DECLARE @TakeDateTime AS DATETIME
	DECLARE @LotteryTimes AS INT
	DECLARE @GoodsID AS INT
	DECLARE @GoodsCount AS INT
	
	-- ������Ʒ
	SET @GoodsID=801
	SET @GoodsCount=10
	
	-- ��ȡʱ��
	SELECT @TakeDateTime=TakeDateTime FROM AccountsLottery WHERE UserID=@dwUserID

	-- �״���ȡ
	IF @TakeDateTime IS NULL
	BEGIN
		INSERT AccountsLottery(UserID,TakeDateTime) VALUES (@dwUserID,GetDate())

		-- ������Ʒ
		UPDATE AccountsPackage SET GoodsCount=GoodsCount+@GoodsCount WHERE UserID=@dwUserID AND GoodsID=@GoodsID

		-- ������Ʒ
		IF @@ROWCOUNT=0
		BEGIN
			INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@GoodsID,@GoodsCount)
		END

--		-- ���±�ʯ
--		UPDATE THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo SET Currency=Currency+1000 WHERE UserID=@dwUserID
--
--		-- ���뱦ʯ
--		IF @@ROWCOUNT=0
--		BEGIN
--			INSERT THTreasureDBLink.THTreasureDB.dbo.UserCurrencyInfo(UserID,Currency) VALUES (@dwUserID,1000)
--		END

		-- ���½��
		UPDATE THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo SET Score=Score WHERE UserID=@dwUserID

		-- ������
		IF @@ROWCOUNT=0
		BEGIN
			INSERT THTreasureDBLink.THTreasureDB.dbo.GameScoreInfo(UserID,Score) VALUES (@dwUserID,0)
		END
	END
	ELSE
	BEGIN
		-- ��ȡ�ж�
		IF DateDiff(dd,@TakeDateTime,GetDate())<>0
		BEGIN
			UPDATE AccountsLottery SET TakeDateTime=GetDate() WHERE UserID=@dwUserID

			-- ������Ʒ
			UPDATE AccountsPackage SET GoodsCount=GoodsCount+@GoodsCount WHERE UserID=@dwUserID AND GoodsID=@GoodsID

			-- ������Ʒ
			IF @@ROWCOUNT=0
			BEGIN
				INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@GoodsID,@GoodsCount)
			END
		END
	END

	-- ��ѯ����
	SELECT @LotteryTimes=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@GoodsID
	
	-- ���ݵ���
	IF @LotteryTimes IS NULL SET @LotteryTimes=0

	-- �������
	SELECT @LotteryTimes AS LotteryTimes
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- �����
CREATE PROC GSP_MB_OpenPacks
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@dwGoodsID INT,								-- ��Ʒ I D
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsName AS NVARCHAR(31)
	DECLARE @GoodsType AS TINYINT
	DECLARE @GoodsCount AS INT

	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

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

	-- ��ѯ��Ʒ
	SELECT @GoodsName=GoodsName,@GoodsType=GoodsType FROM PackageGoodsInfo (NOLOCK) WHERE Nullity=0 AND GoodsID=@dwGoodsID

	-- ��ѯ����
	SELECT @GoodsCount=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- ���ݵ���
	IF @GoodsCount IS NULL SET @GoodsCount=0

	-- ��Ʒ�ж�
	IF @GoodsName IS NULL OR @GoodsType IS NULL OR @GoodsCount=0
	BEGIN
		SET @strErrorDescribe=N'����������Ʒ�����ڣ����֤���ٴγ��ԣ�'+@GoodsName+N'_'+CAST(@GoodsType AS VARCHAR(100))+N'_'+CAST(@GoodsCount AS VARCHAR(100))+N'_'+CAST(@dwUserID AS VARCHAR(100))
		RETURN 3
	END

	-- �����ж�
	IF @GoodsType<>7
	BEGIN
		SET @strErrorDescribe=N'����������Ʒ���ͷ����������Ʒ�����֤���ٴγ��ԣ�'
		RETURN 4
	END

	DECLARE @dwPacksGoodsID AS INT
	DECLARE @dwPacksGoodsCount AS INT
	DECLARE @i INT
	DECLARE @count INT
	
	-- �������
	UPDATE AccountsPackage SET GoodsCount=GoodsCount-1 WHERE UserID=@dwUserID AND GoodsID=@dwGoodsID

	-- ������¼
	INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,@dwGoodsID,1)

	declare @isUse int
	select @isUse=isUse  FROM [THPlatformDB].[dbo].[SelectPlatform](nolock) where ID = 1
	if @isUse is null set @isUse = 0

	-- ѭ�����
	SET @i = 1
	SELECT @count = COUNT(*) FROM PackagePacksConfig WHERE GoodsID=@dwGoodsID and isUse = @isUse
	WHILE (@i <= @count)
	BEGIN
		-- �����Ʒ
		SELECT @dwPacksGoodsID=PacksGoodsID,@dwPacksGoodsCount=PacksGoodsCount FROM (SELECT ROW_NUMBER() OVER 
		(ORDER BY PacksGoodsID) AS RowNumber,PacksGoodsID,PacksGoodsCount FROM PackagePacksConfig WHERE GoodsID=@dwGoodsID and isUse = @isUse) A WHERE A.RowNumber = @i

		-- ������Ʒ
		UPDATE AccountsPackage SET GoodsCount=GoodsCount+@dwPacksGoodsCount WHERE UserID=@dwUserID AND GoodsID=@dwPacksGoodsID

		-- ������Ʒ
		IF @@ROWCOUNT=0
		BEGIN
			INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@dwPacksGoodsID,@dwPacksGoodsCount)
		END


		IF @dwPacksGoodsID=501
		BEGIN
			DECLARE @dwPacksGoodsCountTmp AS INT
			SET @dwPacksGoodsCountTmp=NULL
			SELECT @dwPacksGoodsCountTmp=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwPacksGoodsID

			IF @dwPacksGoodsCountTmp IS NOT NULL
			BEGIN
				-- ���½��
				UPDATE THTreasureDB.dbo.GameScoreInfo SET Score=Score+@dwPacksGoodsCountTmp WHERE UserID=@dwUserID

				-- ������
				IF @@ROWCOUNT=0
				BEGIN
					INSERT THTreasureDB.dbo.GameScoreInfo(UserID,Score) VALUES (@dwUserID,@dwPacksGoodsCountTmp)
				END
				-- ɾ����Ʒ
				DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsID=@dwPacksGoodsID
			END
		END


		-- ������¼
		DECLARE @RecordNote AS NVARCHAR(32)
		SET @RecordNote = N'�� ' + @GoodsName + N' ���'
		INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@dwUserID,2,@dwPacksGoodsID,@dwPacksGoodsCount,@RecordNote)

		SET @i=@i+1
	END

	-- ɾ����Ʒ
	DELETE FROM AccountsPackage WHERE UserID=@dwUserID AND GoodsCount=0

	-- �������
	SELECT @dwGoodsID AS PacksID,B.GoodsID AS GoodsID,B.GoodsName AS GoodsName,B.GoodsType AS GoodsType,A.PacksGoodsCount AS GoodsCount,1 as consumeGoodsCt
	FROM PackagePacksConfig A,PackageGoodsInfo (NOLOCK) B WHERE A.PacksGoodsID=B.GoodsID AND B.Nullity=0 AND A.GoodsID=@dwGoodsID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- ��ȡ���
CREATE PROC GSP_MB_RookiePacksTake
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strMachineID NVARCHAR(32),					-- ������ʶ
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)

	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM AccountsInfo WHERE UserID=@dwUserID

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

	DECLARE @TakeStatus AS TINYINT
	DECLARE @GoodsID AS INT
	DECLARE @GoodsCount AS INT
	SET @GoodsID=701
	SET @GoodsCount=1

	-- ��ȡ״̬
	IF EXISTS (SELECT * FROM RookiePacks WHERE UserID=@dwUserID)
	BEGIN
		SET @TakeStatus=1
	END
	ELSE
	BEGIN
		SET @TakeStatus=0
		
		-- ������Ʒ
		UPDATE AccountsPackage SET GoodsCount=GoodsCount+@GoodsCount WHERE UserID=@dwUserID AND GoodsID=@GoodsID

		-- ������Ʒ
		IF @@ROWCOUNT=0
		BEGIN
			INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@GoodsID,@GoodsCount)
		END

		-- д���¼
		INSERT RookiePacks(UserID) VALUES (@dwUserID)

		-- ������¼
		INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@dwUserID,2,@GoodsID,@GoodsCount,N'��ȡ�������')
	END

	-- �������
	SELECT @TakeStatus AS TakeStatus,GoodsID,GoodsName,GoodsType,@GoodsCount AS GoodsCount 
	FROM PackageGoodsInfo WHERE Nullity=0 AND GoodsID=@GoodsID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------