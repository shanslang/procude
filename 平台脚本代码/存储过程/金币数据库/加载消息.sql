
----------------------------------------------------------------------------------------------------

USE THTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'dbo.GSP_GR_LoadSystemMessage') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE dbo.GSP_GR_LoadSystemMessage
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- ���ػ���
CREATE PROC GSP_GR_LoadSystemMessage
	@wServerID SMALLINT							-- ���� I D
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN

	-- ��ѯ����
	SELECT * FROM THPlatformDBLink.THPlatformDB.dbo.SystemMessage
	WHERE (StartTime <= GETDATE()) AND (ConcludeTime > GETDATE()) AND (StartTime<ConcludeTime) AND Nullity=0 ORDER BY ID

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------