----------------------------------------------------------------------------------------------------
-- ��Ȩ��2017
-- ʱ�䣺2017-08-07
-- ��;���������
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_RedPacketConfig]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_RedPacketConfig]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_QueryRedPacket]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_QueryRedPacket]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_RedPacketLottery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_RedPacketLottery]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_AliPayQuery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_AliPayQuery]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_AliPayUpdate]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_AliPayUpdate]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO


----------------------------------------------------------------------------------------------------

-- �������
CREATE PROC GSP_MB_RedPacketConfig
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	declare @isUse int
	select @isUse=isUse  FROM [THPlatformDB].[dbo].[SelectPlatform](nolock) where ID = 1 
	if @isUse is null set @isUse = 0
	-- �������
	SELECT ItemIndex,LuckyGoodsID AS GoodsID,LuckyGoodsCount AS GoodsCount FROM RedPacketConfig where isUse = @isUse
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- ��ѯ���
CREATE PROC GSP_MB_QueryRedPacket
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
	-- ��ѯ����
	DECLARE @Consume AS DECIMAL(18, 2)
	SELECT @Consume=Consume FROM RedPacketStorage WHERE Nullity=0

	-- ���ݵ���
	IF @Consume IS NULL SET @Consume=0
	
	-- �������
	SELECT @Consume AS Consume
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- ����齱
create PROC GSP_MB_RedPacketLottery
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strMachineID NVARCHAR(32),					-- ������ʶ
	@wLotteryNum INT,							-- �齱����
	@UseCharm TINYINT,							-- =1,����ֵ�齱
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @Beans AS DECIMAL(18, 2)
	DECLARE @Consume AS DECIMAL(18, 2)
	DECLARE @Deduct AS DECIMAL(18, 2)
	DECLARE @Storage AS DECIMAL(18, 2)


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

	
	-- ��ѯ����
	SELECT @Consume=Consume,@Deduct=Deduct,@Storage=Storage FROM RedPacketStorage WHERE Nullity=0

	-- �����ж�
	IF @Consume IS NULL OR @Deduct IS NULL OR @Storage IS NULL
	BEGIN
		SET @strErrorDescribe=N'�齱������Ϣ��������ϵ�ͷ������'
		RETURN 4
	END

	-- ��ѯ����������ֵת���ת�̵Ĵ���
	declare @todays date
	declare @cts int
	declare @charm int
	declare @ischarm int
	set @ischarm = 1
	set @todays = convert(varchar,getdate(),23)
	select @cts = counts FROM LuckDraw(nolock) where [UserID] = @dwUserID and [dates] = @todays
	declare @gcts int 
	select @gcts=GoodsCount  FROM AccountsPackage(nolock) where [UserID] = @dwUserID and [GoodsID] = 1001
	if @gcts is null set @gcts = 0
	if @cts is null set @cts = 0
	-- if @cts < 3 and @gcts > 0
	if @UseCharm = 1
	begin
		-- ��ѯ����ֵ
		if @cts >= 3
		begin
			SET @strErrorDescribe=N'�������������꣬������������'
			RETURN 7
		end

		if @gcts = 0
		begin
			SET @strErrorDescribe=N'����ֵ����,������ʯ�齱��'
			RETURN 8
		end

		update AccountsPackage set GoodsCount = GoodsCount - 10 WHERE UserID=@dwUserID and [GoodsID] = 1001
		if @@ROWCOUNT = 0
		begin
			SET @strErrorDescribe=N'����ֵ����,������ʯ�齱��'
			RETURN 8
		end
		SELECT @charm=GoodsCount FROM AccountsPackage WHERE UserID=@dwUserID and [GoodsID] = 1001
		if @charm is null set @charm = 0
		set @ischarm = 1

		if @charm < 0
		begin
			update AccountsPackage set GoodsCount = GoodsCount + 10 WHERE UserID=@dwUserID and [GoodsID] = 1001
			SET @strErrorDescribe=N'����ֵ����,������ʯ�齱��'
			RETURN 8
		end
		else
		begin
			INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount) VALUES (@dwUserID,1,1001,10)
			update LuckDraw set counts = counts+1 where UserID = @dwUserID and dates = @todays
			if @@ROWCOUNT = 0
			insert into LuckDraw(UserID,counts,dates) values(@dwUserID,1,@todays)
		end
	end
	else
	begin

		-- ��ѯ��ʯ
		declare @baos int
		update THTreasureDB.dbo.UserCurrencyInfo set Currency = Currency - @Consume WHERE UserID=@dwUserID
		set @baos=@@rowcount
		IF @baos=0 
		BEGIN
			SET @strErrorDescribe=N'������ʯ�������� ' + CONVERT(NVARCHAR,@Consume) + N' �����������Ϸ��ֵҳ����г�ֵ��'
			RETURN 6
		END

		SELECT @Beans=Currency FROM THTreasureDB.dbo.UserCurrencyInfo WHERE UserID=@dwUserID
		set @ischarm = 2

	    -- ���ݵ���
		IF @Beans IS NULL SET @Beans=0
		IF @Consume IS NULL SET @Consume=0

		-- ��ʯ�ж�
		IF @Beans<0 
		BEGIN
			update THTreasureDB.dbo.UserCurrencyInfo set Currency = Currency + @Consume WHERE UserID=@dwUserID
			SET @strErrorDescribe=N'������ʯ�������� ' + CONVERT(NVARCHAR,@Consume) + N' �����������Ϸ��ֵҳ����г�ֵ��'
			RETURN 5
		END
	end

	-- ��������
	DECLARE @RandRange AS INT
	DECLARE @MaxRange AS INT
	DECLARE @ItemIndex AS INT
	DECLARE @dwLuckyGoodsID AS INT
	DECLARE @dwLuckyGoodsCount AS INT

	-- �齱����
	-- DECLARE @LotteryCount AS INT
	-- SELECT @LotteryCount=COUNT(*) FROM RedPacketLotteryRecord WHERE UserID=@dwUserID

	-- �����ж�
	-- IF @LotteryCount=0
	-- BEGIN
		-- SET @RandRange=CAST(FLOOR(RAND()*100) AS INT)
		-- IF @RandRange<30
		-- BEGIN
			-- SET @ItemIndex=9
			-- SET @dwLuckyGoodsID=901
			-- SET @dwLuckyGoodsCount=2
		-- END
		-- ELSE
		-- BEGIN
			-- SET @ItemIndex=4
			-- SET @dwLuckyGoodsID=901
			-- SET @dwLuckyGoodsCount=5
		-- END
	-- END
	-- ELSE
	-- BEGIN

		declare @isUse int
		select @isUse=isUse  FROM [THPlatformDB].[dbo].[SelectPlatform](nolock) where ID = 1 
		if @isUse is null set @isUse = 0

		-- �������
		SELECT @MaxRange=MAX(RangeEnd) FROM RedPacketConfig where isUse = @isUse

		WHILE 1=1
		BEGIN
			-- �������
			SET @RandRange=CAST(CEILING(RAND()*@MaxRange) AS INT)

		

			-- �н���Ʒ
			SELECT @ItemIndex=ItemIndex,@dwLuckyGoodsID=LuckyGoodsID,@dwLuckyGoodsCount=LuckyGoodsCount 
			FROM RedPacketConfig WHERE @RandRange>=RangeStart AND @RandRange<=RangeEnd and isUse = @isUse

