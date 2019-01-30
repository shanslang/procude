----------------------------------------------------------------------
-- ��Ȩ��2011
-- ʱ�䣺2011-09-1
-- ��;�����߶���
----------------------------------------------------------------------

USE [THTreasureDB]
GO

-- ���붩��
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_ApplyOnLineOrder') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_ApplyOnLineOrder
GO

-- ��Ǯ֧����¼
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_AddReturnKQInfo') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_AddReturnKQInfo
GO

-- �绰֧����¼
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_AddReturnVBInfo') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_AddReturnVBInfo

-- �ױ�֧����¼
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_AddReturnYBInfo') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_AddReturnYBInfo
GO

-- ֧�������ؼ�¼
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_AddReturnZFBInfo') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_AddReturnZFBInfo
GO

-- ΢�ŷ��ؼ�¼
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_AddReturnWXInfo') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_AddReturnWXInfo
GO

-- ƻ�����ؼ�¼
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_AddReturnAppDetailInfo') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_AddReturnAppDetailInfo
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------------
-- ���붩��
CREATE PROCEDURE NET_PW_ApplyOnLineOrder
	@strOrderID			NVARCHAR(32),				-- ������ʶ
	@dwOperUserID		INT,						-- �����û�

	@dwShareID			INT,						-- ��������
	@strAccounts		NVARCHAR(31),				-- ��ֵ�û�
	@dcOrderAmount		DECIMAL(18,2),				-- �������
	@cbCurrencyType		TINYINT,					-- ��������
	
	@strIPAddress		NVARCHAR(15),				-- ֧����ַ
	@strProductID		NVARCHAR(100),				-- ��Ʒ��ʶ
	@strErrorDescribe	NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �ʺ�����
DECLARE @Accounts NVARCHAR(31)
DECLARE @GameID INT
DECLARE @UserID INT
DECLARE @Nullity TINYINT
DECLARE @StunDown TINYINT

-- ������Ϣ
DECLARE @OrderID NVARCHAR(32)
DECLARE @OrderAmount DECIMAL(18,2)
DECLARE @PayAmount DECIMAL(18,2)
DECLARE @Currency DECIMAL(18,2)
DECLARE @Rate INT

-- ִ���߼�
BEGIN
	-- ��֤�û�
	SELECT @UserID=UserID,@GameID=GameID,@Accounts=Accounts,@Nullity=Nullity,@StunDown=StunDown
	FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo
	WHERE Accounts=@strAccounts

	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����Ҫ��ֵ���û��˺Ų����ڡ�'
		RETURN 1
	END

	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����Ҫ��ֵ���û��˺���ʱ���ڶ���״̬������ϵ�ͻ����������˽���ϸ�����'
		RETURN 2
	END

	IF @StunDown<>0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����Ҫ��ֵ���û��˺�ʹ���˰�ȫ�رչ��ܣ��������¿�ͨ����ܼ���ʹ�á�'
		RETURN 3
	END

	-- ������ѯ
	SELECT @OrderID=OrderID FROM OnLineOrder WHERE OrderID=@strOrderID
	IF @OrderID IS NOT NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ���ö����Ѵ���,�����³�ֵ��'
		RETURN 4
	END

	-- ��������
	IF EXISTS (SELECT UserID FROM GameScoreLocker(NOLOCK) WHERE UserID=@UserID)
	BEGIN
		SET @strErrorDescribe='��Ǹ�����Ѿ��ڽ����Ϸ�����ˣ����ܽ��г�ֵ�����������˳������Ϸ���䣡'	
		RETURN 5
	END	
	
	-- ��ֵ����
	SELECT @Rate=StatusValue FROM THAccountsDBLink.THAccountsDB.dbo.SystemStatusInfo 
	WHERE StatusString='RateCurrency'
	IF @Rate IS NULL
		SET @Rate=1

	-- �������
	SET @OrderAmount=@dcOrderAmount
	SET @PayAmount=@dcOrderAmount
	SET @Currency=@PayAmount*@Rate

	-- ��������
	INSERT INTO OnLineOrder(
		OperUserID,ShareID,UserID,GameID,Accounts,OrderID,OrderAmount,PayAmount,Rate,CurrencyType,Currency,IPAddress,ProductID)
	VALUES(
		@dwOperUserID,@dwShareID,@UserID,@GameID,@Accounts,@strOrderID,@OrderAmount,@PayAmount,@Rate,@cbCurrencyType,@Currency,@strIPAddress,@strProductID)

	SELECT @dwOperUserID AS OperUserID,@dwShareID AS ShareID,@UserID AS UserID,@GameID AS GameID,@Accounts AS Accounts,
		   @strOrderID AS OrderID, @OrderAmount AS OrderAmount,@PayAmount AS PayAmount,@Rate AS Rate,@Currency AS Currency,@strIPAddress AS IPAddress	   
	
