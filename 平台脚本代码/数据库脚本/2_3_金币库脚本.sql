USE [THTreasureDB]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LivcardAssociator](
	[CardID] [int] IDENTITY(1,1) NOT NULL,
	[SerialID] [nvarchar](31) NOT NULL,
	[Password] [nchar](32) NOT NULL,
	[BuildID] [int] NOT NULL,
	[CardTypeID] [int] NOT NULL,
	[CardPrice] [decimal](18, 2) NOT NULL,
	[Currency] [decimal](18, 2) NOT NULL,
	[Score] [bigint] NOT NULL,
	[ValidDate] [datetime] NOT NULL CONSTRAINT [DF_LivcardAssociator_ValidDate]  DEFAULT (getdate()+(180)),
	[BuildDate] [datetime] NOT NULL CONSTRAINT [DF_LivcardAssociator_BuildDate]  DEFAULT (getdate()),
	[ApplyDate] [datetime] NULL,
	[UseRange] [int] NOT NULL CONSTRAINT [DF_LivcardAssociator_Range]  DEFAULT ((0)),
	[SalesPerson] [nvarchar](31) NOT NULL CONSTRAINT [DF_LivcardAssociator_SalesPerson]  DEFAULT (''),
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_LivcardAssociator_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_LivcardAssociator] PRIMARY KEY CLUSTERED 
(
	[CardID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员卡索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'CardID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'卡号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'SerialID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生产批次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'BuildID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员卡类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'CardTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员卡价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'CardPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员卡货币数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'Currency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员卡金币数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'ValidDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生产日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'BuildDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'使用时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'ApplyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0:全部用户,1:新注册用户,2:第一次充值用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'UseRange'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'销售商' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'SalesPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁用标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardAssociator', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalSpreadInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RegisterGrantScore] [int] NOT NULL CONSTRAINT [DF_GlobalSpreadInfo_RegisterGrantScore]  DEFAULT ((0)),
	[PlayTimeCount] [int] NOT NULL CONSTRAINT [DF_GlobalSpreadInfo_PlayTimeCount]  DEFAULT ((0)),
	[PlayTimeGrantScore] [int] NOT NULL CONSTRAINT [DF_GlobalSpreadInfo_PlayTimeGrantScore]  DEFAULT ((0)),
	[FillGrantRate] [decimal](18, 2) NOT NULL CONSTRAINT [DF_GlobalSpreadInfo_FillGrantRate]  DEFAULT ((0)),
	[BalanceRate] [decimal](18, 2) NOT NULL CONSTRAINT [DF_GlobalSpreadInfo_BalanceRate]  DEFAULT ((0)),
	[MinBalanceScore] [int] NOT NULL CONSTRAINT [DF_GlobalSpreadInfo_MinBalanceScore]  DEFAULT ((0)),
 CONSTRAINT [PK_GlobalSpreadInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册时赠送金币数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalSpreadInfo', @level2type=N'COLUMN',@level2name=N'RegisterGrantScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线时长（单位：秒）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalSpreadInfo', @level2type=N'COLUMN',@level2name=N'PlayTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'根据在线时长赠送金币数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalSpreadInfo', @level2type=N'COLUMN',@level2name=N'PlayTimeGrantScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值赠送比率' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalSpreadInfo', @level2type=N'COLUMN',@level2name=N'FillGrantRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结算赠送比率' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalSpreadInfo', @level2type=N'COLUMN',@level2name=N'BalanceRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结算最小值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalSpreadInfo', @level2type=N'COLUMN',@level2name=N'MinBalanceScore'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameScoreInfo](
	[UserID] [int] NOT NULL,
	[Score] [bigint] NOT NULL CONSTRAINT [DF_GameScore_Score]  DEFAULT ((0)),
	[Revenue] [bigint] NOT NULL CONSTRAINT [DF_GameScoreInfo_GameTax]  DEFAULT ((0)),
	[InsureScore] [bigint] NOT NULL CONSTRAINT [DF_GameScoreInfo_InsureScore]  DEFAULT ((0)),
	[WinCount] [int] NOT NULL CONSTRAINT [DF_GameScore_WinCount]  DEFAULT ((0)),
	[LostCount] [int] NOT NULL CONSTRAINT [DF_GameScore_LostCount]  DEFAULT ((0)),
	[DrawCount] [int] NOT NULL CONSTRAINT [DF_GameScore_DrawCount]  DEFAULT ((0)),
	[FleeCount] [int] NOT NULL CONSTRAINT [DF_GameScore_FleeCount]  DEFAULT ((0)),
	[UserRight] [int] NOT NULL CONSTRAINT [DF_GameScoreInfo_UserRight]  DEFAULT ((0)),
	[MasterRight] [int] NOT NULL CONSTRAINT [DF_GameScoreInfo_MasterRight]  DEFAULT ((0)),
	[MasterOrder] [tinyint] NOT NULL CONSTRAINT [DF_GameScoreInfo_MasterOrder]  DEFAULT ((0)),
	[AllLogonTimes] [int] NOT NULL CONSTRAINT [DF_GameScore_AllLogonTimes]  DEFAULT ((0)),
	[PlayTimeCount] [int] NOT NULL CONSTRAINT [DF_GameScore_PlayTimeCount_1]  DEFAULT ((0)),
	[OnLineTimeCount] [int] NOT NULL CONSTRAINT [DF_GameScore_OnLineTimeCount]  DEFAULT ((0)),
	[LastLogonIP] [nvarchar](15) NOT NULL CONSTRAINT [DF_GameScoreInfo_LastLogonIP]  DEFAULT (N''),
	[LastLogonDate] [datetime] NOT NULL CONSTRAINT [DF_GameScore_LastLogonDate]  DEFAULT (getdate()),
	[LastLogonMachine] [nvarchar](32) NOT NULL CONSTRAINT [DF_GameScoreInfo_LastLogonMachine]  DEFAULT ('------------'),
	[RegisterIP] [nvarchar](15) NOT NULL CONSTRAINT [DF_GameScoreInfo_RegisterIP]  DEFAULT (N''),
	[RegisterDate] [datetime] NOT NULL CONSTRAINT [DF_GameScore_RegisterDate]  DEFAULT (getdate()),
	[RegisterMachine] [nvarchar](32) NOT NULL CONSTRAINT [DF_GameScoreInfo_RegisterMachine]  DEFAULT (N'------------'),
 CONSTRAINT [PK_GameScoreInfo_1] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户积分（货币）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏税收' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'Revenue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'InsureScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'胜局数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'WinCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输局数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'LostCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'和局数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'DrawCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'逃局数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'FleeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'UserRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'MasterRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理等级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'MasterOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'总登陆次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'AllLogonTimes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'PlayTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'OnLineTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上次登陆 IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'LastLogonIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上次登陆时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'LastLogonDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'LastLogonMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册 IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'RegisterIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'RegisterDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'RegisterMachine'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemStreamInfo](
	[DateID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[LogonCount] [int] NOT NULL CONSTRAINT [DF_TABLE1_LogonCount]  DEFAULT ((0)),
	[RegisterCount] [int] NOT NULL CONSTRAINT [DF_GameEnterInfo_LogonCount1]  DEFAULT ((0)),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_TABLE1_RecordDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_SystemStreamInfo] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[KindID] ASC,
	[ServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日期标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'DateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'LogonCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'RegisterCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordSpreadInfo](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Score] [bigint] NOT NULL,
	[TypeID] [int] NOT NULL CONSTRAINT [DF_RecordSpreadInfo_TypeID]  DEFAULT ((0)),
	[ChildrenID] [int] NOT NULL CONSTRAINT [DF_RecordSpreadInfo_ChildrenID]  DEFAULT ((0)),
	[InsureScore] [bigint] NOT NULL CONSTRAINT [DF_RecordSpreadInfo_InsureScore]  DEFAULT ((0)),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_RecordSpreadInfo_CollectDate]  DEFAULT (getdate()),
	[CollectNote] [nvarchar](128) NOT NULL CONSTRAINT [DF_RecordSpreadInfo_CollectNote]  DEFAULT (''),
 CONSTRAINT [PK_RecordSpreadInfo] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadInfo', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'推广积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadInfo', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadInfo', @level2type=N'COLUMN',@level2name=N'TypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'子类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadInfo', @level2type=N'COLUMN',@level2name=N'ChildrenID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadInfo', @level2type=N'COLUMN',@level2name=N'InsureScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收集日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadInfo', @level2type=N'COLUMN',@level2name=N'CollectNote'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordInsure](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[KindID] [int] NOT NULL CONSTRAINT [DF_RecordInsure_KindID]  DEFAULT ((0)),
	[ServerID] [int] NOT NULL CONSTRAINT [DF_RecordTreasure_ServerID]  DEFAULT ((0)),
	[SourceUserID] [int] NOT NULL CONSTRAINT [DF_RecordTreasure_SourceUserID]  DEFAULT ((0)),
	[SourceGold] [bigint] NOT NULL CONSTRAINT [DF_RecordTreasure_CurBankSource1_1]  DEFAULT ((0)),
	[SourceBank] [bigint] NOT NULL CONSTRAINT [DF_RecordTreasure_CurBankSource1]  DEFAULT ((0)),
	[TargetUserID] [int] NOT NULL CONSTRAINT [DF_RecordTreasure_TargetUserID]  DEFAULT ((0)),
	[TargetGold] [bigint] NOT NULL CONSTRAINT [DF_RecordTreasure_CurBankTarget1]  DEFAULT ((0)),
	[TargetBank] [bigint] NOT NULL CONSTRAINT [DF_RecordTreasure_SwapScore1]  DEFAULT ((0)),
	[SwapScore] [bigint] NOT NULL CONSTRAINT [DF_RecordTreasure_SwapScore]  DEFAULT ((0)),
	[Revenue] [bigint] NOT NULL CONSTRAINT [DF_RecordTreasure_Revenue]  DEFAULT ((0)),
	[IsGamePlaza] [tinyint] NOT NULL CONSTRAINT [DF_RecordInsure_IsGamePlaza]  DEFAULT ((0)),
	[TradeType] [tinyint] NOT NULL,
	[ClientIP] [nvarchar](15) NOT NULL CONSTRAINT [DF_RecordTreasure_ClientIPSource1]  DEFAULT ('000.000.000.000'),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_RecordTreasure_CollectDate]  DEFAULT (getdate()),
	[CollectNote] [nvarchar](63) NOT NULL CONSTRAINT [DF_RecordInsure_CollectNote]  DEFAULT (''),
 CONSTRAINT [PK_RecordInsure] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'源用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'SourceUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前金币数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'SourceGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前银行数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'SourceBank'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'目标用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'TargetUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前金币数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'TargetGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前银行数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'TargetBank'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流通金币数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'SwapScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'税收数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'Revenue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转账场所(0:大厅,1:网页)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'IsGamePlaza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易类别,存 1,取 2,转 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'TradeType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'连接地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordInsure', @level2type=N'COLUMN',@level2name=N'CollectNote'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordBuyMember](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[MemberOrder] [int] NOT NULL,
	[MemberMonths] [int] NOT NULL,
	[MemberPrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_RecordExchCurrency_Price]  DEFAULT ((0)),
	[Currency] [decimal](18, 2) NOT NULL CONSTRAINT [DF_RecordExchangeLog_ExchangeCurreny]  DEFAULT ((0)),
	[PresentScore] [bigint] NOT NULL CONSTRAINT [DF_RecordExchangeLog_ExchangeScroe]  DEFAULT ((0)),
	[BeforeCurrency] [decimal](18, 2) NOT NULL CONSTRAINT [DF_RecordExchangeLog_BeforeCurreny]  DEFAULT ((0)),
	[BeforeScore] [bigint] NOT NULL CONSTRAINT [DF_RecordExchangeLog_BeforeScore]  DEFAULT ((0)),
	[ClinetIP] [varchar](15) NOT NULL,
	[InputDate] [datetime] NOT NULL CONSTRAINT [DF_RecordExchangeLog_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RecordExchange] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBuyMember', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBuyMember', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'购买会员类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBuyMember', @level2type=N'COLUMN',@level2name=N'MemberOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'购买月数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBuyMember', @level2type=N'COLUMN',@level2name=N'MemberMonths'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员每月价格（单位：货币）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBuyMember', @level2type=N'COLUMN',@level2name=N'MemberPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'总花费货币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBuyMember', @level2type=N'COLUMN',@level2name=N'Currency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBuyMember', @level2type=N'COLUMN',@level2name=N'PresentScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'购买前货币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBuyMember', @level2type=N'COLUMN',@level2name=N'BeforeCurrency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'购买前金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBuyMember', @level2type=N'COLUMN',@level2name=N'BeforeScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户端IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBuyMember', @level2type=N'COLUMN',@level2name=N'ClinetIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBuyMember', @level2type=N'COLUMN',@level2name=N'InputDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameColumnItem](
	[SortID] [int] NOT NULL,
	[ColumnName] [nvarchar](15) NOT NULL,
	[ColumnWidth] [tinyint] NOT NULL,
	[DataDescribe] [tinyint] NOT NULL,
 CONSTRAINT [PK_GameColumnItem_SortID] PRIMARY KEY CLUSTERED 
(
	[SortID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排列标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameColumnItem', @level2type=N'COLUMN',@level2name=N'SortID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'列头名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameColumnItem', @level2type=N'COLUMN',@level2name=N'ColumnName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'列表宽度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameColumnItem', @level2type=N'COLUMN',@level2name=N'ColumnWidth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameColumnItem', @level2type=N'COLUMN',@level2name=N'DataDescribe'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnDouwanDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[OpenId] [nvarchar](100) NOT NULL,
	[ServerId] [nvarchar](100) NOT NULL CONSTRAINT [DF_ReturnDouwanDetailInfo_ServerId]  DEFAULT (''),
	[ServerName] [nvarchar](100) NOT NULL CONSTRAINT [DF_ReturnDouwanDetailInfo_ServerName]  DEFAULT (''),
	[RoleId] [nvarchar](100) NOT NULL CONSTRAINT [DF_ReturnDouwanDetailInfo_RoleId]  DEFAULT (''),
	[RoleName] [nvarchar](100) NOT NULL CONSTRAINT [DF_ReturnDouwanDetailInfo_RoleName]  DEFAULT (''),
	[OrderId] [nvarchar](100) NOT NULL CONSTRAINT [DF_ReturnDouwanDetailInfo_OrderId]  DEFAULT (''),
	[OrderStatus] [int] NOT NULL CONSTRAINT [DF_ReturnDouwanDetailInfo_OrderStatus]  DEFAULT (''),
	[PayType] [nvarchar](100) NOT NULL CONSTRAINT [DF_ReturnDouwanDetailInfo_PayType]  DEFAULT (''),
	[Amount] [decimal](18, 2) NOT NULL CONSTRAINT [DF_ReturnDouwanDetailInfo_Amount]  DEFAULT ((0)),
	[Remark] [nvarchar](100) NOT NULL CONSTRAINT [DF_ReturnDouwanDetailInfo_Remark]  DEFAULT (''),
	[CallBackInfo] [nvarchar](100) NOT NULL CONSTRAINT [DF_ReturnDouwanDetailInfo_CallBackInfo]  DEFAULT (''),
	[Sign] [nvarchar](32) NOT NULL CONSTRAINT [DF_ReturnDouwanDetailInfo_Sign]  DEFAULT (''),
	[MySign] [nvarchar](32) NOT NULL CONSTRAINT [DF_ReturnDouwanDetailInfo_MySign]  DEFAULT (''),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnDouwanDetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnDouwanDetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'''''' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnDouwanDetailInfo', @level2type=N'COLUMN',@level2name=N'ServerName'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameScoreLocker](
	[UserID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[EnterID] [int] NOT NULL,
	[EnterIP] [nvarchar](15) NOT NULL CONSTRAINT [DF_GameScoreLocker_EnterIP]  DEFAULT (N''),
	[EnterMachine] [nvarchar](32) NOT NULL CONSTRAINT [DF_GameScoreLocker_RegisterMachine]  DEFAULT (N''),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_GameScoreLocker_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_GameScoreLocker_UserID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进出索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'EnterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'EnterIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'EnterMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnYPDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[p1_MerId] [nvarchar](22) NOT NULL,
	[r0_Cmd] [nvarchar](40) NOT NULL CONSTRAINT [DF__ReturnYPD__r0_Cm__451F3D2B]  DEFAULT (N'Buy'),
	[r1_Code] [nvarchar](2) NOT NULL CONSTRAINT [DF__ReturnYPD__r1_Co__46136164]  DEFAULT ((1)),
	[r2_TrxId] [nvarchar](100) NOT NULL,
	[r3_Amt] [decimal](18, 2) NOT NULL,
	[r4_Cur] [nvarchar](20) NOT NULL CONSTRAINT [DF__ReturnYPD__r4_Cu__4707859D]  DEFAULT (N'RMB'),
	[r5_Pid] [nvarchar](40) NOT NULL,
	[r6_Order] [nvarchar](64) NOT NULL,
	[r7_Uid] [nvarchar](100) NOT NULL,
	[r8_MP] [nvarchar](400) NOT NULL,
	[r9_BType] [nchar](2) NOT NULL,
	[rb_BankId] [nvarchar](64) NOT NULL,
	[ro_BankOrderId] [nvarchar](128) NOT NULL,
	[rp_PayDate] [nvarchar](64) NOT NULL CONSTRAINT [DF__ReturnYPD__rp_Pa__47FBA9D6]  DEFAULT (getdate()),
	[rq_CardNo] [nvarchar](128) NOT NULL,
	[ru_Trxtime] [nvarchar](64) NOT NULL CONSTRAINT [DF__ReturnYPD__ru_Tr__48EFCE0F]  DEFAULT (getdate()),
	[hmac] [nchar](64) NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF__ReturnYPD__Colle__49E3F248]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnYPDetailInfo] PRIMARY KEY NONCLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'p1_MerId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'业务类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'r0_Cmd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付结果' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'r1_Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'易宝支付交易流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'r2_TrxId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'r3_Amt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易币种' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'r4_Cur'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'r5_Pid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'r6_Order'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'易宝支付会员ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'r7_Uid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' 商户扩展信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'r8_MP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易结果返回类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'r9_BType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'rb_BankId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'ro_BankOrderId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付成功时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'rp_PayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' 神州行充值卡序列号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'rq_CardNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' 交易结果通知时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'ru_Trxtime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签名数据' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'hmac'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnYPDetailInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalShareInfo](
	[ShareID] [int] NOT NULL,
	[ShareName] [nvarchar](32) NOT NULL,
	[ShareAlias] [nvarchar](32) NOT NULL,
	[ShareNote] [nvarchar](32) NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_GlobalShareInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_GlobalShareInfo] PRIMARY KEY CLUSTERED 
(
	[ShareID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalShareInfo', @level2type=N'COLUMN',@level2name=N'ShareID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalShareInfo', @level2type=N'COLUMN',@level2name=N'ShareName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务别名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalShareInfo', @level2type=N'COLUMN',@level2name=N'ShareAlias'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalShareInfo', @level2type=N'COLUMN',@level2name=N'ShareNote'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordWriteScoreError](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[UserScore] [bigint] NOT NULL,
	[Score] [bigint] NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_RecordA_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RecordA] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordWriteScoreError', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordWriteScoreError', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordWriteScoreError', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordWriteScoreError', @level2type=N'COLUMN',@level2name=N'UserScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输赢积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordWriteScoreError', @level2type=N'COLUMN',@level2name=N'Score'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameProperty](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](31) NOT NULL,
	[Cash] [decimal](18, 2) NOT NULL,
	[Gold] [bigint] NOT NULL,
	[Discount] [smallint] NOT NULL CONSTRAINT [DF_GameProperty_Discount]  DEFAULT ((90)),
	[IssueArea] [smallint] NOT NULL CONSTRAINT [DF_GameProperty_SellArea]  DEFAULT ((3)),
	[ServiceArea] [smallint] NOT NULL,
	[SendLoveLiness] [bigint] NOT NULL,
	[RecvLoveLiness] [bigint] NOT NULL,
	[RegulationsInfo] [nvarchar](255) NOT NULL CONSTRAINT [DF_GameProperty_RegulationsInfo]  DEFAULT (''),
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_GameProperty_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_GameProperty] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'道具标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'道具名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'道具价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'Cash'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'道具金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'Gold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员折扣' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'Discount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发行范围' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'IssueArea'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'使用范围' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'ServiceArea'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'增加魅力' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'SendLoveLiness'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'增加魅力' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'RecvLoveLiness'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'使用说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'RegulationsInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁止标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordUserInout](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[EnterTime] [datetime] NOT NULL CONSTRAINT [DF_RecordUserInout_EnterTime]  DEFAULT (getdate()),
	[EnterScore] [bigint] NOT NULL,
	[EnterGrade] [bigint] NOT NULL CONSTRAINT [DF_RecordUserInout_EnterGold]  DEFAULT ((0)),
	[EnterInsure] [bigint] NOT NULL CONSTRAINT [DF_RecordUserInout_EnterGold1]  DEFAULT ((0)),
	[EnterUserMedal] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_EnterUserMedal]  DEFAULT ((0)),
	[EnterLoveliness] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_EnterLoveliness]  DEFAULT ((0)),
	[EnterMachine] [nvarchar](33) NOT NULL CONSTRAINT [DF_RecordUserInout_EnterMachine]  DEFAULT (N''),
	[EnterClientIP] [nvarchar](15) NOT NULL,
	[LeaveTime] [datetime] NULL,
	[LeaveReason] [int] NULL,
	[LeaveMachine] [nvarchar](32) NULL,
	[LeaveClientIP] [nvarchar](15) NULL,
	[Score] [bigint] NOT NULL CONSTRAINT [DF_RecordUserInout_Score]  DEFAULT ((0)),
	[Grade] [bigint] NOT NULL CONSTRAINT [DF_RecordUserInout_Gold]  DEFAULT ((0)),
	[Insure] [bigint] NOT NULL CONSTRAINT [DF_RecordUserInout_Insure]  DEFAULT ((0)),
	[Revenue] [bigint] NOT NULL CONSTRAINT [DF_RecordUserInout_Revenue]  DEFAULT ((0)),
	[WinCount] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_WinCount]  DEFAULT ((0)),
	[LostCount] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_LostCount]  DEFAULT ((0)),
	[DrawCount] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_DrawCount]  DEFAULT ((0)),
	[FleeCount] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_FleeCount]  DEFAULT ((0)),
	[UserMedal] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_UserMedal]  DEFAULT ((0)),
	[LoveLiness] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_LoveLiness]  DEFAULT ((0)),
	[Experience] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_Experience]  DEFAULT ((0)),
	[PlayTimeCount] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_PlayTimeCount]  DEFAULT ((0)),
	[OnLineTimeCount] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_OnLineTimeCount]  DEFAULT ((0)),
 CONSTRAINT [PK_RecordUserInout_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'索引标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入成绩' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterGrade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入银行' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterInsure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入奖牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterUserMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入魅力' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterLoveliness'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'离开时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'LeaveTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'离开原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'LeaveReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'LeaveMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'LeaveClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'变更积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成绩变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'Grade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'Insure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'变更税收' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'Revenue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'胜局变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'WinCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输局变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'LostCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'和局变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'DrawCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'逃局变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'FleeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖牌数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'UserMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'魅力变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'LoveLiness'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'经验变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'Experience'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'PlayTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'OnLineTimeCount'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StreamScoreInfo](
	[DateID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[WinCount] [int] NOT NULL CONSTRAINT [DF_StreamScoreInfo_WinCount]  DEFAULT ((0)),
	[LostCount] [int] NOT NULL CONSTRAINT [DF_StreamScoreInfo_LostCount]  DEFAULT ((0)),
	[ReWinCount] [int] NOT NULL CONSTRAINT [DF_StreamScoreInfo_ReWinCount]  DEFAULT ((0)),
	[Revenue] [bigint] NOT NULL CONSTRAINT [DF_StreamScoreInfo_Revenue]  DEFAULT ((0)),
	[PlayTimeCount] [int] NOT NULL CONSTRAINT [DF_StreamScoreInfo_PlayTimeCount_1]  DEFAULT ((0)),
	[OnlineTimeCount] [int] NOT NULL,
	[FirstCollectDate] [datetime] NOT NULL CONSTRAINT [DF_StreamScoreInfo_FirstCollectDate]  DEFAULT (getdate()),
	[LastCollectDate] [datetime] NOT NULL CONSTRAINT [DF_StreamScoreInfo_LastCollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_StreamScoreInfo] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日期标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamScoreInfo', @level2type=N'COLUMN',@level2name=N'DateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamScoreInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'连胜局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamScoreInfo', @level2type=N'COLUMN',@level2name=N'ReWinCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'税收' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamScoreInfo', @level2type=N'COLUMN',@level2name=N'Revenue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏时长' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamScoreInfo', @level2type=N'COLUMN',@level2name=N'PlayTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线时长' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamScoreInfo', @level2type=N'COLUMN',@level2name=N'OnlineTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始统计时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamScoreInfo', @level2type=N'COLUMN',@level2name=N'FirstCollectDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后统计时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamScoreInfo', @level2type=N'COLUMN',@level2name=N'LastCollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OnLineOrder](
	[OnLineID] [int] IDENTITY(1,1) NOT NULL,
	[OperUserID] [int] NOT NULL,
	[ShareID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[Accounts] [nvarchar](31) NOT NULL,
	[OrderID] [nvarchar](32) NOT NULL,
	[OrderAmount] [decimal](18, 2) NOT NULL,
	[DiscountScale] [decimal](18, 2) NOT NULL CONSTRAINT [DF_OnLineOrder_DiscountScale]  DEFAULT ((0)),
	[PayAmount] [decimal](18, 2) NOT NULL,
	[Rate] [int] NOT NULL CONSTRAINT [DF_OnLineOrder_Rate]  DEFAULT ((1)),
	[CurrencyType] [tinyint] NOT NULL CONSTRAINT [DF_OnLineOrder_CurrencyType]  DEFAULT ((0)),
	[Currency] [decimal](18, 2) NOT NULL CONSTRAINT [DF_OnLineOrder_Currency]  DEFAULT ((0)),
	[OrderStatus] [tinyint] NOT NULL CONSTRAINT [DF_OnLineOrder_OrderStatus]  DEFAULT ((0)),
	[IPAddress] [nvarchar](15) NOT NULL,
	[ApplyDate] [datetime] NOT NULL CONSTRAINT [DF_OnLineOrder_ApplyDate]  DEFAULT (getdate()),
	[ProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_OnLineOrder_ProductID]  DEFAULT (''),
 CONSTRAINT [PK_OnLineOrder] PRIMARY KEY CLUSTERED 
(
	[OnLineID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'OnLineID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'OperUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'ShareID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'GameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'Accounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'OrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'OrderAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'折扣比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'DiscountScale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实付金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'PayAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货币类型 1:游戏豆 2:金币 3:礼包' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'CurrencyType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏豆数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'Currency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单状态  0:未付款;1:已付款待处理;2:处理完成' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'OrderStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'IPAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'ApplyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineOrder', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfineAddress](
	[AddrString] [nvarchar](15) NOT NULL,
	[EnjoinLogon] [bit] NOT NULL CONSTRAINT [DF_AddrConfineRule_EnjoinLogon]  DEFAULT ((0)),
	[EnjoinOverDate] [datetime] NOT NULL,
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'限制登陆' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineAddress', @level2type=N'COLUMN',@level2name=N'EnjoinLogon'
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
CREATE TABLE [dbo].[ShareDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[OperUserID] [int] NOT NULL CONSTRAINT [DF_ShareOLDetialInfo_OperUserID]  DEFAULT ((0)),
	[ShareID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[Accounts] [nvarchar](31) NOT NULL,
	[CardTypeID] [int] NOT NULL CONSTRAINT [DF_ShareDetailInfo_CardTypeID]  DEFAULT ((0)),
	[SerialID] [nvarchar](15) NOT NULL CONSTRAINT [DF_ShareOLDetialInfo_SerialID]  DEFAULT (''),
	[OrderID] [nvarchar](32) NOT NULL CONSTRAINT [DF_ShareDetialInfo_OrderID]  DEFAULT (''),
	[OrderAmount] [decimal](18, 2) NOT NULL CONSTRAINT [DF_ShareDetialInfo_OrderAmount]  DEFAULT ((0)),
	[DiscountScale] [decimal](18, 2) NOT NULL CONSTRAINT [DF_ShareOLDetialInfo_DiscountScale]  DEFAULT ((0)),
	[PayAmount] [decimal](18, 2) NOT NULL,
	[CurrencyType] [tinyint] NOT NULL CONSTRAINT [DF_ShareDetailInfo_CurrencyType]  DEFAULT ((0)),
	[Currency] [decimal](18, 2) NOT NULL CONSTRAINT [DF_ShareDetailInfo_Currency]  DEFAULT ((0)),
	[BeforeCurrency] [decimal](18, 2) NOT NULL CONSTRAINT [DF_ShareDetailInfo_BeforeCurrency]  DEFAULT ((0)),
	[IPAddress] [nvarchar](15) NOT NULL,
	[ApplyDate] [datetime] NOT NULL CONSTRAINT [DF_ShareOLDetialInfo_ApplyDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ShareOLDetialInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'OperUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'ShareID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'GameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'Accounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实卡类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'CardTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'OrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'OrderAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'折扣比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'DiscountScale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实付金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'PayAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货币类型 1:游戏豆 2:金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'CurrencyType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值货币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'Currency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'IPAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShareDetailInfo', @level2type=N'COLUMN',@level2name=N'ApplyDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserCurrencyInfo](
	[UserID] [int] NOT NULL,
	[Currency] [decimal](18, 2) NOT NULL CONSTRAINT [DF_UserWealthInfo_Currency]  DEFAULT ((0)),
 CONSTRAINT [PK_UserWealthInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserCurrencyInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户货币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserCurrencyInfo', @level2type=N'COLUMN',@level2name=N'Currency'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnVBDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[OperStationID] [int] NOT NULL CONSTRAINT [DF_ReturnVBDetailInfo_OperStationID]  DEFAULT ((0)),
	[Rtmd5] [nvarchar](32) NOT NULL,
	[Rtka] [nvarchar](15) NOT NULL,
	[Rtmi] [nvarchar](6) NOT NULL CONSTRAINT [DF_ReturnVBDetailInfo_rtmi]  DEFAULT (''),
	[Rtmz] [int] NOT NULL,
	[Rtlx] [int] NOT NULL,
	[Rtoid] [nvarchar](10) NOT NULL,
	[OrderID] [nvarchar](32) NOT NULL,
	[Rtuserid] [nvarchar](31) NOT NULL,
	[Rtcustom] [nvarchar](128) NOT NULL,
	[Rtflag] [int] NOT NULL,
	[EcryptStr] [nvarchar](1024) NOT NULL,
	[SignMsg] [nvarchar](32) NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnVBDetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnVBDetailInfo] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作站点' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'OperStationID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'V币服务器MD5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'Rtmd5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'V币号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'Rtka'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'V币密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'Rtmi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'面值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'Rtmz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'卡的类型(1:正式卡 2:测试卡 3 :促销卡)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'Rtlx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'盈华讯方服务器端订单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'Rtoid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'OrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户的用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'Rtuserid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户自己定义数据' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'Rtcustom'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返回状态(1:为正常发送回来,2:为补单发送回来)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'Rtflag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回传字符' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'EcryptStr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签名字符串' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVBDetailInfo', @level2type=N'COLUMN',@level2name=N'SignMsg'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordDrawScore](
	[DrawID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ChairID] [int] NOT NULL CONSTRAINT [DF_RecordDrawScore_ChairID]  DEFAULT ((0)),
	[Score] [bigint] NOT NULL,
	[Grade] [bigint] NOT NULL,
	[Revenue] [bigint] NOT NULL,
	[UserMedal] [int] NOT NULL CONSTRAINT [DF_RecordDrawScore_UserMedal]  DEFAULT ((0)),
	[PlayTimeCount] [int] NOT NULL CONSTRAINT [DF_RecordDrawScore_PlayTimeCount]  DEFAULT ((0)),
	[DBQuestID] [int] NOT NULL,
	[InoutIndex] [int] NOT NULL,
	[InsertTime] [datetime] NOT NULL CONSTRAINT [DF_RecordDrawScore_InsertTime]  DEFAULT (getdate())
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'局数标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'DrawID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'椅子号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'ChairID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户成绩' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'Grade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'税收数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'Revenue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户奖牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'UserMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏时长' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'PlayTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'请求标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'DBQuestID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进出索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'InoutIndex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'插入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'InsertTime'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalLivcard](
	[CardTypeID] [int] IDENTITY(1,1) NOT NULL,
	[CardName] [nvarchar](16) NOT NULL CONSTRAINT [DF_GlobalLivcard_CardName]  DEFAULT (''),
	[CardPrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_GlobalLivcard_CardPrice]  DEFAULT ((0)),
	[Currency] [decimal](18, 2) NOT NULL CONSTRAINT [DF_GlobalLivcard_CardCurrencyPirce]  DEFAULT ((0)),
	[Score] [bigint] NOT NULL CONSTRAINT [DF_GlobalLivcard_Score]  DEFAULT ((0)),
	[InputDate] [datetime] NOT NULL CONSTRAINT [DF_GlobalLivcard_GoldCount]  DEFAULT (getdate()),
 CONSTRAINT [PK_GlobalLivcard] PRIMARY KEY CLUSTERED 
(
	[CardTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实卡类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalLivcard', @level2type=N'COLUMN',@level2name=N'CardTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实卡名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalLivcard', @level2type=N'COLUMN',@level2name=N'CardName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实卡价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalLivcard', @level2type=N'COLUMN',@level2name=N'CardPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送货币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalLivcard', @level2type=N'COLUMN',@level2name=N'Currency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalLivcard', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalLivcard', @level2type=N'COLUMN',@level2name=N'InputDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AndroidManager](
	[UserID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[MinPlayDraw] [int] NOT NULL CONSTRAINT [DF_AndroidManager_MinPlayDraw]  DEFAULT ((0)),
	[MaxPlayDraw] [int] NOT NULL CONSTRAINT [DF_AndroidManager_MaxPlayDraw]  DEFAULT ((0)),
	[MinTakeScore] [bigint] NOT NULL CONSTRAINT [DF_AndroidManager_MinTakeScore]  DEFAULT ((0)),
	[MaxTakeScore] [bigint] NOT NULL CONSTRAINT [DF_AndroidManager_MaxTakeScore]  DEFAULT ((0)),
	[MinReposeTime] [int] NOT NULL CONSTRAINT [DF_AndroidManager_MinReposeTime]  DEFAULT ((0)),
	[MaxReposeTime] [int] NOT NULL CONSTRAINT [DF_AndroidManager_MaxReposeTime]  DEFAULT ((0)),
	[ServiceTime] [int] NOT NULL CONSTRAINT [DF_AndroidManager_ServiceTime]  DEFAULT ((0)),
	[ServiceGender] [int] NOT NULL CONSTRAINT [DF_AndroidManager_ServiceGender]  DEFAULT ((0)),
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_AndroidManager_Nullity]  DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_AndroidManager_CreateDate]  DEFAULT (getdate()),
	[AndroidNote] [nvarchar](128) NOT NULL CONSTRAINT [DF_AndroidManager_AndroidNote]  DEFAULT (N''),
 CONSTRAINT [PK_AndroidManager_UserID_ServerID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[ServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidManager', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidManager', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最少局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidManager', @level2type=N'COLUMN',@level2name=N'MinPlayDraw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidManager', @level2type=N'COLUMN',@level2name=N'MaxPlayDraw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最少分数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidManager', @level2type=N'COLUMN',@level2name=N'MinTakeScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最高分数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidManager', @level2type=N'COLUMN',@level2name=N'MaxTakeScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最少休息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidManager', @level2type=N'COLUMN',@level2name=N'MinReposeTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大休息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidManager', @level2type=N'COLUMN',@level2name=N'MaxReposeTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidManager', @level2type=N'COLUMN',@level2name=N'ServiceGender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁止标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidManager', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AndroidManager', @level2type=N'COLUMN',@level2name=N'AndroidNote'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordLogonError](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[KindID] [int] NOT NULL CONSTRAINT [DF_RecordLogonError_KindID]  DEFAULT ((0)),
	[ServerID] [int] NOT NULL CONSTRAINT [DF_RecordLogonError_ServerID]  DEFAULT ((0)),
	[Score] [bigint] NOT NULL CONSTRAINT [DF_RecordLogonError_Score]  DEFAULT ((0)),
	[InsureScore] [bigint] NOT NULL CONSTRAINT [DF_RecordLogonError_InsureScore]  DEFAULT ((0)),
	[LogonIP] [nvarchar](15) NOT NULL CONSTRAINT [DF_RecordLogonError_LogonIP]  DEFAULT (N'000.000.000.000'),
	[LogonMachine] [nvarchar](32) NOT NULL CONSTRAINT [DF_RecordLogonError_MachineID]  DEFAULT (''),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_RecordLogonError_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RecordLogonError] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnKQDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[MerchantAcctID] [nvarchar](32) NOT NULL,
	[Version] [nvarchar](10) NOT NULL,
	[Language] [int] NOT NULL,
	[SignType] [int] NOT NULL CONSTRAINT [DF_ReturnKQInfo_SignType]  DEFAULT ((1)),
	[PayType] [nvarchar](16) NOT NULL CONSTRAINT [DF_ReturnKQInfo_PayType]  DEFAULT ((0)),
	[BankID] [nvarchar](16) NOT NULL,
	[OrderID] [nvarchar](32) NOT NULL,
	[OrderTime] [datetime] NOT NULL CONSTRAINT [DF_ReturnKQInfo_OrderTime]  DEFAULT (getdate()),
	[OrderAmount] [decimal](18, 2) NOT NULL CONSTRAINT [DF_ReturnKQInfo_OrderAmount]  DEFAULT ((0)),
	[DealID] [nvarchar](32) NOT NULL,
	[BankDealID] [nvarchar](32) NOT NULL,
	[DealTime] [datetime] NOT NULL,
	[PayAmount] [decimal](18, 2) NOT NULL CONSTRAINT [DF_ReturnKQInfo_PayAmount]  DEFAULT ((0)),
	[Fee] [decimal](18, 3) NOT NULL CONSTRAINT [DF_ReturnKQInfo_Fee]  DEFAULT ((0)),
	[PayResult] [nvarchar](32) NOT NULL,
	[ErrCode] [nvarchar](32) NOT NULL CONSTRAINT [DF_ReturnKQDetailInfo_ErrCode]  DEFAULT (''),
	[SignMsg] [nvarchar](32) NOT NULL,
	[Ext1] [nvarchar](128) NOT NULL CONSTRAINT [DF_ReturnKQInfo_Ext1]  DEFAULT (N''),
	[Ext2] [nvarchar](128) NOT NULL CONSTRAINT [DF_ReturnKQInfo_Ext2]  DEFAULT (N''),
	[CardNumber] [nvarchar](30) NOT NULL CONSTRAINT [DF_ReturnKQDetailInfo_CardNumber]  DEFAULT (''),
	[CardPwd] [nvarchar](30) NOT NULL CONSTRAINT [DF_ReturnKQDetailInfo_CardPwd]  DEFAULT (''),
	[BossType] [nvarchar](2) NOT NULL CONSTRAINT [DF_ReturnKQDetailInfo_BossType]  DEFAULT (''),
	[ReceiveBossType] [nvarchar](2) NOT NULL CONSTRAINT [DF_ReturnKQDetailInfo_ReceiveBossType]  DEFAULT (''),
	[ReceiverAcctId] [nvarchar](32) NOT NULL CONSTRAINT [DF_ReturnKQDetailInfo_ReceiverAcctId]  DEFAULT (''),
	[PayDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnKQInfo_PayDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnKQDetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收款帐号(人民币)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'MerchantAcctID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'快钱版本' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'Version'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'网关页面语言类别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'Language'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签名类别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'SignType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'PayType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'BankID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'OrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'OrderTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单金额(元)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'OrderAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'快钱交易号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'DealID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行交易号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'BankDealID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'快钱交易时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'DealTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单实际支付金额(元)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'PayAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'快钱收取商户的手续费(元)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'Fee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付结果  10:支付成功; 11:支付失败' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'PayResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'错误代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'ErrCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签名字符串' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'SignMsg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'Ext1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'Ext2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付卡号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'CardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付卡密' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'CardPwd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付类型(只适合充值卡)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'BossType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实际支付类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'ReceiveBossType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实际收款账户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'ReceiverAcctId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKQDetailInfo', @level2type=N'COLUMN',@level2name=N'PayDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Return91DetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[ConsumeStreamId] [nvarchar](50) NOT NULL,
	[OrderID] [nvarchar](32) NOT NULL,
	[Uin] [int] NOT NULL,
	[GoodsID] [nvarchar](50) NOT NULL,
	[GoodsInfo] [nvarchar](100) NOT NULL,
	[GoodsCount] [int] NOT NULL,
	[OriginalMoney] [decimal](18, 2) NOT NULL,
	[OrderMoney] [decimal](18, 2) NOT NULL,
	[Note] [nvarchar](100) NOT NULL,
	[PayStatus] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[Sign] [nvarchar](32) NOT NULL,
	[MySign] [nvarchar](32) NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_Return91DetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_Return91DetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnAppDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL CONSTRAINT [DF_ReturnAppDetailInfo_UserID]  DEFAULT ((0)),
	[OrderID] [nvarchar](32) NOT NULL CONSTRAINT [DF_ReturnAppDetailInfo_OrderID]  DEFAULT (''),
	[PayAmount] [decimal](18, 2) NOT NULL CONSTRAINT [DF_ReturnAppDetailInfo_PayAmount]  DEFAULT ((0)),
	[Status] [int] NOT NULL,
	[quantity] [int] NOT NULL CONSTRAINT [DF_ReturnAppDetailInfo_quantity]  DEFAULT ((0)),
	[product_id] [nvarchar](50) NULL,
	[transaction_id] [nvarchar](50) NULL,
	[purchase_date] [nvarchar](50) NULL,
	[original_transaction_id] [nvarchar](50) NULL,
	[original_purchase_date] [nvarchar](50) NULL,
	[app_item_id] [nvarchar](50) NULL,
	[version_external_identifier] [nvarchar](50) NULL,
	[bid] [nvarchar](50) NULL,
	[bvrs] [nvarchar](50) NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnAppDetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnAppDetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StreamPlayPresent](
	[DateID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[PresentCount] [int] NOT NULL CONSTRAINT [DF_StreamPlayPresent_PresentCount]  DEFAULT ((0)),
	[PresentScore] [int] NOT NULL CONSTRAINT [DF_StreamPlayPresent_PlayPresnet]  DEFAULT ((0)),
	[PlayTimeCount] [int] NOT NULL CONSTRAINT [DF_StreamPlayPresent_PlayTimeCount]  DEFAULT ((0)),
	[OnLineTimeCount] [int] NOT NULL CONSTRAINT [DF_StreamPlayPresent_OnLineTimeCount]  DEFAULT ((0)),
	[FirstDate] [datetime] NOT NULL CONSTRAINT [DF_StreamPlayPresent_FirstDate]  DEFAULT (getdate()),
	[LastDate] [datetime] NOT NULL CONSTRAINT [DF_StreamPlayPresent_LastDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_StreamPlayPresent] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'时间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamPlayPresent', @level2type=N'COLUMN',@level2name=N'DateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamPlayPresent', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamPlayPresent', @level2type=N'COLUMN',@level2name=N'PresentCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏泡分总数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamPlayPresent', @level2type=N'COLUMN',@level2name=N'PresentScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏时长' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamPlayPresent', @level2type=N'COLUMN',@level2name=N'PlayTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线时长' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamPlayPresent', @level2type=N'COLUMN',@level2name=N'OnLineTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始统计时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamPlayPresent', @level2type=N'COLUMN',@level2name=N'FirstDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后统计时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamPlayPresent', @level2type=N'COLUMN',@level2name=N'LastDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalAppInfo](
	[AppID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [nvarchar](100) NOT NULL CONSTRAINT [DF_GlobalAppInfo_ProductID]  DEFAULT (''),
	[ProductName] [nvarchar](100) NOT NULL CONSTRAINT [DF_GlobalAppInfo_ProductName]  DEFAULT (''),
	[Description] [nvarchar](100) NOT NULL CONSTRAINT [DF_GlobalAppInfo_Description]  DEFAULT (''),
	[Price] [decimal](18, 2) NOT NULL CONSTRAINT [DF_GlobalAppInfo_Price]  DEFAULT ((0)),
	[TagID] [int] NOT NULL CONSTRAINT [DF_GlobalAppInfo_TagID]  DEFAULT ((0)),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_GlobalAppInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_GlobalAppInfo] PRIMARY KEY CLUSTERED 
(
	[AppID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalAppInfo', @level2type=N'COLUMN',@level2name=N'AppID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalAppInfo', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalAppInfo', @level2type=N'COLUMN',@level2name=N'ProductName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalAppInfo', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalAppInfo', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品标识(1:手机使用,2:PAD使用)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalAppInfo', @level2type=N'COLUMN',@level2name=N'TagID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalAppInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfineMachine](
	[MachineSerial] [nvarchar](32) NOT NULL,
	[EnjoinLogon] [bit] NOT NULL CONSTRAINT [DF_MachineConfineRule_EnjoinLogon]  DEFAULT ((0)),
	[EnjoinRegister] [bit] NOT NULL CONSTRAINT [DF_MachineConfineRule_EnjoinRegister]  DEFAULT ((0)),
	[EnjoinOverDate] [datetime] NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_MachineConfineRule_CollectDate]  DEFAULT (getdate()),
	[CollectNote] [nvarchar](32) NOT NULL CONSTRAINT [DF_MachineConfineRule_CollectNote]  DEFAULT (''),
 CONSTRAINT [PK_MachineConfineRule_MachineSerial] PRIMARY KEY CLUSTERED 
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
CREATE TABLE [dbo].[RecordMachinePresent](
	[DateID] [int] NOT NULL,
	[MachineID] [nvarchar](32) NOT NULL,
	[PresentGold] [bigint] NOT NULL,
	[PresentCount] [int] NOT NULL,
	[UserIDString] [nvarchar](512) NOT NULL,
	[FirstGrantDate] [datetime] NOT NULL CONSTRAINT [DF_RecordMachinePresent_FirstGrantDate]  DEFAULT (getdate()),
	[LastGrantDate] [datetime] NOT NULL CONSTRAINT [DF_RecordMachinePresent_LastGrantDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RecordMachinePresent] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[MachineID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日期标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordMachinePresent', @level2type=N'COLUMN',@level2name=N'DateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机器码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordMachinePresent', @level2type=N'COLUMN',@level2name=N'MachineID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordMachinePresent', @level2type=N'COLUMN',@level2name=N'PresentGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordMachinePresent', @level2type=N'COLUMN',@level2name=N'PresentCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送ID串' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordMachinePresent', @level2type=N'COLUMN',@level2name=N'UserIDString'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始赠送时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordMachinePresent', @level2type=N'COLUMN',@level2name=N'FirstGrantDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后赠送时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordMachinePresent', @level2type=N'COLUMN',@level2name=N'LastGrantDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordCurrencyChange](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeCurrency] [decimal](18, 2) NOT NULL,
	[ChangeType] [tinyint] NOT NULL CONSTRAINT [DF_RecordCurrencyChange_ChangeType]  DEFAULT ((0)),
	[BeforeCurrency] [decimal](18, 2) NOT NULL,
	[AfterCurrency] [decimal](18, 2) NOT NULL,
	[ClinetIP] [varchar](15) NOT NULL,
	[InputDate] [datetime] NOT NULL CONSTRAINT [DF_RecordCurrencyChange_InputDate]  DEFAULT (getdate()),
	[Remark] [nvarchar](200) NULL,
 CONSTRAINT [PK_RecordCurrencyChange] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordCurrencyChange', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordCurrencyChange', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货币变更数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordCurrencyChange', @level2type=N'COLUMN',@level2name=N'ChangeCurrency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'变更类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordCurrencyChange', @level2type=N'COLUMN',@level2name=N'ChangeType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'变更前货币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordCurrencyChange', @level2type=N'COLUMN',@level2name=N'BeforeCurrency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'变更后货币数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordCurrencyChange', @level2type=N'COLUMN',@level2name=N'AfterCurrency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'变更IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordCurrencyChange', @level2type=N'COLUMN',@level2name=N'ClinetIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'变更时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordCurrencyChange', @level2type=N'COLUMN',@level2name=N'InputDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordCurrencyChange', @level2type=N'COLUMN',@level2name=N'Remark'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LivcardBuildStream](
	[BuildID] [int] IDENTITY(1,1) NOT NULL,
	[AdminName] [nvarchar](31) NOT NULL CONSTRAINT [DF_LivcardBuildStream_AdminName]  DEFAULT (''),
	[CardTypeID] [int] NOT NULL,
	[CardPrice] [decimal](18, 2) NOT NULL,
	[Currency] [decimal](18, 2) NOT NULL,
	[Score] [bigint] NOT NULL,
	[BuildCount] [int] NOT NULL,
	[BuildAddr] [nvarchar](15) NOT NULL,
	[BuildDate] [datetime] NOT NULL CONSTRAINT [DF_LivcardBuildStream_BuildDate]  DEFAULT (getdate()),
	[DownLoadCount] [int] NOT NULL CONSTRAINT [DF_LivcardBuildStream_DownLoadCount]  DEFAULT ((0)),
	[NoteInfo] [nvarchar](128) NOT NULL CONSTRAINT [DF_LivcardBuildStream_NoteInfo]  DEFAULT (''),
	[BuildCardPacket] [image] NOT NULL CONSTRAINT [DF_LivcardBuildStream_BuildCardPacket]  DEFAULT (''),
 CONSTRAINT [PK_LivcardBuildStream] PRIMARY KEY CLUSTERED 
(
	[BuildID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生产批次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardBuildStream', @level2type=N'COLUMN',@level2name=N'BuildID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardBuildStream', @level2type=N'COLUMN',@level2name=N'AdminName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'卡类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardBuildStream', @level2type=N'COLUMN',@level2name=N'CardTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'卡价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardBuildStream', @level2type=N'COLUMN',@level2name=N'CardPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'卡货币数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardBuildStream', @level2type=N'COLUMN',@level2name=N'Currency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'卡金币数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardBuildStream', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生产数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardBuildStream', @level2type=N'COLUMN',@level2name=N'BuildCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生产地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardBuildStream', @level2type=N'COLUMN',@level2name=N'BuildAddr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生产日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardBuildStream', @level2type=N'COLUMN',@level2name=N'BuildDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下载次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardBuildStream', @level2type=N'COLUMN',@level2name=N'DownLoadCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardBuildStream', @level2type=N'COLUMN',@level2name=N'NoteInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员卡数据' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LivcardBuildStream', @level2type=N'COLUMN',@level2name=N'BuildCardPacket'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StreamShareInfo](
	[DateID] [int] NOT NULL,
	[ShareID] [int] NOT NULL,
	[ShareTotals] [int] NOT NULL CONSTRAINT [DF_StreamShareInfo_ShareTotals]  DEFAULT ((0)),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_StreamShareInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_StreamShareInfo] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[ShareID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MemberType](
	[MemberOrder] [tinyint] NOT NULL,
	[MemberName] [nvarchar](50) NOT NULL CONSTRAINT [DF_MemberInfo_CardName]  DEFAULT (''),
	[MemberPrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_MemberInfo_CardPrice]  DEFAULT ((0)),
	[PresentScore] [int] NOT NULL,
	[UserRight] [int] NOT NULL CONSTRAINT [DF_MemberCard_UserRight]  DEFAULT ((0)),
 CONSTRAINT [PK_MemberInfo] PRIMARY KEY CLUSTERED 
(
	[MemberOrder] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员等级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MemberType', @level2type=N'COLUMN',@level2name=N'MemberOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MemberType', @level2type=N'COLUMN',@level2name=N'MemberName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员每月价格（单位：货币）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MemberType', @level2type=N'COLUMN',@level2name=N'MemberPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'购买单个赠送游戏币数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MemberType', @level2type=N'COLUMN',@level2name=N'PresentScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MemberType', @level2type=N'COLUMN',@level2name=N'UserRight'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnDayDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [nvarchar](32) NOT NULL CONSTRAINT [DF_ReturnDayDetailInfo_OrderID]  DEFAULT (''),
	[MerID] [nvarchar](32) NOT NULL CONSTRAINT [DF_ReturnDayDetailInfo_MerID]  DEFAULT (''),
	[PayMoney] [decimal](18, 0) NOT NULL CONSTRAINT [DF_ReturnDayDetailInfo_PayMoney]  DEFAULT ((0)),
	[UserName] [nvarchar](16) NOT NULL CONSTRAINT [DF_ReturnDayDetailInfo_UserName]  DEFAULT (''),
	[PayType] [int] NOT NULL CONSTRAINT [DF_ReturnDayDetailInfo_PayType]  DEFAULT ((0)),
	[Status] [nvarchar](5) NOT NULL CONSTRAINT [DF_ReturnDayDetailInfo_Status]  DEFAULT (''),
	[Sign] [nvarchar](32) NOT NULL,
	[InputDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnDayInfo_InputDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnDayInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnDayDetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnDayDetailInfo', @level2type=N'COLUMN',@level2name=N'OrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnDayDetailInfo', @level2type=N'COLUMN',@level2name=N'MerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnDayDetailInfo', @level2type=N'COLUMN',@level2name=N'PayMoney'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnDayDetailInfo', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付类型（1：网银支付 ）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnDayDetailInfo', @level2type=N'COLUMN',@level2name=N'PayType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnDayDetailInfo', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnDayDetailInfo', @level2type=N'COLUMN',@level2name=N'Sign'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnDayDetailInfo', @level2type=N'COLUMN',@level2name=N'InputDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordDrawInfo](
	[DrawID] [int] IDENTITY(1,1) NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[TableID] [int] NOT NULL,
	[UserCount] [int] NOT NULL,
	[AndroidCount] [int] NOT NULL,
	[Waste] [bigint] NOT NULL,
	[Revenue] [bigint] NOT NULL,
	[UserMedal] [int] NOT NULL CONSTRAINT [DF_RecordDrawInfo_UserMedal]  DEFAULT ((0)),
	[StartTime] [datetime] NOT NULL,
	[ConcludeTime] [datetime] NOT NULL,
	[InsertTime] [datetime] NOT NULL CONSTRAINT [DF_RecordDrawInfo_InsertTime]  DEFAULT (getdate()),
	[DrawCourse] [image] NULL,
 CONSTRAINT [PK_RecordDrawInfo_DrawID] PRIMARY KEY CLUSTERED 
(
	[DrawID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'局数标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'DrawID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'桌子号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'TableID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'UserCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机器数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'AndroidCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'损耗数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'Waste'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'税收数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'Revenue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户奖牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'UserMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'StartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'ConcludeTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'插入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'InsertTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏过程' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'DrawCourse'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackageConfig](
	[GoodsID] [int] NOT NULL,
	[GoodsName] [nvarchar](31) NOT NULL,
	[GoodsType] [tinyint] NOT NULL CONSTRAINT [DF_PackageConfig_Type]  DEFAULT ((0)),
	[GoodsPrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_PackageConfig_Cash]  DEFAULT ((0)),
	[RewardScore] [bigint] NOT NULL CONSTRAINT [DF_PackageConfig_RewardScore]  DEFAULT ((0)),
	[RewardExcharge] [int] NOT NULL CONSTRAINT [DF_PackageConfig_RewardExcharge]  DEFAULT ((0)),
	[Storage] [int] NOT NULL CONSTRAINT [DF_PackageConfig_Count]  DEFAULT ((0)),
	[Probability] [int] NOT NULL CONSTRAINT [DF_PackageConfig_Probability]  DEFAULT ((0)),
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_PackageConfig_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_PackageConfig_1] PRIMARY KEY CLUSTERED 
(
	[GoodsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageConfig', @level2type=N'COLUMN',@level2name=N'GoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageConfig', @level2type=N'COLUMN',@level2name=N'GoodsName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品类型 0x01:游戏掉落 0x02:奖励金币 0x04:奖励充值卡' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageConfig', @level2type=N'COLUMN',@level2name=N'GoodsType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageConfig', @level2type=N'COLUMN',@level2name=N'GoodsPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageConfig', @level2type=N'COLUMN',@level2name=N'RewardScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励充值卡' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageConfig', @level2type=N'COLUMN',@level2name=N'RewardExcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'库存数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageConfig', @level2type=N'COLUMN',@level2name=N'Storage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'中奖机率' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageConfig', @level2type=N'COLUMN',@level2name=N'Probability'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁止标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageConfig', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackageInfo](
	[UserID] [int] NOT NULL,
	[GoodsID] [int] NOT NULL,
	[GoodsCount] [int] NOT NULL,
	[LuckyGoodsID] [int] NOT NULL CONSTRAINT [DF_PackageInfo_Lucky]  DEFAULT ((0)),
 CONSTRAINT [PK_PackageInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[GoodsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageInfo', @level2type=N'COLUMN',@level2name=N'GoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageInfo', @level2type=N'COLUMN',@level2name=N'GoodsCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'中奖物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PackageInfo', @level2type=N'COLUMN',@level2name=N'LuckyGoodsID'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordPackageInfo](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[GoodsID] [int] NOT NULL,
	[OperateType] [tinyint] NOT NULL,
	[OperateDate] [datetime] NOT NULL CONSTRAINT [DF_RecordPackageInfo_OperateDate]  DEFAULT (getdate()),
	[LuckyGoodsID] [int] NOT NULL,
 CONSTRAINT [PK_RecordPackageInfo] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPackageInfo', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPackageInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPackageInfo', @level2type=N'COLUMN',@level2name=N'GoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPackageInfo', @level2type=N'COLUMN',@level2name=N'OperateType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPackageInfo', @level2type=N'COLUMN',@level2name=N'OperateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'中奖物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPackageInfo', @level2type=N'COLUMN',@level2name=N'LuckyGoodsID'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordExchangeReward](
	[RewardID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[GoodsID] [int] NOT NULL,
	[MobilePhone] [nvarchar](11) NOT NULL,
	[ExchangeDate] [datetime] NOT NULL CONSTRAINT [DF_RecordExchangeReward_ExchangeDate]  DEFAULT (getdate()),
	[Success] [tinyint] NOT NULL CONSTRAINT [DF_RecordExchangeReward_Success]  DEFAULT ((0)),
	[SuccesseDate] [datetime] NOT NULL CONSTRAINT [DF_RecordExchangeReward_SuccesseDate]  DEFAULT (getdate()),
	[RewardNote] [nvarchar](256) NOT NULL CONSTRAINT [DF_RecordExchangeReward_RewardNote]  DEFAULT (N''),
 CONSTRAINT [PK_RecordExchangeReward] PRIMARY KEY CLUSTERED 
(
	[RewardID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordExchangeReward', @level2type=N'COLUMN',@level2name=N'RewardID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordExchangeReward', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordExchangeReward', @level2type=N'COLUMN',@level2name=N'GoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordExchangeReward', @level2type=N'COLUMN',@level2name=N'MobilePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordExchangeReward', @level2type=N'COLUMN',@level2name=N'ExchangeDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发放标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordExchangeReward', @level2type=N'COLUMN',@level2name=N'Success'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发放日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordExchangeReward', @level2type=N'COLUMN',@level2name=N'SuccesseDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordExchangeReward', @level2type=N'COLUMN',@level2name=N'RewardNote'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnZFBDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[out_trade_no] [nvarchar](64) NOT NULL,
	[subject] [nvarchar](128) NOT NULL,
	[payment_type] [nvarchar](4) NOT NULL,
	[trade_no] [nvarchar](64) NOT NULL,
	[trade_status] [nvarchar](14) NOT NULL,
	[seller_id] [nvarchar](30) NOT NULL,
	[seller_email] [nvarchar](100) NOT NULL,
	[buyer_id] [nvarchar](30) NOT NULL,
	[buyer_email] [nvarchar](100) NOT NULL,
	[total_fee] [decimal](18, 2) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](18, 2) NOT NULL,
	[body] [nvarchar](512) NOT NULL,
	[gmt_create] [datetime] NOT NULL,
	[gmt_payment] [datetime] NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnZFBDetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnZFBDetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'out_trade_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'subject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'payment_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付宝交易号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'trade_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'trade_status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'卖家支付宝用户号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'seller_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'卖家支付宝账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'seller_email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'买家支付宝用户号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'buyer_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'买家支付宝账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'buyer_email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'total_fee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'购买数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品单价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'body'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'gmt_create'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易付款时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'gmt_payment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnZFBDetailInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnWXDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[out_trade_no] [nvarchar](32) NOT NULL,
	[appid] [nvarchar](32) NOT NULL,
	[mch_id] [nvarchar](32) NOT NULL,
	[nonce_str] [nvarchar](32) NOT NULL,
	[sign] [nvarchar](32) NOT NULL,
	[result_code] [nvarchar](16) NOT NULL,
	[openid] [nvarchar](128) NOT NULL,
	[trade_type] [nvarchar](16) NOT NULL,
	[bank_type] [nvarchar](16) NOT NULL,
	[total_fee] [decimal](18, 2) NOT NULL,
	[fee_type] [nvarchar](8) NOT NULL,
	[cash_fee] [decimal](18, 2) NOT NULL,
	[cash_fee_type] [nvarchar](16) NOT NULL,
	[transaction_id] [nvarchar](32) NOT NULL,
	[time_end] [nvarchar](32) NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnWXDetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnWXDetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'out_trade_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应用ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'appid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'mch_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'随机字符串' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'nonce_str'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'sign'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'业务结果' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'result_code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'openid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'trade_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'付款银行' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'bank_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'总金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'total_fee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货币种类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'fee_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'现金支付金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'cash_fee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'现金支付货币类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'cash_fee_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'微信支付订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'transaction_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付完成时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'time_end'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWXDetailInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaxWinScore](
	[UserID] [int] NOT NULL,
	[MaxWinScore] [bigint] NOT NULL CONSTRAINT [DF_MaxWinScore_MaxWinScore]  DEFAULT ((0)),
	[MaxWinScoreEx] [bigint] NOT NULL CONSTRAINT [DF_MaxWinScore_MaxWinScoreEx]  DEFAULT ((0)),
	[MaxWinScoreExDate] [datetime] NOT NULL CONSTRAINT [DF_MaxWinScore_MaxWinScoreExDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_MaxWinScore] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MaxWinScore', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大赢钱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MaxWinScore', @level2type=N'COLUMN',@level2name=N'MaxWinScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附加最大赢钱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MaxWinScore', @level2type=N'COLUMN',@level2name=N'MaxWinScoreEx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附加日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MaxWinScore', @level2type=N'COLUMN',@level2name=N'MaxWinScoreExDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordPayGuide](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[SourceUserID] [int] NOT NULL,
	[SourceScore] [bigint] NOT NULL,
	[SourceInsure] [bigint] NOT NULL,
	[TargetUserID] [int] NOT NULL,
	[TargetScore] [bigint] NOT NULL,
	[TargetInsure] [bigint] NOT NULL,
	[GuideScore] [bigint] NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_RecordPayGuide_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RecordPayGuide] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPayGuide', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发起用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPayGuide', @level2type=N'COLUMN',@level2name=N'SourceUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPayGuide', @level2type=N'COLUMN',@level2name=N'SourceScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户银行' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPayGuide', @level2type=N'COLUMN',@level2name=N'SourceInsure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'目标用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPayGuide', @level2type=N'COLUMN',@level2name=N'TargetUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPayGuide', @level2type=N'COLUMN',@level2name=N'TargetScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户银行' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPayGuide', @level2type=N'COLUMN',@level2name=N'TargetInsure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'指导费用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPayGuide', @level2type=N'COLUMN',@level2name=N'GuideScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPayGuide', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordPackageControl](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[MasterID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[LuckyGoodsID] [int] NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_RecordPackageControl_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RecordPackageControl] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPackageControl', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPackageControl', @level2type=N'COLUMN',@level2name=N'MasterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPackageControl', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'中奖物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPackageControl', @level2type=N'COLUMN',@level2name=N'LuckyGoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPackageControl', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordActivityReward](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[ActivityID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[GoodsID] [int] NOT NULL,
	[GoodsCount] [int] NOT NULL,
	[OperateMachine] [nvarchar](32) NOT NULL CONSTRAINT [DF_RecordActivityReward_Machine]  DEFAULT (N'------------'),
	[OperateDate] [datetime] NOT NULL CONSTRAINT [DF_RecordActivityReward_OperateDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RecordActivityReward] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordActivityReward', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'活动标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordActivityReward', @level2type=N'COLUMN',@level2name=N'ActivityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordActivityReward', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordActivityReward', @level2type=N'COLUMN',@level2name=N'GoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordActivityReward', @level2type=N'COLUMN',@level2name=N'GoodsCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordActivityReward', @level2type=N'COLUMN',@level2name=N'OperateMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordActivityReward', @level2type=N'COLUMN',@level2name=N'OperateDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Return360DetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[app_order_id] [nvarchar](64) NOT NULL,
	[app_key] [nvarchar](32) NOT NULL,
	[product_id] [nvarchar](36) NOT NULL,
	[amount] [decimal](18, 2) NOT NULL,
	[app_uid] [nvarchar](50) NOT NULL,
	[user_id] [nvarchar](20) NOT NULL,
	[order_id] [nvarchar](20) NOT NULL,
	[gateway_flag] [nvarchar](16) NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_Return360DetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_Return360DetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Return360DetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应用订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Return360DetailInfo', @level2type=N'COLUMN',@level2name=N'app_order_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应用app key' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Return360DetailInfo', @level2type=N'COLUMN',@level2name=N'app_key'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应用自定义的商品id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Return360DetailInfo', @level2type=N'COLUMN',@level2name=N'product_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Return360DetailInfo', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应用分配给用户的id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Return360DetailInfo', @level2type=N'COLUMN',@level2name=N'app_uid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'360账号id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Return360DetailInfo', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'360返回的支付订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Return360DetailInfo', @level2type=N'COLUMN',@level2name=N'order_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Return360DetailInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnMIDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[orderId] [nvarchar](64) NOT NULL,
	[appId] [nvarchar](20) NOT NULL,
	[cpOrderId] [nvarchar](36) NOT NULL,
	[uid] [nvarchar](10) NOT NULL,
	[orderStatus] [nvarchar](16) NOT NULL,
	[payFee] [decimal](18, 2) NOT NULL,
	[productCode] [nvarchar](40) NOT NULL,
	[productName] [nvarchar](128) NOT NULL,
	[productCount] [int] NOT NULL,
	[payTime] [datetime] NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnMIDetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnMIDetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnMIDetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏平台订单ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnMIDetailInfo', @level2type=N'COLUMN',@level2name=N'orderId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnMIDetailInfo', @level2type=N'COLUMN',@level2name=N'appId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开发商订单ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnMIDetailInfo', @level2type=N'COLUMN',@level2name=N'cpOrderId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnMIDetailInfo', @level2type=N'COLUMN',@level2name=N'uid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnMIDetailInfo', @level2type=N'COLUMN',@level2name=N'orderStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnMIDetailInfo', @level2type=N'COLUMN',@level2name=N'payFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnMIDetailInfo', @level2type=N'COLUMN',@level2name=N'productCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnMIDetailInfo', @level2type=N'COLUMN',@level2name=N'productName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品数量 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnMIDetailInfo', @level2type=N'COLUMN',@level2name=N'productCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnMIDetailInfo', @level2type=N'COLUMN',@level2name=N'payTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnMIDetailInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnHWDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[requestId] [nvarchar](50) NOT NULL,
	[userName] [nvarchar](50) NOT NULL,
	[productName] [nvarchar](100) NOT NULL,
	[payType] [int] NOT NULL,
	[amount] [decimal](18, 2) NOT NULL,
	[orderId] [nvarchar](50) NOT NULL,
	[notifyTime] [datetime] NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnHWDetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnHWDetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnHWDetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnHWDetailInfo', @level2type=N'COLUMN',@level2name=N'requestId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnHWDetailInfo', @level2type=N'COLUMN',@level2name=N'userName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品名称 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnHWDetailInfo', @level2type=N'COLUMN',@level2name=N'productName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnHWDetailInfo', @level2type=N'COLUMN',@level2name=N'payType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnHWDetailInfo', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'华为订单号 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnHWDetailInfo', @level2type=N'COLUMN',@level2name=N'orderId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'通知时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnHWDetailInfo', @level2type=N'COLUMN',@level2name=N'notifyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnHWDetailInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnKPDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[exorderno] [nvarchar](50) NOT NULL,
	[transid] [nvarchar](32) NOT NULL,
	[appid] [nvarchar](20) NOT NULL,
	[waresid] [int] NOT NULL,
	[feetype] [int] NOT NULL,
	[money] [decimal](18, 2) NOT NULL,
	[count] [int] NOT NULL,
	[result] [int] NOT NULL,
	[transtype] [int] NOT NULL,
	[transtime] [datetime] NOT NULL,
	[cpprivate] [nvarchar](128) NOT NULL,
	[paytype] [int] NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnKPDetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnKPDetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKPDetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKPDetailInfo', @level2type=N'COLUMN',@level2name=N'exorderno'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKPDetailInfo', @level2type=N'COLUMN',@level2name=N'transid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKPDetailInfo', @level2type=N'COLUMN',@level2name=N'appid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKPDetailInfo', @level2type=N'COLUMN',@level2name=N'waresid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计费方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKPDetailInfo', @level2type=N'COLUMN',@level2name=N'feetype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKPDetailInfo', @level2type=N'COLUMN',@level2name=N'money'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'购买数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKPDetailInfo', @level2type=N'COLUMN',@level2name=N'count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易结果' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKPDetailInfo', @level2type=N'COLUMN',@level2name=N'result'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易完成时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKPDetailInfo', @level2type=N'COLUMN',@level2name=N'transtime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户私有信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKPDetailInfo', @level2type=N'COLUMN',@level2name=N'cpprivate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKPDetailInfo', @level2type=N'COLUMN',@level2name=N'paytype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnKPDetailInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnWDJDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[out_trade_no] [nvarchar](64) NOT NULL,
	[orderId] [nvarchar](64) NOT NULL,
	[money] [decimal](18, 2) NOT NULL,
	[chargeType] [nvarchar](20) NOT NULL,
	[appKeyId] [nvarchar](30) NOT NULL,
	[buyerId] [nvarchar](30) NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnWDJDetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnWDJDetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWDJDetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWDJDetailInfo', @level2type=N'COLUMN',@level2name=N'out_trade_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'豌豆荚订单标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWDJDetailInfo', @level2type=N'COLUMN',@level2name=N'orderId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWDJDetailInfo', @level2type=N'COLUMN',@level2name=N'money'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWDJDetailInfo', @level2type=N'COLUMN',@level2name=N'chargeType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'appKeyId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWDJDetailInfo', @level2type=N'COLUMN',@level2name=N'appKeyId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'购买人的账户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWDJDetailInfo', @level2type=N'COLUMN',@level2name=N'buyerId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnWDJDetailInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnOPPODetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[partnerOrder] [nvarchar](64) NOT NULL,
	[notifyId] [nvarchar](50) NOT NULL,
	[productName] [nvarchar](40) NOT NULL,
	[productDesc] [nvarchar](120) NOT NULL,
	[price] [decimal](18, 2) NOT NULL,
	[count] [int] NOT NULL,
	[attach] [nvarchar](200) NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnOPPODetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnOPPODetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnOPPODetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnOPPODetailInfo', @level2type=N'COLUMN',@level2name=N'partnerOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回调通知ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnOPPODetailInfo', @level2type=N'COLUMN',@level2name=N'notifyId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnOPPODetailInfo', @level2type=N'COLUMN',@level2name=N'productName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnOPPODetailInfo', @level2type=N'COLUMN',@level2name=N'productDesc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnOPPODetailInfo', @level2type=N'COLUMN',@level2name=N'price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnOPPODetailInfo', @level2type=N'COLUMN',@level2name=N'count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附加参数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnOPPODetailInfo', @level2type=N'COLUMN',@level2name=N'attach'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnOPPODetailInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnVIVODetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[out_trade_no] [nvarchar](64) NOT NULL,
	[vivoOrder] [nvarchar](30) NOT NULL,
	[storeOrder] [nvarchar](64) NOT NULL,
	[orderAmount] [decimal](18, 2) NOT NULL,
	[channelFee] [decimal](18, 2) NOT NULL,
	[storeId] [nvarchar](20) NOT NULL,
	[channel] [nvarchar](4) NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnVIVODetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnVIVODetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVIVODetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVIVODetailInfo', @level2type=N'COLUMN',@level2name=N'out_trade_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'vivo订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVIVODetailInfo', @level2type=N'COLUMN',@level2name=N'vivoOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'易接订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVIVODetailInfo', @level2type=N'COLUMN',@level2name=N'storeOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVIVODetailInfo', @level2type=N'COLUMN',@level2name=N'orderAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVIVODetailInfo', @level2type=N'COLUMN',@level2name=N'channelFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'vivo标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVIVODetailInfo', @level2type=N'COLUMN',@level2name=N'storeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVIVODetailInfo', @level2type=N'COLUMN',@level2name=N'channel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnVIVODetailInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnBDDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[out_trade_no] [nvarchar](64) NOT NULL,
	[appid] [nvarchar](8) NOT NULL,
	[orderid] [nvarchar](20) NOT NULL,
	[amount] [decimal](18, 2) NOT NULL,
	[unit] [nvarchar](4) NOT NULL,
	[jfd] [nvarchar](6) NOT NULL,
	[paychannel] [nvarchar](10) NOT NULL,
	[channel] [nvarchar](10) NOT NULL,
	[cpdefinepart] [nvarchar](64) NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnBDDetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnBDDetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnBDDetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnBDDetailInfo', @level2type=N'COLUMN',@level2name=N'out_trade_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'百度标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnBDDetailInfo', @level2type=N'COLUMN',@level2name=N'appid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'百度订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnBDDetailInfo', @level2type=N'COLUMN',@level2name=N'orderid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnBDDetailInfo', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'金额类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnBDDetailInfo', @level2type=N'COLUMN',@level2name=N'unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计费点ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnBDDetailInfo', @level2type=N'COLUMN',@level2name=N'jfd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值渠道' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnBDDetailInfo', @level2type=N'COLUMN',@level2name=N'paychannel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnBDDetailInfo', @level2type=N'COLUMN',@level2name=N'channel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自定义项' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnBDDetailInfo', @level2type=N'COLUMN',@level2name=N'cpdefinepart'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnBDDetailInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnEJDetailInfo](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[out_trade_no] [nvarchar](64) NOT NULL,
	[app] [nvarchar](32) NOT NULL,
	[ct] [bigint] NOT NULL,
	[fee] [decimal](18, 2) NOT NULL,
	[pt] [bigint] NOT NULL,
	[sdk] [nvarchar](32) NOT NULL,
	[ssid] [nvarchar](32) NOT NULL,
	[tcd] [nvarchar](64) NOT NULL,
	[uid] [nvarchar](64) NOT NULL,
	[ver] [nvarchar](4) NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_ReturnEJDetailInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_ReturnEJDetailInfo] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnEJDetailInfo', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商户订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnEJDetailInfo', @level2type=N'COLUMN',@level2name=N'out_trade_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应用标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnEJDetailInfo', @level2type=N'COLUMN',@level2name=N'app'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'完成时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnEJDetailInfo', @level2type=N'COLUMN',@level2name=N'ct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnEJDetailInfo', @level2type=N'COLUMN',@level2name=N'fee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'付费时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnEJDetailInfo', @level2type=N'COLUMN',@level2name=N'pt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnEJDetailInfo', @level2type=N'COLUMN',@level2name=N'sdk'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道流水' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnEJDetailInfo', @level2type=N'COLUMN',@level2name=N'ssid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'易接订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnEJDetailInfo', @level2type=N'COLUMN',@level2name=N'tcd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnEJDetailInfo', @level2type=N'COLUMN',@level2name=N'uid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'协议版本' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnEJDetailInfo', @level2type=N'COLUMN',@level2name=N'ver'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReturnEJDetailInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordAliPayTransfer](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [nvarchar](32) NOT NULL,
	[UserID] [int] NOT NULL,
	[PayeeAccount] [nvarchar](100) NOT NULL,
	[PayeeRealName] [nvarchar](100) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[TransferStatus] [tinyint] NOT NULL,
	[TransferDate] [datetime] NOT NULL CONSTRAINT [DF_RecordAliPayTransfer_TransferDate]  DEFAULT (getdate()),
	[SuccessDate] [datetime] NOT NULL CONSTRAINT [DF_RecordAliPayTransfer_SuccessDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RecordAliPayTransfer] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAliPayTransfer', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAliPayTransfer', @level2type=N'COLUMN',@level2name=N'OrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAliPayTransfer', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付宝账户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAliPayTransfer', @level2type=N'COLUMN',@level2name=N'PayeeAccount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账户姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAliPayTransfer', @level2type=N'COLUMN',@level2name=N'PayeeRealName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转账金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAliPayTransfer', @level2type=N'COLUMN',@level2name=N'Amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转账状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAliPayTransfer', @level2type=N'COLUMN',@level2name=N'TransferStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转账时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAliPayTransfer', @level2type=N'COLUMN',@level2name=N'TransferDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到账时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAliPayTransfer', @level2type=N'COLUMN',@level2name=N'SuccessDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordRedPacketTransfer](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [nvarchar](32) NOT NULL,
	[UserID] [nchar](10) NOT NULL,
	[PayeeAccount] [nvarchar](100) NOT NULL,
	[PayeeRealName] [nvarchar](100) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[RecordDate] [datetime] NOT NULL CONSTRAINT [DF_RecordRedPacketTransfer_RecordDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RecordRedPacketTransfer] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRedPacketTransfer', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRedPacketTransfer', @level2type=N'COLUMN',@level2name=N'OrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRedPacketTransfer', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付宝账户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRedPacketTransfer', @level2type=N'COLUMN',@level2name=N'PayeeAccount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账户姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRedPacketTransfer', @level2type=N'COLUMN',@level2name=N'PayeeRealName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRedPacketTransfer', @level2type=N'COLUMN',@level2name=N'RecordDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordChannelRecharge](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[PlatformID] [int] NOT NULL,
	[ChannelID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ShareID] [int] NOT NULL,
	[OrderID] [nvarchar](32) NOT NULL,
	[PayAmount] [decimal](18, 2) NOT NULL,
	[OutPercent] [decimal](18, 2) NOT NULL,
	[OutAmount] [decimal](18, 2) NOT NULL,
	[Nullity] [tinyint] NOT NULL,
	[ApplyDate] [datetime] NOT NULL CONSTRAINT [DF_RecordChannelRecharge_ApplyDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RecordChannelRecharge] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelRecharge', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelRecharge', @level2type=N'COLUMN',@level2name=N'PlatformID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelRecharge', @level2type=N'COLUMN',@level2name=N'ChannelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelRecharge', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelRecharge', @level2type=N'COLUMN',@level2name=N'ShareID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelRecharge', @level2type=N'COLUMN',@level2name=N'OrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实付金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelRecharge', @level2type=N'COLUMN',@level2name=N'PayAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输出比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelRecharge', @level2type=N'COLUMN',@level2name=N'OutPercent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输出金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelRecharge', @level2type=N'COLUMN',@level2name=N'OutAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'无效标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelRecharge', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelRecharge', @level2type=N'COLUMN',@level2name=N'ApplyDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordChannelInScore](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[PlatformID] [int] NOT NULL,
	[ChannelID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[VIPUserID] [int] NOT NULL,
	[TransferScore] [bigint] NOT NULL,
	[Nullity] [tinyint] NOT NULL,
	[TransferDate] [datetime] NOT NULL CONSTRAINT [DF_RecordChannelInScore_TransferDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RecordChannelInScore] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelInScore', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelInScore', @level2type=N'COLUMN',@level2name=N'PlatformID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelInScore', @level2type=N'COLUMN',@level2name=N'ChannelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelInScore', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelInScore', @level2type=N'COLUMN',@level2name=N'VIPUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转账分数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelInScore', @level2type=N'COLUMN',@level2name=N'TransferScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'无效标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelInScore', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转账时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelInScore', @level2type=N'COLUMN',@level2name=N'TransferDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordChannelOutScore](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[PlatformID] [int] NOT NULL,
	[ChannelID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[VIPUserID] [int] NOT NULL,
	[TransferScore] [bigint] NOT NULL,
	[Nullity] [tinyint] NOT NULL,
	[TransferDate] [datetime] NOT NULL CONSTRAINT [DF_RecordChannelOutScore_TransferDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_RecordChannelOutScore] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelOutScore', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelOutScore', @level2type=N'COLUMN',@level2name=N'PlatformID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'渠道标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelOutScore', @level2type=N'COLUMN',@level2name=N'ChannelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelOutScore', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelOutScore', @level2type=N'COLUMN',@level2name=N'VIPUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转账分数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelOutScore', @level2type=N'COLUMN',@level2name=N'TransferScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'无效标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelOutScore', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转账时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordChannelOutScore', @level2type=N'COLUMN',@level2name=N'TransferDate'