--			IF @ItemIndex=2 OR @ItemIndex=4 OR @ItemIndex=6 OR @ItemIndex=7 OR @ItemIndex=8 OR @ItemIndex=9 OR @ItemIndex=10 OR @ItemIndex=12
--			BEGIN
--				CONTINUE
--			END

			-- �жϿ��
			IF @dwLuckyGoodsID=901 AND @dwLuckyGoodsCount>@Storage
			BEGIN
				CONTINUE
			END

			BREAK
		END

		-- ���¿��
		IF @dwLuckyGoodsID=901
		BEGIN
			UPDATE RedPacketStorage SET Storage=Storage-@dwLuckyGoodsCount WHERE Nullity=0
		END
		UPDATE RedPacketStorage SET Storage=Storage+@Consume*(1.0-@Deduct) WHERE Nullity=0
	-- END

	-- ���ݵ���
	IF @ItemIndex IS NULL OR @dwLuckyGoodsID IS NULL OR @dwLuckyGoodsCount IS NULL
	BEGIN
		SET @ItemIndex=4
		SET @dwLuckyGoodsID=501
		SET @dwLuckyGoodsCount=20000
	END

	-- ������Ʒ
	UPDATE AccountsPackage SET GoodsCount=GoodsCount+@dwLuckyGoodsCount WHERE UserID=@dwUserID AND GoodsID=@dwLuckyGoodsID

	-- ������Ʒ
	IF @@ROWCOUNT=0
	BEGIN
		INSERT AccountsPackage(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@dwLuckyGoodsID,@dwLuckyGoodsCount)
	END

	-- ������¼
	DECLARE @RecordNote AS NVARCHAR(32)
	-- SET @RecordNote = N'����齱���'
	 SET @RecordNote = N'����ת�̶��Ż��'
	INSERT PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@dwUserID,2,@dwLuckyGoodsID,@dwLuckyGoodsCount,@RecordNote)

	-- �齱��¼
	INSERT RedPacketLotteryRecord(UserID,GoodsID,GoodsCount) VALUES (@dwUserID,@dwLuckyGoodsID,@dwLuckyGoodsCount)

	-- �������
	SELECT @ItemIndex AS ItemIndex,GoodsID,GoodsName,GoodsType,@dwLuckyGoodsCount AS GoodsCount,@ischarm as ischarm
	FROM PackageGoodsInfo WHERE Nullity=0 AND GoodsID=@dwLuckyGoodsID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- ֧������ѯ