END

RETURN 0

GO

----------------------------------------------------------------------------------
-- ��Ǯ֧����¼
CREATE PROCEDURE NET_PW_AddReturnKQInfo      
        @strMerchantAcctID	NVARCHAR(64),				-- �տ�������ʺ�
        @strVersion			NVARCHAR(20),				-- ��Ǯ�汾
        @dwLanguage			INT,						-- ����ҳ���������
        @dwSignType			INT,						-- ǩ�����
        @strPayType	 		NCHAR(10),					-- ֧����ʽ
        @strBankID	 		NCHAR(20),					-- ���д���

        @strOrderID	 		NVARCHAR(60),				-- ����ID
        @dtOrderTime		DATETIME,					-- ��������
        @fOrderAmount		DECIMAL(18,2),				-- �������(Ԫ)

        @strDealID			NVARCHAR(60),				-- ��Ǯ���׺�
        @strBankDealID		NVARCHAR(60),				-- ���н��׺�
        @dtDealTime			DATETIME,					-- ��Ǯ����ʱ��
        
		@fPayAmount			DECIMAL(18,2),				-- ����ʵ��֧����Ԫ��		
		@fFee				DECIMAL(18,3),				-- ��Ǯ��ȡ�̻��������ѣ�Ԫ��

        @strPayResult		NVARCHAR(20),				-- ������  10��֧���ɹ� 11��֧��ʧ��
        @strErrCode			NVARCHAR(40),				-- �������
        @strSignMsg			NVARCHAR(64),				-- ǩ���ַ���

        @strExt1			NVARCHAR(256),				-- ��չ�ֶ�1
        @strExt2			NVARCHAR(256),				-- ��չ�ֶ�2	
		
		@CardNumber			NVARCHAR(30) = '',				-- ֧������
		@CardPwd			NVARCHAR(30) = '',				-- ֧������
		@BossType			NVARCHAR(2) = '',				-- ֧������(ֻ�ʺϳ�ֵ��)
		@ReceiveBossType	NVARCHAR(2) = '',				-- ʵ��֧������
		@ReceiverAcctId		NVARCHAR(32) = ''				-- ʵ���տ��˻�

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN	
	
	UPDATE ReturnKQDetailInfo
	SET MerchantAcctID=@strMerchantAcctID,Version=@strVersion,[Language]=@dwLanguage,SignType=@dwSignType,PayType=@strPayType,
		OrderTime=@dtOrderTime,OrderAmount=@fOrderAmount,DealID=@strDealID, BankDealID=@strBankDealID,DealTime=@dtDealTime,
		PayAmount=@fOrderAmount,Fee=@fFee,PayResult=@strPayResult, ErrCode=@strErrCode,SignMsg=@strSignMsg,Ext1=@strExt1, Ext2=@strExt2,
		CardNumber=@CardNumber,CardPwd=@CardPwd,BossType=@BossType,ReceiveBossType=@ReceiveBossType,ReceiverAcctId=@ReceiverAcctId
	WHERE OrderID=@strOrderID

	IF @@ROWCOUNT=0
	BEGIN
		INSERT ReturnKQDetailInfo
		(        
			MerchantAcctID,Version,[Language],SignType, PayType, BankID,
			OrderID,OrderTime,OrderAmount,DealID, BankDealID,DealTime,
			PayAmount,Fee,PayResult, ErrCode,SignMsg,Ext1, Ext2,
			CardNumber,CardPwd,BossType,ReceiveBossType,ReceiverAcctId
		)
		VALUES 
		(	
			@strMerchantAcctID,@strVersion,@dwLanguage,@dwSignType,@strPayType,@strBankID,
			@strOrderID,@dtOrderTime,@fOrderAmount,@strDealID,@strBankDealID,@dtDealTime,
			@fPayAmount,@fFee,@strPayResult,@strErrCode,@strSignMsg,@strExt1,@strExt2,
			@CardNumber,@CardPwd,@BossType,@ReceiveBossType,@ReceiverAcctId
		)
	END
