----------------------------------------------------------------------------------------------------
-- 版权：2017
-- 时间：2017-02-15
-- 用途：隐藏模式
----------------------------------------------------------------------------------------------------

USE THAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_MB_GetHideModel') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_MB_GetHideModel
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 快速注册
CREATE PROCEDURE GSP_MB_GetHideModel
	@dwPlazaVersion INT,						-- 广场版本
	@dwPlatformID INT,							-- 平台编号
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	-- 广场版本
	DECLARE @PlazaVersion AS INT
	SELECT @PlazaVersion=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'V'+CAST(@dwPlatformID AS NVARCHAR(4))
	IF @PlazaVersion IS NULL SET @PlazaVersion=0

	-- 隐藏模式
	DECLARE @HideModel AS INT
	IF @PlazaVersion=@dwPlazaVersion
	BEGIN
		SELECT @HideModel=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=CAST(@dwPlatformID AS NVARCHAR(4))
		IF @@ROWCOUNT=0 SELECT @HideModel=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'HideModel'
	END
	ELSE
	BEGIN
		SELECT @HideModel=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'HideModel'
	END

	IF @HideModel IS NULL SET @HideModel=0

	-- 输出变量
	SELECT @HideModel AS HideModel
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------