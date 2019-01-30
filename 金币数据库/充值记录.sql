----------------------------------------------------------------------
-- ��Ȩ��2017
-- ʱ�䣺2017-06-09
-- ��;����ֵ��¼
----------------------------------------------------------------------

USE [THTreasureDB]
GO

-- ��ֵ��¼
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_RechargeRecord') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_RechargeRecord
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

---------------------------------------------------------------------------------------
-- ��ֵ��¼
CREATE PROCEDURE NET_PW_RechargeRecord
	@strOrderID			NVARCHAR(50),			--	�������
	@strIPAddress		NVARCHAR(31),			--	�����ַ
	@strErrorDescribe	NVARCHAR(127) OUTPUT	--	�����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ��¼��Ϣ
DECLARE @Accounts NVARCHAR(31)
DECLARE @PayAmount DECIMAL(18,2)
DECLARE @ShareName NVARCHAR(32)
DECLARE @PlatformID INT

-- ִ���߼�
BEGIN

	-- ��¼��ѯ
	DECLARE @ShareID INT
	DECLARE @UserID INT
	SELECT @ShareID=ShareID, @UserID=UserID, @PayAmount=PayAmount FROM ShareDetailInfo WHERE OrderID=@strOrderID
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ��¼�����ڡ�'
		RETURN 1
	END

	-- �û���Ϣ
	SELECT @Accounts=Accounts, @PlatformID=PlatformID FROM THAccountsDBLink.THAccountsDB.dbo.AccountsInfo WHERE UserID=@UserID
	IF @Accounts IS NULL
	BEGIN
		SET @strErrorDescribe=N'�û���Ϣ���������ԣ�'
		RETURN 2
	END

	-- ��ֵƽ̨
	SELECT @ShareName=ShareName FROM GlobalShareInfo WHERE ShareID=@ShareID
	IF @ShareName IS NULL
	BEGIN
		SET @strErrorDescribe=N'��ֵƽ̨��Ϣ���������ԣ�'
		RETURN 3
	END

	-- �������
	SELECT @Accounts AS Accounts, @PayAmount AS PayAmount, @ShareName AS ShareName, @PlatformID AS PlatformID

END

RETURN 0

GO