END
RETURN 0
GO

----------------------------------------------------------------------------------
-- �绰��ֵ��¼
CREATE PROCEDURE NET_PW_AddReturnVBInfo 
	@Rtmd5			NVARCHAR(32),			--	V�ҷ�����MD5
	@Rtka			NVARCHAR(15),			--	V�Һ���
	@Rtmi			NVARCHAR(6),			--	V������
	@Rtmz			INT,					--	��ֵ
	@Rtlx			INT,					--	��������(1:��ʽ�� 2:���Կ� 3 :������)
	@Rtoid			NVARCHAR(10),			--	ӯ��Ѷ���������˶���
	@OrderID			NVARCHAR(32),			--	��������
	@Rtuserid		NVARCHAR(31),			--	�̻����û�ID
	@Rtcustom		NVARCHAR(128),			--	�̻��Լ���������
	@Rtflag			INT,					--	����״̬(1:Ϊ�������ͻ���,2:Ϊ�������ͻ���)
	@EcryptStr		NVARCHAR(1024),			--	�ش��ַ�
	@SignMsg			NVARCHAR(32),			--	ǩ���ַ���
	@strErrorDescribe	NVARCHAR(127)	OUTPUT	-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ��Ա������
DECLARE @CardTypeID INT

-- ִ���߼�
BEGIN	
	
	UPDATE ReturnVBDetailInfo SET
		Rtmd5=@Rtmd5, Rtka=@Rtka, Rtmi=@Rtmi, Rtmz=@Rtmz, Rtlx=@Rtlx, Rtoid=@Rtoid
		, OrderID=@OrderID, Rtuserid=@Rtuserid, Rtcustom=@Rtcustom, Rtflag=@Rtflag, EcryptStr=@EcryptStr, SignMsg=@SignMsg
	WHERE OrderID=@OrderID

	IF @@ROWCOUNT=0
	BEGIN
		INSERT INTO ReturnVBDetailInfo(
			Rtmd5, Rtka, Rtmi, Rtmz, Rtlx, Rtoid
			, OrderID, Rtuserid, Rtcustom, Rtflag, EcryptStr, SignMsg)
		VALUES(@Rtmd5, @Rtka, @Rtmi, @Rtmz, @Rtlx, @Rtoid
			, @OrderID, @Rtuserid, @Rtcustom, @Rtflag, @EcryptStr, @SignMsg)
	END
END
RETURN 0
GO

