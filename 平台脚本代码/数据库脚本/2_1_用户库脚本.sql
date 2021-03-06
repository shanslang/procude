USE [THAccountsDB]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemStatusInfo](
	[StatusName] [nvarchar](32) NOT NULL,
	[StatusValue] [int] NOT NULL CONSTRAINT [DF_SystemStatusInfo_StatusValue]  DEFAULT ((0)),
	[StatusString] [nvarchar](512) NOT NULL CONSTRAINT [DF_SystemStatusInfo_StatusString]  DEFAULT (''),
	[StatusTip] [nvarchar](50) NOT NULL CONSTRAINT [DF_SystemStatusInfo_StatusTip]  DEFAULT (''),
	[StatusDescription] [nvarchar](100) NOT NULL CONSTRAINT [DF_SystemStatusInfo_StatusDescription]  DEFAULT (''),
	[SortID] [int] NOT NULL CONSTRAINT [DF_SystemStatusInfo_SortID]  DEFAULT ((0)),
 CONSTRAINT [PK_SystemStatusInfo] PRIMARY KEY CLUSTERED 
(
	[StatusName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStatusInfo', @level2type=N'COLUMN',@level2name=N'StatusName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态数值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStatusInfo', @level2type=N'COLUMN',@level2name=N'StatusValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态字符' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStatusInfo', @level2type=N'COLUMN',@level2name=N'StatusString'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态显示名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStatusInfo', @level2type=N'COLUMN',@level2name=N'StatusTip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字符的描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStatusInfo', @level2type=N'COLUMN',@level2name=N'StatusDescription'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameIdentifier](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[GameID] [int] NOT NULL,
	[IDLevel] [int] NOT NULL CONSTRAINT [DF_GameIdentifiers_IDLevel]  DEFAULT ((0)),
 CONSTRAINT [PK_GameIdentifier_UserID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameIdentifier', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameIdentifier', @level2type=N'COLUMN',@level2name=N'GameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标识等级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameIdentifier', @level2type=N'COLUMN',@level2name=N'IDLevel'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndividualDatum](
	[UserID] [int] NOT NULL,
	[QQ] [nvarchar](16) NOT NULL,
	[EMail] [nvarchar](32) NOT NULL,
	[SeatPhone] [nvarchar](32) NOT NULL CONSTRAINT [DF_IndividualDatum_SeatPhone]  DEFAULT (''),
	[MobilePhone] [nvarchar](16) NOT NULL CONSTRAINT [DF_IndividualDatum_MobilePhone]  DEFAULT (''),
	[DwellingPlace] [nvarchar](128) NOT NULL CONSTRAINT [DF_IndividualDatum_DwellingPlace]  DEFAULT (''),
	[PostalCode] [nvarchar](8) NOT NULL CONSTRAINT [DF_IndividualDatum_PostalCode]  DEFAULT (''),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_IndividualDatum_CollectDate]  DEFAULT (getdate()),
	[UserNote] [nvarchar](256) NOT NULL CONSTRAINT [DF_IndividualDatum_UserNote]  DEFAULT (''),
 CONSTRAINT [PK_IndividualDatum_UserID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IndividualDatum', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'QQ 号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IndividualDatum', @level2type=N'COLUMN',@level2name=N'QQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IndividualDatum', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'固定电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IndividualDatum', @level2type=N'COLUMN',@level2name=N'SeatPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IndividualDatum', @level2type=N'COLUMN',@level2name=N'MobilePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'详细住址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IndividualDatum', @level2type=N'COLUMN',@level2name=N'DwellingPlace'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮政编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IndividualDatum', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收集日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IndividualDatum', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IndividualDatum', @level2type=N'COLUMN',@level2name=N'UserNote'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountsTask](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[TaskID] [int] NOT NULL CONSTRAINT [DF_AccountsTask_TaskID]  DEFAULT ((0)),
	[KindID] [int] NOT NULL CONSTRAINT [DF_AccountsTask_KingID]  DEFAULT ((0)),
	[TaskType] [int] NOT NULL CONSTRAINT [DF_AccountsTask_TaskType]  DEFAULT ((0)),
	[TaskObject] [int] NOT NULL CONSTRAINT [DF_AccountsTask_TaskObject]  DEFAULT ((0)),
	[Progress] [int] NOT NULL CONSTRAINT [DF_AccountsTask_Progress]  DEFAULT ((0)),
	[TimeLimit] [int] NOT NULL CONSTRAINT [DF_AccountsTask_TimeLimit]  DEFAULT ((0)),
	[TaskStatus] [tinyint] NOT NULL CONSTRAINT [DF_AccountsTask_TaskStatus_1]  DEFAULT ((0)),
	[InputDate] [datetime] NOT NULL CONSTRAINT [DF_AccountsTask_InputDate_1]  DEFAULT (getdate()),
	[MachineSerial] [nvarchar](32) NOT NULL CONSTRAINT [DF_AccountsTask_MachineSerial]  DEFAULT (N''),
 CONSTRAINT [PK_AccountsTask_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsTask', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsTask', @level2type=N'COLUMN',@level2name=N'TaskID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务进度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsTask', @level2type=N'COLUMN',@level2name=N'Progress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务状态 (0 为未完成  1为成功   2为失败  3未已领奖)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsTask', @level2type=N'COLUMN',@level2name=N'TaskStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机器序列' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsTask', @level2type=N'COLUMN',@level2name=N'MachineSerial'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountsInfo](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[GameID] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_GameID]  DEFAULT ((0)),
	[ProtectID] [int] NOT NULL CONSTRAINT [DF_UserAccounts_ProtectID]  DEFAULT ((0)),
	[PasswordID] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_PasswordID]  DEFAULT ((0)),
	[SpreaderID] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_SpreaderID]  DEFAULT ((0)),
	[Accounts] [nvarchar](31) NOT NULL,
	[NickName] [nvarchar](31) NOT NULL CONSTRAINT [DF_AccountsInfo_Nickname]  DEFAULT (''),
	[RegAccounts] [nvarchar](31) NOT NULL,
	[UnderWrite] [nvarchar](250) NOT NULL CONSTRAINT [DF_UserAccounts_UnderWrite]  DEFAULT (''),
	[PassPortID] [nvarchar](18) NOT NULL CONSTRAINT [DF_AccountsInfo_PassPortID]  DEFAULT (N''),
	[Compellation] [nvarchar](16) NOT NULL CONSTRAINT [DF_AccountsInfo_Compellation]  DEFAULT (N''),
	[LogonPass] [nchar](32) NOT NULL,
	[InsurePass] [nchar](32) NOT NULL CONSTRAINT [DF_AccountsInfo_InsurePass]  DEFAULT (N''),
	[DynamicPass] [nchar](32) NOT NULL CONSTRAINT [DF_AccountsInfo_DynamicPass]  DEFAULT (''),
	[DynamicPassTime] [datetime] NOT NULL CONSTRAINT [DF_AccountsInfo_DynamicPassTime]  DEFAULT (getdate()),
	[FaceID] [smallint] NOT NULL CONSTRAINT [DF_UserAccounts_FaceID]  DEFAULT ((0)),
	[CustomID] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_CustomFaceID]  DEFAULT ((0)),
	[Present] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_Present]  DEFAULT ((0)),
	[UserMedal] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_LoveLiness1]  DEFAULT ((0)),
	[Experience] [int] NOT NULL CONSTRAINT [DF_UserAccounts_Experience]  DEFAULT ((0)),
	[GrowLevelID] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_GrowLevelID]  DEFAULT ((1)),
	[LoveLiness] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_LoveLiness]  DEFAULT ((0)),
	[UserRight] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_UserRight]  DEFAULT ((0)),
	[MasterRight] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_MasterRight]  DEFAULT ((0)),
	[ServiceRight] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_ServiceRight]  DEFAULT ((0)),
	[MasterOrder] [tinyint] NOT NULL CONSTRAINT [DF_AccountsInfo_MasterOrder]  DEFAULT ((0)),
	[MemberOrder] [tinyint] NOT NULL CONSTRAINT [DF_UserAccounts_MemberOrder]  DEFAULT ((0)),
	[MemberOverDate] [datetime] NOT NULL CONSTRAINT [DF_UserAccounts_MemberOverDate]  DEFAULT (((1980)-(1))-(1)),
	[MemberSwitchDate] [datetime] NOT NULL CONSTRAINT [DF_AccountsInfo_MemberSwitchDate]  DEFAULT (((1980)-(1))-(1)),
	[CustomFaceVer] [tinyint] NOT NULL CONSTRAINT [DF_AccountsInfo_CustomFaceVer]  DEFAULT ((0)),
	[Gender] [tinyint] NOT NULL CONSTRAINT [DF_AccountsInfo_Gender]  DEFAULT ((0)),
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_UserAccounts_ServiceNullity]  DEFAULT ((0)),
	[NullityOverDate] [datetime] NOT NULL CONSTRAINT [DF_AccountsInfo_NullityOverDate]  DEFAULT ('1900-01-01'),
	[StunDown] [tinyint] NOT NULL CONSTRAINT [DF_AccountsInfo_CloseDown]  DEFAULT ((0)),
	[MoorMachine] [tinyint] NOT NULL CONSTRAINT [DF_AccountsInfo_MoorMachine]  DEFAULT ((0)),
	[IsAndroid] [tinyint] NOT NULL CONSTRAINT [DF_AccountsInfo_IsAndroid]  DEFAULT ((0)),
	[WebLogonTimes] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_WebLogonTimes]  DEFAULT ((0)),
	[GameLogonTimes] [int] NOT NULL CONSTRAINT [DF_UserAccounts_AllLogonTimes]  DEFAULT ((0)),
	[PlayTimeCount] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_PlayTimeCount]  DEFAULT ((0)),
	[OnLineTimeCount] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_OnLineTimeCount]  DEFAULT ((0)),
	[LastLogonIP] [nvarchar](15) NOT NULL,
	[LastLogonDate] [datetime] NOT NULL CONSTRAINT [DF_UserAccounts_LastLogonDate]  DEFAULT (getdate()),
	[LastLogonMobile] [nvarchar](11) NOT NULL CONSTRAINT [DF_AccountsInfo_RegisterMobile1]  DEFAULT (N''),
	[LastLogonMachine] [nvarchar](32) NOT NULL CONSTRAINT [DF_AccountsInfo_MachineSerial]  DEFAULT ('------------'),
	[RegisterIP] [nvarchar](15) NOT NULL,
	[RegisterDate] [datetime] NOT NULL CONSTRAINT [DF_UserAccounts_RegisterDate]  DEFAULT (getdate()),
	[RegisterMobile] [nvarchar](11) NOT NULL CONSTRAINT [DF_AccountsInfo_RegisterMobile]  DEFAULT (N''),
	[RegisterMachine] [nvarchar](32) NOT NULL CONSTRAINT [DF_AccountsInfo_RegisterMachine]  DEFAULT (N'------------'),
	[PlatformID] [int] NOT NULL CONSTRAINT [DF_AccountsInfo_PlatformID]  DEFAULT ((0)),
	[UserUin] [bigint] NOT NULL CONSTRAINT [DF_AccountsInfo_UserUin]  DEFAULT ((0)),
	[RankID] [int] NULL,
 CONSTRAINT [PK_AccountsInfo_UserID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'GameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密保标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'ProtectID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'口令索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'PasswordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'推广员标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'SpreaderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户帐号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'Accounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户昵称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'NickName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册帐号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'RegAccounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'个性签名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'UnderWrite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'身份证号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'PassPortID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'真实名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'Compellation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'LogonPass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'安全密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'InsurePass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'动态密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'DynamicPass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'动态密码更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'DynamicPassTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'头像标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'FaceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自定标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'CustomID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送礼物' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'Present'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户奖牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'UserMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'经验数值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'Experience'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户魅力' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'LoveLiness'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'UserRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'MasterRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'ServiceRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理等级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'MasterOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员等级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'MemberOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'过期日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'MemberOverDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'切换时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'MemberSwitchDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'头像版本' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'CustomFaceVer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户性别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'Gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁止服务' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁止时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'NullityOverDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关闭标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'StunDown'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'固定机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'MoorMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否机器人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'IsAndroid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'WebLogonTimes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'GameLogonTimes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'PlayTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'OnLineTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'LastLogonIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'LastLogonDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录手机' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'LastLogonMobile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'LastLogonMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'RegisterIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'RegisterDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册手机' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'RegisterMobile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'RegisterMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'PlatformID'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfineAddress](
	[AddrString] [nvarchar](15) NOT NULL,
	[EnjoinLogon] [bit] NOT NULL CONSTRAINT [DF_AddrConfineRule_EnjoinLogon]  DEFAULT ((0)),
	[EnjoinRegister] [bit] NOT NULL CONSTRAINT [DF_AddrConfineRule_EnjoinRegister]  DEFAULT ((0)),
	[EnjoinScore] [bit] NOT NULL CONSTRAINT [DF_ConfineAddress_EnjoinScore]  DEFAULT ((0)),
	[EnjoinOverDate] [datetime] NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_AddrConfineRule_CollectDate]  DEFAULT (getdate()),
	[CollectNote] [nvarchar](32) NOT NULL CONSTRAINT [DF_AddrConfineRule_CollectNote]  DEFAULT (''),
 CONSTRAINT [PK_ConfineAddress_AddrString] PRIMARY KEY CLUSTERED 
