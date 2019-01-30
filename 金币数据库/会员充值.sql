----------------------------------------------------------------------
-- ��Ȩ��2017
-- ʱ�䣺2017-10-18
-- ��;����Ա��ֵ
----------------------------------------------------------------------

USE [THTreasureDB]
GO

-- ��Ա��ֵ
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_MemberRecharge') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_MemberRecharge
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

---------------------------------------------------------------------------------------
-- ��Ա��ֵ
CREATE PROCEDURE NET_PW_MemberRecharge
	@strOrdersID		NVARCHAR(50),			--	�������
	@PayAmount			DECIMAL(18,2),			--  ֧�����
	@strIPAddress		NVARCHAR(31),			--	���ӵ�ַ
	@strErrorDescribe	NVARCHAR(127) OUTPUT	--	�����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ������Ϣ
DECLARE @OperUserID INT
DECLARE @ShareID INT
DECLARE @UserID INT
DECLARE @GameID INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @OrderAmount DECIMAL(18,2)
DECLARE @DiscountScale DECIMAL(18,2)
DECLARE @IPAddress NVARCHAR(15)
DECLARE @CurrencyType TINYINT
DECLARE @Currency DECIMAL(18,2)
DECLARE @OrderID NVARCHAR(50)

-- �û���Ϣ
DECLARE @Score BIGINT

-- ִ���߼�
BEGIN
	-- ������ѯ
	SELECT @OperUserID=OperUserID,@ShareID=ShareID,@UserID=UserID,@GameID=GameID,@Accounts=Accounts,
		@OrderID=OrderID,@OrderAmount=OrderAmount,@DiscountScale=DiscountScale,@CurrencyType=CurrencyType
	FROM OnLineOrder WHERE OrderID=@strOrdersID

	-- ��������
	IF @OrderID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ���������ڡ�'
		RETURN 1
	END

	-- �����ظ�
	IF EXISTS(SELECT OrderID FROM ShareDetailInfo(NOLOCK) WHERE OrderID=@strOrdersID) 
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ�����ظ���'
		RETURN 2
	END

	-- ���Ҳ�ѯ
	DECLARE @BeforeCurrency DECIMAL(18,2)
	SELECT @BeforeCurrency=Currency FROM UserCurrencyInfo WHERE UserID=@UserID
	IF @BeforeCurrency IS NULL SET @BeforeCurrency=0

	--------------------------------------------------------------------------------
	-- ��ֵ����
	SET @Currency=0

	--------------------------------------------------------------------------------
	-- ��Ա�ȼ�
	DECLARE @MemberOrder TINYINT
	SELECT @MemberOrder=MemberOrder FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@UserID
	IF @MemberOrder IS NULL SET @MemberOrder=0

	--------------------------------------------------------------------------------
	-- ��ֵ����
	DECLARE @RechargeScore BIGINT
	SELECT @RechargeScore=Score FROM GlobalRechargeMemberConfig WHERE Price=@PayAmount AND Nullity=0
	IF @RechargeScore IS NULL SET @RechargeScore=0

	-- �жϻ�Ա
	IF @MemberOrder<>10 SET @RechargeScore=0

	-- ���·���
	UPDATE GameScoreInfo SET Score=Score+@RechargeScore WHERE UserID=@UserID
	IF @@ROWCOUNT=0
	BEGIN
		INSERT INTO GameScoreInfo(UserID,Score,RegisterIP,LastLogonIP) VALUES (@UserID,@RechargeScore,@strIPAddress,@strIPAddress)
	END

	--------------------------------------------------------------------------------

	-- ������¼
	INSERT INTO ShareDetailInfo(
		OperUserID,ShareID,UserID,GameID,Accounts,OrderID,OrderAmount,DiscountScale,PayAmount,
		CurrencyType,Currency,BeforeCurrency,IPAddress)
	VALUES(
		@OperUserID,@ShareID,@UserID,@GameID,@Accounts,@OrderID,@OrderAmount,@DiscountScale,@PayAmount,
		@CurrencyType,@Currency,@BeforeCurrency,@strIPAddress)

	-- ������¼
	IF @ShareID=13 OR @ShareID=14 OR @ShareID=19
	BEGIN
		-- ƽ̨���
		DECLARE @PlatformID INT
		SELECT @PlatformID=PlatformID FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@UserID

		-- �ٷ�ƽ̨
		IF @PlatformID=1002 OR @PlatformID=2001
		BEGIN
			-- ��������
			DECLARE @ChannelID INT
			SELECT @ChannelID=ChannelID FROM THAccountsDBLink.THAccountsDB.dbo.AccountsChannel WHERE UserID=@UserID
			IF @ChannelID IS NOT NULL
			BEGIN
				-- ��ѯ����
				DECLARE @OutPercent DECIMAL(18,2)
				DECLARE @Nullity TINYINT
				SELECT @OutPercent=OutPercent,@Nullity=Nullity FROM THAccountsDBLink.THAccountsDB.dbo.ChannelConfig WHERE ChannelID=@ChannelID
				IF @OutPercent IS NOT NULL AND @Nullity IS NOT NULL
				BEGIN
					-- д���¼
					INSERT RecordChannelRecharge (PlatformID,ChannelID,UserID,ShareID,OrderID,PayAmount,OutPercent,OutAmount,Nullity)
					VALUES (@PlatformID,@ChannelID,@UserID,@ShareID,@OrderID,@PayAmount,@OutPercent,@OutPercent*@PayAmount/100,@Nullity)
				END
			END
		END
	END

	-- ���¶���״̬
	UPDATE OnLineOrder SET OrderStatus=2,Currency=@Currency,PayAmount=@PayAmount WHERE OrderID=@OrderID
END

RETURN 0

GO

---------------------------------------------------------------------------------------