----------------------------------------------------------------------------------
-- �ױ����ؼ�¼
CREATE PROCEDURE NET_PW_AddReturnYBInfo
	@p1_MerId	NVARCHAR(22),			-- �̻����
	@r0_Cmd		NVARCHAR(40),			-- ҵ������
	@r1_Code	NVARCHAR(2),			-- ֧�����
	@r2_TrxId	NVARCHAR(100),			-- �ױ�֧��������ˮ��
	@r3_Amt		DECIMAL(18,2),			-- ֧�����
	@r4_Cur		NVARCHAR(20),			-- ���ױ���
	@r5_Pid		NVARCHAR(40),			-- ��Ʒ����
	@r6_Order	NVARCHAR(64),			-- �̻�������
	@r7_Uid		NVARCHAR(100),			-- �ױ�֧����ԱID
	@r8_MP		NVARCHAR(400),			-- �̻���չ��Ϣ
	@r9_BType	NCHAR(2),				-- ���׽����������
	@rb_BankId	NVARCHAR(64),			-- ֧��ͨ������
	@ro_BankOrderId	NVARCHAR(128),		-- ���ж�����
	@rp_PayDate	NVARCHAR(64),			-- ֧���ɹ�ʱ��
	@rq_CardNo	NVARCHAR(128),			-- �����г�ֵ�����к�
	@ru_Trxtime	NVARCHAR(64),			-- ���׽��֪ͨʱ��
	@hmac		NCHAR(64)				-- ǩ������
WITH ENCRYPTION AS

-- ִ���߼�
BEGIN	
	IF NOT EXISTS(SELECT * FROM ReturnYPDetailInfo WHERE r6_Order=@r6_Order)
	BEGIN
		INSERT INTO ReturnYPDetailInfo(
			p1_MerId,r0_Cmd,r1_Code,r2_TrxId,r3_Amt,r4_Cur,r5_Pid,r6_Order,r7_Uid,r8_MP,r9_BType,
			rb_BankId,ro_BankOrderId,rp_PayDate,rq_CardNo,ru_Trxtime,hmac)
		VALUES(@p1_MerId,@r0_Cmd,@r1_Code,@r2_TrxId,@r3_Amt,@r4_Cur,@r5_Pid,@r6_Order,@r7_Uid,@r8_MP,@r9_BType,
			@rb_BankId,@ro_BankOrderId,@rp_PayDate,@rq_CardNo,@ru_Trxtime,@hmac)
	END
	ELSE
	BEGIN
		UPDATE ReturnYPDetailInfo SET
			p1_MerId=@p1_MerId,r0_Cmd=@r0_Cmd,r1_Code=@r1_Code,r2_TrxId=@r2_TrxId,r3_Amt=@r3_Amt,r4_Cur=@r4_Cur,
			r5_Pid=@r5_Pid,r7_Uid=@r7_Uid,r8_MP=@r8_MP,r9_BType=@r9_BType,rb_BankId=@rb_BankId,ro_BankOrderId=@ro_BankOrderId,
			rp_PayDate=@rp_PayDate,rq_CardNo=@rq_CardNo,ru_Trxtime=@ru_Trxtime,hmac=@hmac
		WHERE r6_Order=@r6_Order
	END
END
RETURN 0
GO

----------------------------------------------------------------------------------
-- ֧�������ؼ�¼
CREATE PROCEDURE NET_PW_AddReturnZFBInfo
	@out_trade_no	NVARCHAR(64),		-- �̻�������
	@subject		NVARCHAR(128),		-- ��Ʒ����
	@payment_type	NVARCHAR(4),		-- ֧������
	@trade_no		NVARCHAR(64),		-- ֧�������׺�
	@trade_status	NVARCHAR(14),		-- ����״̬
	@seller_id		NVARCHAR(30),		-- ����֧�����û���
	@seller_email	NVARCHAR(100),		-- ����֧�����˺�
	@buyer_id		NVARCHAR(30),		-- ���֧�����û���
	@buyer_email	NVARCHAR(100),		-- ���֧�����˺�
	@total_fee		DECIMAL(18,2),		-- ���׽��
	@quantity		INT,				-- ��������
	@price			DECIMAL(18,2),		-- ��Ʒ����
	@body			NVARCHAR(512),		-- ��Ʒ����
	@gmt_create		DATETIME,			-- ���״���ʱ��
	@gmt_payment	DATETIME			-- ���׸���ʱ��
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN

	IF NOT EXISTS(SELECT * FROM ReturnYPDetailInfo WHERE @out_trade_no=@out_trade_no)
	BEGIN
		INSERT INTO ReturnZFBDetailInfo
		(
			out_trade_no, subject, payment_type, trade_no, 
			trade_status, seller_id, seller_email, buyer_id, buyer_email, total_fee, 
			quantity, price, body, gmt_create, gmt_payment
		)
		VALUES
		(
			@out_trade_no, @subject, @payment_type, @trade_no, 
			@trade_status, @seller_id, @seller_email, @buyer_id, @buyer_email, @total_fee, 
			@quantity, @price, @body, @gmt_create, @gmt_payment
		)
	END