(
	[AddrString] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地址字符' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineAddress', @level2type=N'COLUMN',@level2name=N'AddrString'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'限制登录' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineAddress', @level2type=N'COLUMN',@level2name=N'EnjoinLogon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'限制注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineAddress', @level2type=N'COLUMN',@level2name=N'EnjoinRegister'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'限制分数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineAddress', @level2type=N'COLUMN',@level2name=N'EnjoinScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'过期时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineAddress', @level2type=N'COLUMN',@level2name=N'EnjoinOverDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收集日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineAddress', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输入备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineAddress', @level2type=N'COLUMN',@level2name=N'CollectNote'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AndroidLockInfo](
	[UserID] [int] NOT NULL,
	[AndroidStatus] [tinyint] NOT NULL CONSTRAINT [DF_AndroidLockInfo_AndroidStatus]  DEFAULT ((0)),
	[ServerID] [int] NOT NULL CONSTRAINT [DF_AndroidLockInfo_ServerID]  DEFAULT ((0)),
	[BatchID] [int] NOT NULL CONSTRAINT [DF_AndroidLockInfo_BatchID]  DEFAULT ((0)),
	[LockDateTime] [datetime] NOT NULL CONSTRAINT [DF_AndroidLockInfo_LockDataTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_AndroidLockInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机器标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidLockInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidLockInfo', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'批次标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidLockInfo', @level2type=N'COLUMN',@level2name=N'BatchID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'插入日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidLockInfo', @level2type=N'COLUMN',@level2name=N'LockDateTime'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountsSignin](
	[UserID] [int] NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[LastDateTime] [datetime] NOT NULL,
	[SeriesDate] [smallint] NOT NULL,
	[MachineSerial] [nvarchar](32) NOT NULL CONSTRAINT [DF_AccountsSignin_MachineSerial]  DEFAULT (N''),
 CONSTRAINT [PK_AccountsCheckIn] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'连续签到天数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsSignin', @level2type=N'COLUMN',@level2name=N'SeriesDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机器序列' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsSignin', @level2type=N'COLUMN',@level2name=N'MachineSerial'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReserveIdentifier](
	[GameID] [int] NOT NULL,
	[IDLevel] [int] NOT NULL CONSTRAINT [DF_Table1_IDLevel]  DEFAULT ((0)),
	[Distribute] [bit] NOT NULL CONSTRAINT [DF_ReserveIdentifiers_Distribute]  DEFAULT ((0)),
 CONSTRAINT [PK_ReserveIdentifier_GameID] PRIMARY KEY CLUSTERED 
(
	[GameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReserveIdentifier', @level2type=N'COLUMN',@level2name=N'GameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标识等级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReserveIdentifier', @level2type=N'COLUMN',@level2name=N'IDLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分配标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReserveIdentifier', @level2type=N'COLUMN',@level2name=N'Distribute'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemStreamInfo](
	[DateID] [int] NOT NULL,
	[WebLogonSuccess] [int] NOT NULL CONSTRAINT [DF_SystemLogonInfo_WebLogonSuccess]  DEFAULT ((0)),
	[WebRegisterSuccess] [int] NOT NULL CONSTRAINT [DF_SystemLogonInfo_WebRegisterSuccess]  DEFAULT ((0)),
	[GameLogonSuccess] [int] NOT NULL CONSTRAINT [DF_TABLE1_LogonCount]  DEFAULT ((0)),
	[GameRegisterSuccess] [int] NOT NULL CONSTRAINT [DF_TABLE1_RegisterCount]  DEFAULT ((0)),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_TABLE1_RecordDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_SystemStreamInfo] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日期标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'DateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录成功' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'WebLogonSuccess'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册成功' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'WebRegisterSuccess'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录成功' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'GameLogonSuccess'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册成功' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'GameRegisterSuccess'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountsProperty](
	[UserID] [int] NOT NULL,
	[PropID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[PropCount] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[SendTime] [datetime] NOT NULL CONSTRAINT [DF_AccountsProperty_SendTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_AccountsProperty] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[PropID] ASC,
	[ServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProperty', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'道具标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProperty', @level2type=N'COLUMN',@level2name=N'PropID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProperty', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'道具数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProperty', @level2type=N'COLUMN',@level2name=N'PropCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProperty', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'购买时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProperty', @level2type=N'COLUMN',@level2name=N'SendTime'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountsBaseEnsure](
	[UserID] [int] NOT NULL,
	[TakeDateID] [int] NOT NULL,
	[TakeTimes] [smallint] NOT NULL,
 CONSTRAINT [PK_AccountsBaseEnsure_1] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[TakeDateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsBaseEnsure', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领取日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsBaseEnsure', @level2type=N'COLUMN',@level2name=N'TakeDateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领取次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsBaseEnsure', @level2type=N'COLUMN',@level2name=N'TakeTimes'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountsFace](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CustomFace] [image] NOT NULL,
	[InsertTime] [datetime] NOT NULL CONSTRAINT [DF_AccountsFace_CustomTime]  DEFAULT (getdate()),
	[InsertAddr] [nvarchar](15) NOT NULL,
	[InsertMachine] [nvarchar](12) NOT NULL,
 CONSTRAINT [PK_AccountsFace_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsFace', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsFace', @level2type=N'COLUMN',@level2name=N'InsertAddr'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemGrantCount](
	[DateID] [int] NOT NULL,
	[RegisterIP] [nchar](15) NOT NULL,
	[RegisterMachine] [nvarchar](32) NOT NULL CONSTRAINT [DF_SystemGrantCount_RegisterMachine]  DEFAULT (N'------------'),
	[GrantScore] [bigint] NOT NULL,
	[GrantCount] [bigint] NOT NULL CONSTRAINT [DF_SystemGrantCount_PresentScoreStat]  DEFAULT ((0)),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_SystemGrantCount_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_SystemGrantCount] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[RegisterIP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemGrantCount', @level2type=N'COLUMN',@level2name=N'RegisterIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemGrantCount', @level2type=N'COLUMN',@level2name=N'RegisterMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemGrantCount', @level2type=N'COLUMN',@level2name=N'GrantScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemGrantCount', @level2type=N'COLUMN',@level2name=N'GrantCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收集时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemGrantCount', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfineMachine](
	[MachineSerial] [nvarchar](32) NOT NULL,
	[EnjoinLogon] [bit] NOT NULL CONSTRAINT [DF_MachineConfineRule_EnjoinLogon]  DEFAULT ((0)),
	[EnjoinRegister] [bit] NOT NULL CONSTRAINT [DF_MachineConfineRule_EnjoinRegister]  DEFAULT ((0)),
	[EnjoinScore] [bit] NOT NULL CONSTRAINT [DF_ConfineMachine_EnjoinScore]  DEFAULT ((0)),
	[EnjoinOverDate] [datetime] NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_MachineConfineRule_CollectDate]  DEFAULT (getdate()),
	[CollectNote] [nvarchar](32) NOT NULL CONSTRAINT [DF_MachineConfineRule_CollectNote]  DEFAULT (''),
 CONSTRAINT [PK_ConfineMachine_MachineSerial] PRIMARY KEY CLUSTERED 
(
	[MachineSerial] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机器序列' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineMachine', @level2type=N'COLUMN',@level2name=N'MachineSerial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'限制登录' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineMachine', @level2type=N'COLUMN',@level2name=N'EnjoinLogon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'限制注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineMachine', @level2type=N'COLUMN',@level2name=N'EnjoinRegister'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'限制分数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineMachine', @level2type=N'COLUMN',@level2name=N'EnjoinScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'过期时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineMachine', @level2type=N'COLUMN',@level2name=N'EnjoinOverDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收集日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineMachine', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输入备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineMachine', @level2type=N'COLUMN',@level2name=N'CollectNote'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfineContent](
	[ContentID] [int] IDENTITY(1,1) NOT NULL,
	[String] [nvarchar](31) NOT NULL,
	[EnjoinOverDate] [datetime] NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReserveCharacter_ModifyDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ConfineContent] PRIMARY KEY CLUSTERED 
(
	[ContentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保留字符' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineContent', @level2type=N'COLUMN',@level2name=N'String'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineContent', @level2type=N'COLUMN',@level2name=N'EnjoinOverDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineContent', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountsProtect](
	[ProtectID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Question1] [nvarchar](32) NOT NULL,
	[Response1] [nvarchar](32) NOT NULL,
	[Question2] [nvarchar](32) NOT NULL,
	[Response2] [nvarchar](32) NOT NULL,
	[Question3] [nvarchar](32) NOT NULL,
	[Response3] [nvarchar](32) NOT NULL,
	[PassportID] [nvarchar](32) NOT NULL,
	[PassportType] [tinyint] NOT NULL,
	[SafeEmail] [nvarchar](32) NOT NULL,
	[CreateIP] [nvarchar](15) NOT NULL,
	[ModifyIP] [nvarchar](15) NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_AccountsProtect_CreateDate]  DEFAULT (getdate()),
	[ModifyDate] [datetime] NOT NULL CONSTRAINT [DF_AccountsProtect_ModifyDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_AccountsProtect] PRIMARY KEY CLUSTERED 
(
	[ProtectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密保标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'ProtectID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'问题一' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'Question1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'答案一' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'Response1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'问题二' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'Question2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'答案二' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'Response2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'问题三' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'Question3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'答案三' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'Response3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'证件号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'PassportID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'证件类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'PassportType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'安全邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'SafeEmail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'CreateIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'ModifyIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsProtect', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemMachineGrantCount](
	[DateID] [int] NOT NULL,
	[RegisterMachine] [nvarchar](32) NOT NULL CONSTRAINT [DF_SystemMachineGrantCount_RegisterMachine]  DEFAULT (N'------------'),
	[RegisterIP] [nchar](15) NOT NULL,
	[GrantScore] [bigint] NOT NULL,
	[GrantCount] [bigint] NOT NULL CONSTRAINT [DF_SystemMachineGrantCount_PresentScoreStat]  DEFAULT ((0)),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_SystemMachineGrantCount_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_SystemMachineGrantCount_1] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[RegisterMachine] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMachineGrantCount', @level2type=N'COLUMN',@level2name=N'RegisterMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMachineGrantCount', @level2type=N'COLUMN',@level2name=N'RegisterIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMachineGrantCount', @level2type=N'COLUMN',@level2name=N'GrantScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMachineGrantCount', @level2type=N'COLUMN',@level2name=N'GrantCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收集时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMachineGrantCount', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AndroidConfigure](
	[BatchID] [int] IDENTITY(1,1) NOT NULL,
	[ServerID] [int] NOT NULL,
	[ServiceMode] [int] NOT NULL,
	[AndroidCount] [int] NOT NULL,
	[EnterTime] [int] NOT NULL,
	[LeaveTime] [int] NOT NULL,
	[EnterMinInterval] [int] NOT NULL,
	[EnterMaxInterval] [int] NOT NULL,
	[LeaveMinInterval] [int] NOT NULL,
	[LeaveMaxInterval] [int] NOT NULL,
	[TakeMinScore] [bigint] NOT NULL,
	[TakeMaxScore] [bigint] NOT NULL,
	[SwitchMinInnings] [int] NOT NULL,
	[SwitchMaxInnings] [int] NOT NULL,
 CONSTRAINT [PK_AndroidConfigure_1] PRIMARY KEY CLUSTERED 
(
	[BatchID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'批次标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidConfigure', @level2type=N'COLUMN',@level2name=N'BatchID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidConfigure', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务模式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidConfigure', @level2type=N'COLUMN',@level2name=N'ServiceMode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidConfigure', @level2type=N'COLUMN',@level2name=N'EnterTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'离开时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidConfigure', @level2type=N'COLUMN',@level2name=N'LeaveTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入最小间隔' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidConfigure', @level2type=N'COLUMN',@level2name=N'EnterMinInterval'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入最大间隔' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidConfigure', @level2type=N'COLUMN',@level2name=N'EnterMaxInterval'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'离开最小间隔' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidConfigure', @level2type=N'COLUMN',@level2name=N'LeaveMinInterval'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'离开最大间隔' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidConfigure', @level2type=N'COLUMN',@level2name=N'LeaveMaxInterval'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最少携带分数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidConfigure', @level2type=N'COLUMN',@level2name=N'TakeMinScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大携带分数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidConfigure', @level2type=N'COLUMN',@level2name=N'TakeMaxScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最少换桌局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidConfigure', @level2type=N'COLUMN',@level2name=N'SwitchMinInnings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大换桌局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidConfigure', @level2type=N'COLUMN',@level2name=N'SwitchMaxInnings'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountsMember](
	[UserID] [int] NOT NULL,
	[MemberOrder] [tinyint] NOT NULL,
	[UserRight] [int] NOT NULL CONSTRAINT [DF_MemberInfo_UserRight]  DEFAULT ((0)),
	[MemberOverDate] [datetime] NOT NULL CONSTRAINT [DF_MemberInfo_MemberOverDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_MemberInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[MemberOrder] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsMember', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsMember', @level2type=N'COLUMN',@level2name=N'MemberOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsMember', @level2type=N'COLUMN',@level2name=N'UserRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员期限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsMember', @level2type=N'COLUMN',@level2name=N'MemberOverDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameVIPInfo](
	[UserID] [int] NOT NULL,
	[NickName] [nvarchar](31) NOT NULL,
	[QQNumber] [nvarchar](15) NOT NULL,
	[DescribeString] [nvarchar](127) NOT NULL,
 CONSTRAINT [PK_GameVIPInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameVIPInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户昵称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameVIPInfo', @level2type=N'COLUMN',@level2name=N'NickName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'QQ号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameVIPInfo', @level2type=N'COLUMN',@level2name=N'QQNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameVIPInfo', @level2type=N'COLUMN',@level2name=N'DescribeString'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountsInterface](
	[InterfaceID] [nvarchar](100) NOT NULL,
	[PlatformID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[InterfaceDate] [datetime] NOT NULL CONSTRAINT [DF_AccountsInterface_InterfaceDate]  DEFAULT (getdate()),
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_AccountsInterface_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_AccountsInterface] PRIMARY KEY CLUSTERED 
(
	[InterfaceID] ASC,
	[PlatformID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'接口标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInterface', @level2type=N'COLUMN',@level2name=N'InterfaceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInterface', @level2type=N'COLUMN',@level2name=N'PlatformID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInterface', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'接口日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInterface', @level2type=N'COLUMN',@level2name=N'InterfaceDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁止标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInterface', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlatformConfig](
	[PlatformID] [int] NOT NULL,
	[PlatformName] [nvarchar](50) NOT NULL CONSTRAINT [DF_PlatformConfig_PlatformName]  DEFAULT (N''),
	[ShortName] [nvarchar](12) NOT NULL CONSTRAINT [DF_PlatformConfig_ShortName]  DEFAULT (N''),
 CONSTRAINT [PK_PlatformConfig] PRIMARY KEY CLUSTERED 
(
	[PlatformID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformConfig', @level2type=N'COLUMN',@level2name=N'PlatformID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformConfig', @level2type=N'COLUMN',@level2name=N'PlatformName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台简称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformConfig', @level2type=N'COLUMN',@level2name=N'ShortName'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MobileValidateCode](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[CodeType] [tinyint] NOT NULL,
	[MobilePhone] [nvarchar](11) NOT NULL,
	[ValidateCode] [int] NOT NULL,
	[SendDate] [datetime] NOT NULL,
	[ValidDate] [datetime] NOT NULL,
	[RequesMachine] [nvarchar](32) NOT NULL,
	[RequestIP] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_MobileValidateCode_1] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MobileValidateCode', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'验证类型 1:手机绑定 2:解除绑定 3:手机登录 4:手机注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MobileValidateCode', @level2type=N'COLUMN',@level2name=N'CodeType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MobileValidateCode', @level2type=N'COLUMN',@level2name=N'MobilePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'验证密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MobileValidateCode', @level2type=N'COLUMN',@level2name=N'ValidateCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发送时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MobileValidateCode', @level2type=N'COLUMN',@level2name=N'SendDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生效时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MobileValidateCode', @level2type=N'COLUMN',@level2name=N'ValidDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'请求机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MobileValidateCode', @level2type=N'COLUMN',@level2name=N'RequesMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'请求地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MobileValidateCode', @level2type=N'COLUMN',@level2name=N'RequestIP'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountsSpreader](
	[SpreaderID] [int] NOT NULL,
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_AccountsSpreader_Nullity]  DEFAULT ((0)),
	[InputDate] [datetime] NOT NULL CONSTRAINT [DF_AccountsSpreader_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_AccountsSpreader] PRIMARY KEY CLUSTERED 
(
	[SpreaderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'推广员标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsSpreader', @level2type=N'COLUMN',@level2name=N'SpreaderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁止服务' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsSpreader', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsSpreader', @level2type=N'COLUMN',@level2name=N'InputDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegisterMachineInfo](
	[RegisterMachine] [nvarchar](32) NOT NULL,
	[RegisterCount] [bigint] NOT NULL,
 CONSTRAINT [PK_RegisterMachineInfo] PRIMARY KEY CLUSTERED 
(
	[RegisterMachine] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegisterMachineInfo', @level2type=N'COLUMN',@level2name=N'RegisterMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegisterMachineInfo', @level2type=N'COLUMN',@level2name=N'RegisterCount'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlatformReport](
	[PlatformID] [int] NOT NULL,
	[ReportDate] [nvarchar](10) NOT NULL,
	[RegisterCount] [int] NOT NULL CONSTRAINT [DF_PlatformReport_RegisterCount]  DEFAULT ((0)),
	[RechargeCount] [int] NOT NULL CONSTRAINT [DF_PlatformReport_RechargeCount]  DEFAULT ((0)),
	[RechargeAmount] [decimal](18, 2) NOT NULL CONSTRAINT [DF_PlatformReport_RechargeAmount]  DEFAULT ((0)),
	[GenerateDate] [datetime] NOT NULL CONSTRAINT [DF_PlatformReport_GenerateDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_PlatformReport] PRIMARY KEY CLUSTERED 
(
	[PlatformID] ASC,
	[ReportDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformReport', @level2type=N'COLUMN',@level2name=N'PlatformID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'统计日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformReport', @level2type=N'COLUMN',@level2name=N'ReportDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformReport', @level2type=N'COLUMN',@level2name=N'RegisterCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformReport', @level2type=N'COLUMN',@level2name=N'RechargeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformReport', @level2type=N'COLUMN',@level2name=N'RechargeAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生成时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformReport', @level2type=N'COLUMN',@level2name=N'GenerateDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MobileBindingInfo](
	[UserID] [int] NOT NULL,
	[MobilePhone] [nvarchar](11) NOT NULL,
	[BindingDate] [datetime] NOT NULL CONSTRAINT [DF_MobileBindingInfo_BindingDate]  DEFAULT (getdate()),
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_MobileBindingInfo_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_MobileBindingInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MobileBindingInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MobileBindingInfo', @level2type=N'COLUMN',@level2name=N'MobilePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'绑定时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MobileBindingInfo', @level2type=N'COLUMN',@level2name=N'BindingDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'绑定标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MobileBindingInfo', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WXBindingInfo](
	[UserID] [int] NOT NULL,
	[OpenID] [nvarchar](64) NOT NULL,
	[BindingDate] [datetime] NOT NULL CONSTRAINT [DF_WXBindingInfo_BindingDate]  DEFAULT (getdate()),
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_WXBindingInfo_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_WXBindingInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WXBindingInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'微信标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WXBindingInfo', @level2type=N'COLUMN',@level2name=N'OpenID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'绑定时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WXBindingInfo', @level2type=N'COLUMN',@level2name=N'BindingDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'绑定标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WXBindingInfo', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlatformMobileReport](
	[PlatformID] [int] NOT NULL,
	[ReportDate] [nvarchar](10) NOT NULL,
	[RegisterCount] [int] NOT NULL CONSTRAINT [DF_PlatformMobileReport_RegisterCount]  DEFAULT ((0)),
	[DAU] [int] NOT NULL CONSTRAINT [DF_PlatformMobileReport_DAU]  DEFAULT ((0)),
	[RechargeCount] [int] NOT NULL CONSTRAINT [DF_PlatformMobileReport_RechargeCount]  DEFAULT ((0)),
	[RechargeTimes] [int] NOT NULL,
	[RechargeAmount] [decimal](18, 2) NOT NULL CONSTRAINT [DF_PlatformMobileReport_RechargeAmount]  DEFAULT ((0)),
	[DAUPayRate] [float] NOT NULL CONSTRAINT [DF_PlatformMobileReport_DAUPay]  DEFAULT ((0)),
	[ARPU] [float] NOT NULL CONSTRAINT [DF_PlatformMobileReport_ARPU]  DEFAULT ((0)),
	[ARPPU] [decimal](18, 2) NOT NULL CONSTRAINT [DF_PlatformMobileReport_ARPPU]  DEFAULT ((0)),
	[NewRechargeCount] [int] NOT NULL CONSTRAINT [DF_PlatformMobileReport_NewRechargeCount]  DEFAULT ((0)),
	[NewRechargeTimes] [int] NOT NULL CONSTRAINT [DF_PlatformMobileReport_NewRechargeTimes]  DEFAULT ((0)),
	[NewRechargeAmount] [decimal](18, 2) NOT NULL CONSTRAINT [DF_PlatformMobileReport_NewRechargeAmount]  DEFAULT ((0)),
	[NewPayRate] [float] NOT NULL CONSTRAINT [DF_PlatformMobileReport_NewPayRate]  DEFAULT ((0)),
	[NewARPPU] [decimal](18, 2) NOT NULL CONSTRAINT [DF_PlatformMobileReport_NewARPPU]  DEFAULT ((0)),
	[GenerateDate] [datetime] NOT NULL CONSTRAINT [DF_PlatformMobileReport_GenerateDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_PlatformMobileReport] PRIMARY KEY CLUSTERED 
(
	[PlatformID] ASC,
	[ReportDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'PlatformID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'统计日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'ReportDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新增注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'RegisterCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DAU' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'DAU'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'RechargeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'RechargeTimes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'RechargeAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DAU付费率' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'DAUPayRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ARPU' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'ARPU'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ARPPU' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'ARPPU'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新增充值人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'NewRechargeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新增充值次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'NewRechargeTimes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新增充值金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'NewRechargeAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新增付费率' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'NewPayRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新增ARPPU' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'NewARPPU'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生成时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PlatformMobileReport', @level2type=N'COLUMN',@level2name=N'GenerateDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountsPackage](
	[UserID] [int] NOT NULL,
	[GoodsID] [int] NOT NULL,
	[GoodsCount] [int] NOT NULL,
 CONSTRAINT [PK_AccountsPackage] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[GoodsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsPackage', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsPackage', @level2type=N'COLUMN',@level2name=N'GoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsPackage', @level2type=N'COLUMN',@level2name=N'GoodsCount'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackageBoxConfig](
	[GoodsID] [int] NOT NULL,
	[LuckyGoodsID] [int] NOT NULL,
	[LuckyGoodsCount] [int] NOT NULL,
	[RangeStart] [int] NOT NULL,
	[RangeEnd] [int] NOT NULL,
 CONSTRAINT [PK_PackageBoxConfig] PRIMARY KEY CLUSTERED 
(
	[GoodsID] ASC,
	[LuckyGoodsID] ASC,
	[LuckyGoodsCount] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageBoxConfig', @level2type=N'COLUMN',@level2name=N'GoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'中奖物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageBoxConfig', @level2type=N'COLUMN',@level2name=N'LuckyGoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageBoxConfig', @level2type=N'COLUMN',@level2name=N'LuckyGoodsCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'范围开始' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageBoxConfig', @level2type=N'COLUMN',@level2name=N'RangeStart'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'范围结束' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageBoxConfig', @level2type=N'COLUMN',@level2name=N'RangeEnd'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackageExchangeFee](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[MobilePhone] [nvarchar](11) NOT NULL,
	[GoodsID] [int] NOT NULL,
	[GoodsCount] [int] NOT NULL,
	[ExchangeDate] [datetime] NOT NULL CONSTRAINT [DF_PackageExchangeFee_ExchangeDate]  DEFAULT (getdate()),
	[Success] [tinyint] NOT NULL CONSTRAINT [DF_PackageExchangeFee_Success]  DEFAULT ((0)),
	[SuccessDate] [datetime] NOT NULL CONSTRAINT [DF_PackageExchangeFee_SuccessDate]  DEFAULT (getdate()),
	[SuccessNote] [nvarchar](64) NOT NULL CONSTRAINT [DF_PackageExchangeFee_SuccessNote]  DEFAULT (N''),
 CONSTRAINT [PK_PackageExchangeFee] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageExchangeFee', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageExchangeFee', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageExchangeFee', @level2type=N'COLUMN',@level2name=N'MobilePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageExchangeFee', @level2type=N'COLUMN',@level2name=N'GoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageExchangeFee', @level2type=N'COLUMN',@level2name=N'GoodsCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageExchangeFee', @level2type=N'COLUMN',@level2name=N'ExchangeDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发放标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageExchangeFee', @level2type=N'COLUMN',@level2name=N'Success'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发放日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageExchangeFee', @level2type=N'COLUMN',@level2name=N'SuccessDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发放备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageExchangeFee', @level2type=N'COLUMN',@level2name=N'SuccessNote'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackageGoodsInfo](
	[GoodsID] [int] NOT NULL,
	[GoodsName] [nvarchar](31) NOT NULL,
	[GoodsType] [tinyint] NOT NULL,
	[GoodsPrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_PackageGoodsInfo_GoodsPrice]  DEFAULT ((0)),
	[LimitCount] [int] NOT NULL CONSTRAINT [DF_PackageGoodsInfo_LimitCount]  DEFAULT ((0)),
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_PackageGoodsInfo_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_PackageGoodsInfo] PRIMARY KEY CLUSTERED 
(
	[GoodsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageGoodsInfo', @level2type=N'COLUMN',@level2name=N'GoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageGoodsInfo', @level2type=N'COLUMN',@level2name=N'GoodsName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageGoodsInfo', @level2type=N'COLUMN',@level2name=N'GoodsType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageGoodsInfo', @level2type=N'COLUMN',@level2name=N'GoodsPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换条件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageGoodsInfo', @level2type=N'COLUMN',@level2name=N'LimitCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁止标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageGoodsInfo', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackageGoodsType](
	[GoodsType] [tinyint] NOT NULL,
	[TypeName] [nvarchar](31) NOT NULL,
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_PackageGoodsType_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_PackageGoodsType] PRIMARY KEY CLUSTERED 
(
	[GoodsType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageGoodsType', @level2type=N'COLUMN',@level2name=N'GoodsType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageGoodsType', @level2type=N'COLUMN',@level2name=N'TypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁止标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageGoodsType', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackageRecord](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[RecordType] [tinyint] NOT NULL,
	[GoodsID] [int] NOT NULL,
	[GoodsCount] [int] NOT NULL,
	[RecordNote] [nvarchar](64) NOT NULL CONSTRAINT [DF_PackageRecord_RecordNote]  DEFAULT (N''),
	[RecodrdDate] [datetime] NOT NULL CONSTRAINT [DF_PackageRecord_RecodrdDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_PackageRecord] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageRecord', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageRecord', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录类型 1:消耗 2:获得' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageRecord', @level2type=N'COLUMN',@level2name=N'RecordType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageRecord', @level2type=N'COLUMN',@level2name=N'GoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageRecord', @level2type=N'COLUMN',@level2name=N'GoodsCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageRecord', @level2type=N'COLUMN',@level2name=N'RecordNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageRecord', @level2type=N'COLUMN',@level2name=N'RecodrdDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LotteryConfig](
	[ItemIndex] [int] NOT NULL,
	[LuckyGoodsID] [int] NOT NULL,
	[LuckyGoodsCount] [int] NOT NULL,
	[RangeStart] [int] NOT NULL,
	[RangeEnd] [int] NOT NULL,
 CONSTRAINT [PK_LotteryConfig] PRIMARY KEY CLUSTERED 
(
	[ItemIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖项索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LotteryConfig', @level2type=N'COLUMN',@level2name=N'ItemIndex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'中奖物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LotteryConfig', @level2type=N'COLUMN',@level2name=N'LuckyGoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LotteryConfig', @level2type=N'COLUMN',@level2name=N'LuckyGoodsCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'范围开始' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LotteryConfig', @level2type=N'COLUMN',@level2name=N'RangeStart'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'范围结束' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LotteryConfig', @level2type=N'COLUMN',@level2name=N'RangeEnd'
GO
CREATE TABLE [dbo].[RewardLimit](
	[RewardLimit] [int] NOT NULL,
	[RechargeAmount] [int] NOT NULL,
 CONSTRAINT [PK_RewardLimit] PRIMARY KEY CLUSTERED 
(
	[RewardLimit] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励限制' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RewardLimit', @level2type=N'COLUMN',@level2name=N'RewardLimit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RewardLimit', @level2type=N'COLUMN',@level2name=N'RechargeAmount'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackagePacksConfig](
	[GoodsID] [int] NOT NULL,
	[PacksGoodsID] [int] NOT NULL,
	[PacksGoodsCount] [int] NOT NULL,
 CONSTRAINT [PK_PackagePacksConfig] PRIMARY KEY CLUSTERED 
(
	[GoodsID] ASC,
	[PacksGoodsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackagePacksConfig', @level2type=N'COLUMN',@level2name=N'GoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackagePacksConfig', @level2type=N'COLUMN',@level2name=N'PacksGoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackagePacksConfig', @level2type=N'COLUMN',@level2name=N'PacksGoodsCount'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RookiePacks](
	[UserID] [int] NOT NULL,
	[TakeDateTime] [datetime] NOT NULL CONSTRAINT [DF_RookiePacks_TakeDateTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_RookiePacks] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RookiePacks', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领取时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RookiePacks', @level2type=N'COLUMN',@level2name=N'TakeDateTime'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RedPacketConfig](
	[ItemIndex] [int] NOT NULL,
	[LuckyGoodsID] [int] NOT NULL,
	[LuckyGoodsCount] [int] NOT NULL,
	[RangeStart] [int] NOT NULL,
	[RangeEnd] [int] NOT NULL,
 CONSTRAINT [PK_RedPacketConfig] PRIMARY KEY CLUSTERED 
(
	[ItemIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖项索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketConfig', @level2type=N'COLUMN',@level2name=N'ItemIndex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'中奖物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketConfig', @level2type=N'COLUMN',@level2name=N'LuckyGoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketConfig', @level2type=N'COLUMN',@level2name=N'LuckyGoodsCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'范围开始' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketConfig', @level2type=N'COLUMN',@level2name=N'RangeStart'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'范围结束' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketConfig', @level2type=N'COLUMN',@level2name=N'RangeEnd'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RedPacketLotteryRecord](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[GoodsID] [int] NOT NULL,
	[GoodsCount] [int] NOT NULL,
	[RecodrdDate] [datetime] NOT NULL CONSTRAINT [DF_RedPacketLotteryRecord_RecodrdDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RedPacketLotteryRecord] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketLotteryRecord', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketLotteryRecord', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketLotteryRecord', @level2type=N'COLUMN',@level2name=N'GoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketLotteryRecord', @level2type=N'COLUMN',@level2name=N'GoodsCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketLotteryRecord', @level2type=N'COLUMN',@level2name=N'RecodrdDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RedPacketStorage](
	[Nullity] [tinyint] NOT NULL,
	[Consume] [decimal](18, 2) NOT NULL,
	[Deduct] [decimal](18, 2) NOT NULL,
	[Storage] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_RedPacketStorage] PRIMARY KEY CLUSTERED 
(
	[Nullity] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketStorage', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消耗数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketStorage', @level2type=N'COLUMN',@level2name=N'Consume'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'衰减比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketStorage', @level2type=N'COLUMN',@level2name=N'Deduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前库存' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RedPacketStorage', @level2type=N'COLUMN',@level2name=N'Storage'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AliPayBindingInfo](
	[UserID] [int] NOT NULL,
	[PayeeAccount] [nvarchar](100) NOT NULL,
	[PayeeRealName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_AliPayBindingInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AliPayBindingInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收款账户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AliPayBindingInfo', @level2type=N'COLUMN',@level2name=N'PayeeAccount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收款姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AliPayBindingInfo', @level2type=N'COLUMN',@level2name=N'PayeeRealName'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebVisitInfo](
	[WebVisitIP] [nvarchar](15) NOT NULL,
	[ChannelID] [int] NOT NULL,
	[WebVisitDate] [datetime] NOT NULL CONSTRAINT [DF_WebVisitInfo_WebVisitDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_WebVisitInfo] PRIMARY KEY CLUSTERED 
(
	[WebVisitIP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'访问地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebVisitInfo', @level2type=N'COLUMN',@level2name=N'WebVisitIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebVisitInfo', @level2type=N'COLUMN',@level2name=N'ChannelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'访问时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebVisitInfo', @level2type=N'COLUMN',@level2name=N'WebVisitDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChannelType](
	[ChannelType] [tinyint] NOT NULL,
	[TypeName] [nvarchar](31) NOT NULL,
 CONSTRAINT [PK_ChannelType] PRIMARY KEY CLUSTERED 
(
	[ChannelType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelType', @level2type=N'COLUMN',@level2name=N'ChannelType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelType', @level2type=N'COLUMN',@level2name=N'TypeName'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChannelConfig](
	[ChannelID] [int] NOT NULL,
	[ChannelName] [nvarchar](31) NOT NULL,
	[ChannelType] [tinyint] NOT NULL,
	[ChannelAccounts] [nvarchar](31) NOT NULL,
	[ChannelPassword] [nchar](32) NOT NULL,
	[ProductName] [nvarchar](31) NOT NULL,
	[CooperationWay] [nvarchar](31) NOT NULL,
	[PartPercent] [decimal](18, 2) NOT NULL,
	[OutPercent] [decimal](18, 2) NOT NULL,
	[ServiceRight] [int] NOT NULL CONSTRAINT [DF_ChannelConfig_ServiceRight]  DEFAULT ((0)),
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_ChannelConfig_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_ChannelConfig] PRIMARY KEY CLUSTERED 
(
	[ChannelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelConfig', @level2type=N'COLUMN',@level2name=N'ChannelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelConfig', @level2type=N'COLUMN',@level2name=N'ChannelName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelConfig', @level2type=N'COLUMN',@level2name=N'ChannelType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelConfig', @level2type=N'COLUMN',@level2name=N'ChannelAccounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelConfig', @level2type=N'COLUMN',@level2name=N'ChannelPassword'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelConfig', @level2type=N'COLUMN',@level2name=N'ProductName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'合作方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelConfig', @level2type=N'COLUMN',@level2name=N'CooperationWay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分成比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelConfig', @level2type=N'COLUMN',@level2name=N'PartPercent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输出比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelConfig', @level2type=N'COLUMN',@level2name=N'OutPercent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelConfig', @level2type=N'COLUMN',@level2name=N'ServiceRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'无效标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelConfig', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountsChannel](
	[UserID] [int] NOT NULL,
	[ChannelID] [int] NOT NULL,
	[BindingStatus] [tinyint] NOT NULL CONSTRAINT [DF_AccountsChannel_BindingStatus]  DEFAULT ((0)),
 CONSTRAINT [PK_AccountsChannel] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsChannel', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsChannel', @level2type=N'COLUMN',@level2name=N'ChannelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'绑定状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsChannel', @level2type=N'COLUMN',@level2name=N'BindingStatus'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChannelReport](
	[PlatformID] [int] NOT NULL,
	[ChannelID] [int] NOT NULL,
	[ReportDate] [nvarchar](10) NOT NULL,
	[DownloadCount] [int] NOT NULL,
	[DownloadCountEx] [int] NOT NULL,
	[RegisterCount] [int] NOT NULL,
	[RegisterCountEx] [int] NOT NULL,
	[NewRegisterCount] [int] NOT NULL,
	[ActiveCount] [int] NOT NULL,
	[RechargeCount] [int] NOT NULL,
	[RechargeAmount] [decimal](18, 2) NOT NULL,
	[OutPercent] [decimal](18, 2) NOT NULL,
	[OutRecharge] [decimal](18, 2) NOT NULL,
	[PartPercent] [decimal](18, 2) NOT NULL,
	[PartRecharge] [decimal](18, 2) NOT NULL,
	[TransferCount] [int] NOT NULL,
	[OutScore] [bigint] NOT NULL,
	[InScore] [bigint] NOT NULL,
	[NextDayLeft] [int] NOT NULL,
	[SevenDayLeft] [int] NOT NULL,
	[ActiveUserCount] [int] NOT NULL,
	[ValidUserCount] [int] NOT NULL,
 CONSTRAINT [PK_ChannelReport] PRIMARY KEY CLUSTERED 
(
	[PlatformID] ASC,
	[ChannelID] ASC,
	[ReportDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'PlatformID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'ChannelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'统计日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'ReportDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下载数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'DownloadCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排重下载' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'DownloadCountEx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'RegisterCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排重注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'RegisterCountEx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新增注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'NewRegisterCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'激活数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'ActiveCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'RechargeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'RechargeAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输出比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'OutPercent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输出金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'OutRecharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分成比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'PartPercent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分成金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'PartRecharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转账人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'TransferCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转出分数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'OutScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转入分数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'InScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'次日留存' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'NextDayLeft'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'七日留存' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'SevenDayLeft'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'活跃用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'ActiveUserCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelReport', @level2type=N'COLUMN',@level2name=N'ValidUserCount'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempAllChannelData](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[QueryNumber] [int] NOT NULL,
	[ChannelAccounts] [nvarchar](31) NOT NULL,
	[ChannelID] [int] NOT NULL,
	[ChannelName] [nvarchar](31) NOT NULL,
	[ProductName] [nvarchar](31) NOT NULL,
	[PartPercent] [decimal](18, 2) NOT NULL,
	[CooperationWay] [nvarchar](31) NOT NULL,
	[CurrentActive] [int] NOT NULL,
	[CurrentRegister] [int] NOT NULL,
	[CurrentRecharge] [decimal](18, 2) NOT NULL,
	[CurrentOutScore] [bigint] NOT NULL,
	[CurrentInScore] [bigint] NOT NULL,
	[AllActive] [int] NOT NULL,
	[AllRegister] [int] NOT NULL,
	[AllRecharge] [decimal](18, 2) NOT NULL,
	[AllOutScore] [bigint] NOT NULL,
	[AllInScore] [bigint] NOT NULL,
	[Nullity] [tinyint] NOT NULL,
 CONSTRAINT [PK_TempAllChannelData] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'查询编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'QueryNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'ChannelAccounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'ChannelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'ChannelName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'ProductName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分成比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'PartPercent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'合作方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'CooperationWay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日激活' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'CurrentActive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'CurrentRegister'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日充值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'CurrentRecharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日转出' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'CurrentOutScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日转入' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'CurrentInScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'全部激活' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'AllActive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'全部注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'AllRegister'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'全部充值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'AllRecharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'全部转出' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'AllOutScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'全部转入' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'AllInScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'无效标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAllChannelData', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempChannelHistory](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[QueryNumber] [int] NOT NULL,
	[PlatformID] [int] NOT NULL,
	[ChannelID] [int] NOT NULL,
	[ReportDate] [nvarchar](10) NOT NULL,
	[DownloadCount] [int] NOT NULL,
	[DownloadCountEx] [int] NOT NULL,
	[RegisterCount] [int] NOT NULL,
	[RegisterCountEx] [int] NOT NULL,
	[NewRegisterCount] [int] NOT NULL,
	[ActiveCount] [int] NOT NULL,
	[RechargeCount] [int] NOT NULL,
	[RechargeAmount] [decimal](18, 2) NOT NULL,
	[OutPercent] [decimal](18, 2) NOT NULL,
	[OutRecharge] [decimal](18, 2) NOT NULL,
	[PartPercent] [decimal](18, 2) NOT NULL,
	[PartRecharge] [decimal](18, 2) NOT NULL,
	[TransferCount] [int] NOT NULL,
	[OutScore] [bigint] NOT NULL,
	[InScore] [bigint] NOT NULL,
	[NextDayLeft] [int] NOT NULL,
	[SevenDayLeft] [int] NOT NULL,
	[ActiveUserCount] [int] NOT NULL,
	[ValidUserCount] [int] NOT NULL,
 CONSTRAINT [PK_TempChannelHistory] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'查询编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'QueryNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'PlatformID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'ChannelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'统计日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'ReportDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下载数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'DownloadCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排重下载' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'DownloadCountEx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'RegisterCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排重注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'RegisterCountEx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新增注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'NewRegisterCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'激活数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'ActiveCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'RechargeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'RechargeAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输出比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'OutPercent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输出金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'OutRecharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分成比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'PartPercent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分成金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'PartRecharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转账人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'TransferCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转出分数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'OutScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转入分数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'InScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'次日留存' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'NextDayLeft'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'七日留存' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'SevenDayLeft'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'活跃用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'ActiveUserCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempChannelHistory', @level2type=N'COLUMN',@level2name=N'ValidUserCount'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempAndroidIOSData](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[QueryNumber] [int] NOT NULL,
	[PlatformID] [int] NOT NULL,
	[CurrentDownload] [int] NOT NULL,
	[CurrentDownloadEx] [int] NOT NULL,
	[CurrentActive] [int] NOT NULL,
	[CurrentRegister] [int] NOT NULL,
	[CurrentRecharge] [decimal](18, 2) NOT NULL,
	[OutPercent] [decimal](18, 2) NOT NULL,
	[OutRecharge] [decimal](18, 2) NOT NULL,
	[CurrentOutScore] [bigint] NOT NULL,
	[CurrentInScore] [bigint] NOT NULL,
	[AllActive] [int] NOT NULL,
	[AllRegister] [int] NOT NULL,
	[AllRecharge] [decimal](18, 2) NOT NULL,
	[AllOutScore] [bigint] NOT NULL,
	[AllInScore] [bigint] NOT NULL,
 CONSTRAINT [PK_TempAndroidIOSData] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'查询编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'QueryNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'PlatformID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日下载' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'CurrentDownload'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排重下载' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'CurrentDownloadEx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日激活' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'CurrentActive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'CurrentRegister'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日充值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'CurrentRecharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输出比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'OutPercent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输出金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'OutRecharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日转出' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'CurrentOutScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日转入' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'CurrentInScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'全部激活' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'AllActive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'全部注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'AllRegister'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'全部充值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'AllRecharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'全部转出' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'AllOutScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'全部转入' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TempAndroidIOSData', @level2type=N'COLUMN',@level2name=N'AllInScore'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChannelPage](
	[PageIndex] [int] NOT NULL,
	[PageName] [nvarchar](20) NOT NULL,
	[ChannelType] [tinyint] NOT NULL,
	[ServiceRight] [int] NOT NULL,
	[PageLink] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_ChannelPage] PRIMARY KEY CLUSTERED 
(
	[PageIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelPage', @level2type=N'COLUMN',@level2name=N'PageIndex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelPage', @level2type=N'COLUMN',@level2name=N'PageName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelPage', @level2type=N'COLUMN',@level2name=N'ChannelType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelPage', @level2type=N'COLUMN',@level2name=N'ServiceRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面链接' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelPage', @level2type=N'COLUMN',@level2name=N'PageLink'