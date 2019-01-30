
----------------------------------------------------------------------------------------------------

USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'dbo.GSP_GR_TransferRecord') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE dbo.GSP_GR_TransferRecord
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- ���ػ���
CREATE PROC GSP_GR_TransferRecord
    @dwUserID INT,								-- �û� I D
    @cbAll TINYINT,								-- ȫ����¼
	@stTransferTime DATETIME,					-- ����ʱ��
    @strErrorDescribe NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN

	IF @cbAll=0
	BEGIN
		DECLARE @TransferTime DATETIME
        SET @TransferTime=DATEADD(day,-2,CONVERT(DATETIME,LEFT(GETDATE(),10)+' 00:00:00.000'))
		SELECT TOP 100 a.RecordID as RecordID,b.GameID as SourceUserID,isnull(c.GameID,b.GameID) as TargetUserID,b.NickName as SourceNickName,isnull(c.NickName,b.NickName) as TargetNickName,a.SwapScore as SwapScore,a.CollectDate as CollectDate,a.TradeType as TradeType
		FROM (SELECT RecordID,SourceUserID,TargetUserID,SwapScore,CollectDate,TradeType FROM RecordInsure WHERE CollectDate>=@TransferTime AND (SourceUserID=@dwUserID OR TargetUserID=@dwUserID)) AS a
		LEFT JOIN THAccountsDBLink.THAccountsDB.dbo.AccountsInfo AS b ON a.SourceUserID=b.UserID 
		LEFT JOIN THAccountsDBLink.THAccountsDB.dbo.AccountsInfo AS c ON a.TargetUserID=c.UserID ORDER BY a.CollectDate DESC
	END
    ELSE
    BEGIN
		SELECT TOP 1000 a.RecordID as RecordID,b.GameID as SourceUserID,isnull(c.GameID,b.GameID) as TargetUserID,b.NickName as SourceNickName,isnull(c.NickName,b.NickName) as TargetNickName,a.SwapScore as SwapScore,a.CollectDate as CollectDate,a.TradeType as TradeType
		FROM (SELECT RecordID,SourceUserID,TargetUserID,SwapScore,CollectDate,TradeType FROM RecordInsure WHERE (SourceUserID=@dwUserID OR TargetUserID=@dwUserID)) AS a
		LEFT JOIN THAccountsDBLink.THAccountsDB.dbo.AccountsInfo AS b ON a.SourceUserID=b.UserID 
		LEFT JOIN THAccountsDBLink.THAccountsDB.dbo.AccountsInfo AS c ON a.TargetUserID=c.UserID ORDER BY a.CollectDate DESC
    END

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------