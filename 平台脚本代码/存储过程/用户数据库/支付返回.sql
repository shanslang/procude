
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_QueryPayResult]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_QueryPayResult]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- I D ��¼
CREATE PROC GSP_GP_QueryPayResult
	@dwUserID INT,								-- dwUserID
	@DetailID int,								-- ��ˮID
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN

	-- �������
	DECLARE @isCharge tinyint
	DECLARE @PayAmount INT
	DECLARE @CurrencyType INT
	declare @FirstChargeMask bigint
	select @FirstChargeMask=[FirstChargeMask] from [THAccountsDB].[dbo].[AccountsInfo] where userid = @dwUserID
	SET @isCharge=0
	SET @CurrencyType=0
--	SELECT @dwUserID AS UserID, 0 AS isCharge, 8 AS shopAMount, 3 AS shopType
	SELECT @isCharge=1, @PayAmount=PayAmount, @CurrencyType=CurrencyType FROM THTreasureDB.dbo.ShareDetailInfo WHERE DetailID = @DetailID and UserID=@dwUserID
	if @PayAmount is null
	begin
		set @PayAmount = 0
		SELECT @dwUserID AS UserID, @isCharge AS Charge, @PayAmount AS shopAMount, @CurrencyType AS shopType,@FirstChargeMask as FirstChargeMask
		return 0
	end
	
	UPDATE THTreasureDB.dbo.ShareDetailInfo SET Notice=1 WHERE DetailID = @DetailID
	update [THControlDB].[dbo].[UserCtlInfos] set [Payed]=1 where [UserID]=@dwUserID
	SELECT @dwUserID AS UserID, @isCharge AS Charge, @PayAmount AS shopAMount, @CurrencyType AS shopType,@FirstChargeMask as FirstChargeMask
-- 	SELECT PayAmount FROM THTreasureDB.dbo.ShareDetailInfo WHERE UserID=@dwUserID AND CurrencyType=@currencyType
RETURN 0


END


GO

----------------------------------------------------------------------------------------------------
