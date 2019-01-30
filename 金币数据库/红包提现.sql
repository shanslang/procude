----------------------------------------------------------------------
-- ��Ȩ��2017
-- ʱ�䣺2017-08-08
-- ��;���������
----------------------------------------------------------------------

USE [THTreasureDB]
GO

-- ���ֶ���
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_WithdrawOrder') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_WithdrawOrder
GO

-- ��������
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_WithdrawRecorded') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_WithdrawRecorded
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

---------------------------------------------------------------------------------------
-- ���ֶ���
CREATE PROCEDURE NET_PW_WithdrawOrder
	@strOrderID	NVARCHAR(32),					-- ������ʶ
	@dwUserID INT,								-- �û� I D
	@strPassword NCHAR(32),						-- �û�����
	@dwAmount INT,								-- ���ֽ��
	@strClientIP NVARCHAR(15)					-- ���ӵ�ַ
--	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE @GoodsCount AS INT
	DECLARE @PayeeAccount AS NVARCHAR(100)
	DECLARE @PayeeRealName AS NVARCHAR(100)
	DECLARE @Amount AS DECIMAL(18, 2)

	-- ��ѯ����
	SELECT @LogonPass=LogonPass FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- �˻��ж�
	IF @LogonPass IS NULL
	BEGIN
		select 1 as ret
	        --SET @strErrorDescribe=N'�����˻���Ϣ�������֤���ٴγ��ԣ�'
		RETURN 1
	END

	-- �����ж�
	IF @LogonPass<>@strPassword
	BEGIN
		select 2 as ret
		--  SET @strErrorDescribe=N'�������������������֤���ٴγ��ԣ�'
		RETURN 2
	END

	-- ��ѯ����
	DECLARE @LockKindID INT
	DECLARE @LockServerID INT
	SELECT @LockKindID=KindID, @LockServerID=ServerID FROM GameScoreLocker WHERE UserID=@dwUserID

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
		--  SET @strErrorDescribe=N'������ [ '+@KindName+N' ] �� [ '+@ServerName+N' ] ��Ϸ�����У����ܽ��е�ǰ������'
	        select 3 as ret
		RETURN 3
	END

	-- ��ѯ֧����
	SELECT @PayeeAccount=PayeeAccount,@PayeeRealName=PayeeRealName FROM THAccountsDB.dbo.AliPayBindingInfo WHERE UserID=@dwUserID

	-- ֧�����ж�
	IF @PayeeAccount IS NULL OR @PayeeRealName IS NULL
	BEGIN
		select 4 as ret
		-- SET @strErrorDescribe=N'������δ��֧�����˺ţ����Ȱ�֧�����˺��ٽ��в�����'
		RETURN 4
	END
	
	-- ��ѯ���
	update THAccountsDB.dbo.AccountsPackage set GoodsCount=GoodsCount-@dwAmount WHERE UserID=@dwUserID AND GoodsID=901
	SELECT @GoodsCount=GoodsCount FROM THAccountsDB.dbo.AccountsPackage WHERE UserID=@dwUserID AND GoodsID=901

	-- �����ж�
	IF @GoodsCount is null or @GoodsCount < 0
	BEGIN
		select 5 as ret
		update THAccountsDB.dbo.AccountsPackage set GoodsCount=GoodsCount+@dwAmount WHERE UserID=@dwUserID AND GoodsID=901
		-- SET @strErrorDescribe=N'�������ֽ����ں����Ŀ�����֤���ٴγ��ԣ�'
		RETURN 5
	END
	
	-- ����ʱ��
	DECLARE @RecordDate AS DATETIME
	SELECT TOP 1 @RecordDate=RecordDate FROM RecordRedPacketTransfer WHERE PayeeAccount=@PayeeAccount AND PayeeRealName=@PayeeRealName ORDER BY RecordDate DESC
	IF @RecordDate IS NOT NULL
	BEGIN
		IF DateDiff(dd,@RecordDate,GetDate())=0
		BEGIN
	                select 6 as ret
			update THAccountsDB.dbo.AccountsPackage set GoodsCount=GoodsCount+@dwAmount WHERE UserID=@dwUserID AND GoodsID=901   
			-- SET @strErrorDescribe=N'�������ִ����Ѵ����ޣ�������������'
			RETURN 6
		END
	END
	
	-- ���ֽ��
	SET @Amount = @dwAmount
	
	-- ���ɶ���
	INSERT RecordAliPayTransfer (OrderID,UserID,PayeeAccount,PayeeRealName,Amount,TransferStatus) 
	VALUES (@strOrderID,@dwUserID,@PayeeAccount,@PayeeRealName,@Amount,0)

	-- �������
	-- SELECT @PayeeAccount AS PayeeAccount,@PayeeRealName AS PayeeRealName,@Amount AS Amount
	SELECT '0' as ret,@PayeeAccount AS PayeeAccount,@PayeeRealName AS PayeeRealName,@Amount AS Amount
	
END

RETURN 0

GO

---------------------------------------------------------------------------------------

-- ��������
CREATE PROCEDURE NET_PW_WithdrawRecorded
	@strOrderID	NVARCHAR(32)					-- ������ʶ
	-- @strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	DECLARE @UserID AS INT
	DECLARE @Amount AS DECIMAL(18, 2)
	DECLARE @TransferStatus AS TINYINT
	
	-- ��ѯ����
	SELECT @UserID=UserID,@Amount=Amount,@TransferStatus=TransferStatus FROM RecordAliPayTransfer WHERE OrderID=@strOrderID
	IF @UserID IS NULL OR @Amount IS NULL OR @TransferStatus IS NULL
	BEGIN
	        select 11 as ret
		-- SET @strErrorDescribe=N'���˶��������ڣ����֤���ٴγ��ԣ�'
		RETURN 11
	END

	-- ״̬�ж�
	IF @TransferStatus=1
	BEGIN
	        select 12 as ret
		-- SET @strErrorDescribe=N'�ñʶ����Ѿ����ˣ������ظ����ˣ�'
		RETURN 12
	END

	-- ���¶���
	UPDATE RecordAliPayTransfer SET TransferStatus=1,SuccessDate=GETDATE() WHERE OrderID=@strOrderID

	-- ���±���
	--UPDATE THAccountsDBLink.THAccountsDB.dbo.AccountsPackage SET GoodsCount=GoodsCount-CAST(@Amount AS INT) WHERE UserID=@UserID AND GoodsID=901

	-- ������¼
	DECLARE @RecordNote AS NVARCHAR(32)
	SET @RecordNote = N'�������'
	INSERT THAccountsDBLink.THAccountsDB.dbo.PackageRecord(UserID,RecordType,GoodsID,GoodsCount,RecordNote) VALUES (@UserID,1,901,CAST(@Amount AS INT),@RecordNote)

	-- ���ּ�¼
	INSERT RecordRedPacketTransfer(OrderID,UserID,PayeeAccount,PayeeRealName,Amount) 
	SELECT OrderID,UserID,PayeeAccount,PayeeRealName,Amount FROM RecordAliPayTransfer WHERE OrderID=@strOrderID

	-- ɾ����Ʒ
	DELETE FROM THAccountsDBLink.THAccountsDB.dbo.AccountsPackage WHERE UserID=@UserID AND GoodsCount=0

        -- �������
	SELECT '0' as ret
END

RETURN 0

GO

---------------------------------------------------------------------------------------