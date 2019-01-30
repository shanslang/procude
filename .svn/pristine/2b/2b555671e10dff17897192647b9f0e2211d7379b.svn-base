
----------------------------------------------------------------------------------------------------

USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_LaBa_Enable]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_LaBa_Enable]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- ÕÊºÅµÇÂ¼
CREATE PROC GSP_GR_LaBa_Enable
	@dwUserID INT,
	@LaBa_tms INT
WITH ENCRYPTION AS

-- ÊôÐÔÉèÖÃ
SET NOCOUNT ON

-- Ö´ÐÐÂß¼­
BEGIN
	DECLARE @LaBa_tms_tmp INT
	SET @LaBa_tms_tmp=0
	SELECT @LaBa_tms_tmp=LaBa_tms FROM THAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID;
	IF @LaBa_tms-@LaBa_tms_tmp>3600
	BEGIN
		UPDATE THAccountsDB.dbo.AccountsInfo SET LaBa_tms=@LaBa_tms WHERE UserID=@dwUserID;
		SELECT 1 AS LaBa_Enable;
	END
	ELSE
	BEGIN
		SELECT 0 AS LaBa_Enable;
	END
END

RETURN 0

GO