CREATE PROC GSP_MB_AliPayQuery
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @BindingStatus AS TINYINT
	DECLARE @PayeeAccount AS NVARCHAR(100)
	DECLARE @PayeeRealName AS NVARCHAR(100)

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
	
	-- ֧������ѯ
	SELECT @PayeeAccount=PayeeAccount,@PayeeRealName=PayeeRealName FROM AliPayBindingInfo WHERE UserID=@dwUserID

	-- ���ж�
	IF @PayeeAccount IS NULL OR @PayeeRealName IS NULL
	BEGIN
		SET @BindingStatus=0
	END
	ELSE
	BEGIN
		SET @BindingStatus=1
	END

	-- ���ݵ���
	IF @PayeeAccount IS NULL SET @PayeeAccount=N''
	IF @PayeeRealName IS NULL SET @PayeeRealName=N''

	-- �������
	SELECT @BindingStatus AS BindingStatus,@PayeeAccount AS PayeeAccount,@PayeeRealName AS PayeeRealName
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- ֧��������
CREATE PROC GSP_MB_AliPayUpdate
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@strPayeeAccount NVARCHAR(100),				-- ֧�����˺�
	@strPayeeRealName NVARCHAR(100),			-- ֧��������
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @BindingStatus AS TINYINT
	DECLARE @PayeeAccount AS NVARCHAR(100)
	DECLARE @PayeeRealName AS NVARCHAR(100)

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

	-- ֧�����˺�
	IF @strPayeeAccount=N''
	BEGIN
		SET @strErrorDescribe=N'����֧�����˺������������֤���ٴγ��ԣ�'
		RETURN 3
	END

	-- ֧��������
	IF @PayeeRealName=N''
	BEGIN
		SET @strErrorDescribe=N'����֧�������������������֤���ٴγ��ԣ�'
		RETURN 4
	END

	-- ֧��������
	UPDATE AliPayBindingInfo SET PayeeAccount=@strPayeeAccount,PayeeRealName=@strPayeeRealName WHERE UserID=@dwUserID
	
	-- ֧����д��
	IF @@ROWCOUNT=0
	BEGIN
		INSERT AliPayBindingInfo(UserID,PayeeAccount,PayeeRealName) VALUES (@dwUserID,@strPayeeAccount,@strPayeeRealName)
	END
	
	-- ֧������ѯ
	SELECT @PayeeAccount=PayeeAccount,@PayeeRealName=PayeeRealName FROM AliPayBindingInfo WHERE UserID=@dwUserID

	-- ���ж�
	IF @PayeeAccount IS NULL OR @PayeeRealName IS NULL
	BEGIN
		SET @BindingStatus=0
	END
	ELSE
	BEGIN
		SET @BindingStatus=1
	END

	-- ���ݵ���
	IF @PayeeAccount IS NULL SET @PayeeAccount=N''
	IF @PayeeRealName IS NULL SET @PayeeRealName=N''

	-- �������
	SELECT @BindingStatus AS BindingStatus,@PayeeAccount AS PayeeAccount,@PayeeRealName AS PayeeRealName
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------