END

RETURN 0

GO
----------------------------------------------------------------------------------
-- ΢�ŷ��ؼ�¼
CREATE PROCEDURE NET_PW_AddReturnWXInfo
	@out_trade_no	NVARCHAR(32),		-- �̻�������
	@appid			NVARCHAR(32),		-- ��Ʒ����
	@mch_id			NVARCHAR(32),		-- ֧������
	@nonce_str		NVARCHAR(32),		-- ֧�������׺�
	@sign			NVARCHAR(32),		-- ����״̬
	@result_code	NVARCHAR(16),		-- ����֧�����û���
	@openid			NVARCHAR(128),		-- ����֧�����˺�
	@trade_type		NVARCHAR(16),		-- ���֧�����û���
	@bank_type		NVARCHAR(16),		-- ���֧�����˺�
	@total_fee		DECIMAL(18,2),		-- ���׽��
	@fee_type		NVARCHAR(8),		-- ��������
	@cash_fee		DECIMAL(18,2),		-- ��Ʒ����
	@cash_fee_type	NVARCHAR(16),		-- ��Ʒ����
	@transaction_id	NVARCHAR(32),		-- ���״���ʱ��
	@time_end		NVARCHAR(32)		-- ���׸���ʱ��
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN

	IF NOT EXISTS(SELECT * FROM ReturnYPDetailInfo WHERE @out_trade_no=@out_trade_no)
	BEGIN
		INSERT INTO ReturnWXDetailInfo
		( out_trade_no, appid, mch_id, nonce_str, [sign], result_code, 
			openid, trade_type, bank_type, total_fee, fee_type, 
			cash_fee, cash_fee_type, transaction_id, time_end
		)
		VALUES
		(
			@out_trade_no, @appid, @mch_id, @nonce_str, @sign, @result_code, 
			@openid, @trade_type, @bank_type, @total_fee, @fee_type, 
			@cash_fee, @cash_fee_type, @transaction_id, @time_end
		)
	END

END

RETURN 0

GO
----------------------------------------------------------------------------------
-- ƻ�����ؼ�¼
CREATE PROCEDURE NET_PW_AddReturnAppDetailInfo
	@UserID			INT,
	@OrderID		NVARCHAR(32),
	@PayAmount		DECIMAL(18,2),
	@Status			INT,
	@quantity		INT,
	@product_id	    NVARCHAR(50),
	@transaction_id	NVARCHAR(50),
	@purchase_date	NVARCHAR(50),
	@original_transaction_id NVARCHAR(50),
	@original_purchase_date	 NVARCHAR(50),
	@app_item_id	NVARCHAR(50),
	@version_external_identifier NVARCHAR(50),
	@bid			NVARCHAR(50),
	@bvrs			NVARCHAR(50)
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN

	IF NOT EXISTS(SELECT * FROM ReturnAppDetailInfo WHERE @OrderID=@OrderID)
	BEGIN
		INSERT INTO ReturnAppDetailInfo
		(  UserID, OrderID, PayAmount, Status, quantity, product_id, transaction_id, purchase_date,
 original_transaction_id, original_purchase_date, app_item_id, version_external_identifier, bid, bvrs
		)
		VALUES
		(
			@UserID, @OrderID, @PayAmount, @Status, @quantity, @product_id, @transaction_id, @purchase_date,
 @original_transaction_id,@original_purchase_date,@app_item_id,@version_external_identifier, @bid,@bvrs
		)
	END

END

RETURN 0

GO
----------------------------------------------------------------------------------