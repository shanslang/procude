USE [THPlatformDB]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GamePageItem](
	[PageID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[NodeID] [int] NOT NULL,
	[SortID] [int] NOT NULL,
	[OperateType] [int] NOT NULL,
	[DisplayName] [nvarchar](32) NOT NULL,
	[ResponseUrl] [nvarchar](256) NOT NULL CONSTRAINT [DF_GamePageItem_ResponseUrl]  DEFAULT (N''),
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_GameCustomItem_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_GameCustomItem_CustomID] PRIMARY KEY CLUSTERED 
(
	[PageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GamePageItem', @level2type=N'COLUMN',@level2name=N'PageID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GamePageItem', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GamePageItem', @level2type=N'COLUMN',@level2name=N'NodeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GamePageItem', @level2type=N'COLUMN',@level2name=N'SortID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GamePageItem', @level2type=N'COLUMN',@level2name=N'OperateType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'显示名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GamePageItem', @level2type=N'COLUMN',@level2name=N'DisplayName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'跳转地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GamePageItem', @level2type=N'COLUMN',@level2name=N'ResponseUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'无效标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GamePageItem', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameTypeItem](
	[TypeID] [int] NOT NULL,
	[JoinID] [int] NOT NULL CONSTRAINT [DF_GameTypeItem_JoinID]  DEFAULT ((0)),
	[SortID] [int] NOT NULL CONSTRAINT [DF_GameTypeItem_SortID]  DEFAULT ((1000)),
	[TypeName] [nvarchar](32) NOT NULL,
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_GameTypeItem_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_GameTypeItem_TypeID] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameTypeItem', @level2type=N'COLUMN',@level2name=N'TypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'挂接标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameTypeItem', @level2type=N'COLUMN',@level2name=N'JoinID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameTypeItem', @level2type=N'COLUMN',@level2name=N'SortID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameTypeItem', @level2type=N'COLUMN',@level2name=N'TypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'无效标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameTypeItem', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameTypeItem'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SigninConfig](
	[DayID] [int] NOT NULL,
	[RewardGold] [bigint] NOT NULL CONSTRAINT [DF_SigninConfig_RewardGold]  DEFAULT ((0)),
 CONSTRAINT [PK_SigninConfig] PRIMARY KEY CLUSTERED 
(
	[DayID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签到标识[天]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SigninConfig', @level2type=N'COLUMN',@level2name=N'DayID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SigninConfig', @level2type=N'COLUMN',@level2name=N'RewardGold'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OnLineStatusInfo](
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[OnLineCount] [int] NOT NULL,
	[InsertDateTime] [datetime] NOT NULL CONSTRAINT [DF_OnLineStatusInfo_InsertDateTime]  DEFAULT (getdate()),
	[ModifyDateTime] [datetime] NOT NULL CONSTRAINT [DF_OnLineStatusInfo_ModifyDateTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_OnLineStatusInfo_ID] PRIMARY KEY CLUSTERED 
(
	[KindID] ASC,
	[ServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineStatusInfo', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineStatusInfo', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineStatusInfo', @level2type=N'COLUMN',@level2name=N'OnLineCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'插入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineStatusInfo', @level2type=N'COLUMN',@level2name=N'InsertDateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineStatusInfo', @level2type=N'COLUMN',@level2name=N'ModifyDateTime'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalPlayPresent](
	[ServerID] [int] NOT NULL,
	[PresentMember] [nvarchar](50) NOT NULL CONSTRAINT [DF_GlobalPlayPresent_PresentMember]  DEFAULT (''),
	[MaxDatePresent] [int] NOT NULL CONSTRAINT [DF_GlobalPlayPresent_MaxGrantDateScore]  DEFAULT ((0)),
	[MaxPresent] [int] NOT NULL CONSTRAINT [DF_GlobalPlayPresent_MaxGrantScore]  DEFAULT ((0)),
	[CellPlayPresnet] [int] NOT NULL CONSTRAINT [DF_GlobalPlayPresent_CellPlayPresnet]  DEFAULT ((0)),
	[CellPlayTime] [int] NOT NULL CONSTRAINT [DF_GlobalPlayPresent_CellPlayTime]  DEFAULT ((0)),
	[StartPlayTime] [int] NOT NULL CONSTRAINT [DF_GlobalPlayPresent_StartPlayTime]  DEFAULT ((0)),
	[CellOnlinePresent] [int] NOT NULL CONSTRAINT [DF_GlobalPlayPresent_CellOnlinePresent]  DEFAULT ((0)),
	[CellOnlineTime] [int] NOT NULL CONSTRAINT [DF_GlobalPlayPresent_CellOnlineTime]  DEFAULT ((0)),
	[StartOnlineTime] [int] NOT NULL CONSTRAINT [DF_GlobalPlayPresent_StartOnlineTime]  DEFAULT ((0)),
	[IsPlayPresent] [tinyint] NOT NULL CONSTRAINT [DF_GlobalPlayPresent_IsPlayPresent]  DEFAULT ((0)),
	[IsOnlinePresent] [tinyint] NOT NULL CONSTRAINT [DF_GlobalPlayPresent_IsOnlinePresent]  DEFAULT ((0)),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_GlobalPlayPresent_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_GlobalPlayPresent_1] PRIMARY KEY CLUSTERED 
(
	[ServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPlayPresent', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送会员范围' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPlayPresent', @level2type=N'COLUMN',@level2name=N'PresentMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单日封顶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPlayPresent', @level2type=N'COLUMN',@level2name=N'MaxDatePresent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大封顶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPlayPresent', @level2type=N'COLUMN',@level2name=N'MaxPresent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏泡分单元值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPlayPresent', @level2type=N'COLUMN',@level2name=N'CellPlayPresnet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏泡分单元时间(秒)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPlayPresent', @level2type=N'COLUMN',@level2name=N'CellPlayTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏泡分启动时间(秒)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPlayPresent', @level2type=N'COLUMN',@level2name=N'StartPlayTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线泡分单元值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPlayPresent', @level2type=N'COLUMN',@level2name=N'CellOnlinePresent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线泡分单元时间(秒)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPlayPresent', @level2type=N'COLUMN',@level2name=N'CellOnlineTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线泡分启始时间(秒)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPlayPresent', @level2type=N'COLUMN',@level2name=N'StartOnlineTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否开启游戏泡分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPlayPresent', @level2type=N'COLUMN',@level2name=N'IsPlayPresent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否开启在线泡分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPlayPresent', @level2type=N'COLUMN',@level2name=N'IsOnlinePresent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GlobalPlayPresent', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OnLineStreamInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](32) NOT NULL,
	[MachineServer] [nvarchar](32) NOT NULL,
	[InsertDateTime] [datetime] NOT NULL CONSTRAINT [DF_OnLineStreamInfo_InsertDateTime]  DEFAULT (getdate()),
	[OnLineCountSum] [int] NOT NULL,
	[AndroidCountSum] [int] NOT NULL CONSTRAINT [DF_OnLineStreamInfo_AndroidCountSum]  DEFAULT ((0)),
	[OnLineCountKind] [nvarchar](2048) NOT NULL,
	[AndroidCountKind] [nvarchar](2048) NOT NULL CONSTRAINT [DF_OnLineStreamInfo_AndroidCountKind]  DEFAULT (''),
 CONSTRAINT [PK_OnLineStreamInfo_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineStreamInfo', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机器标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineStreamInfo', @level2type=N'COLUMN',@level2name=N'MachineID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机器名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineStreamInfo', @level2type=N'COLUMN',@level2name=N'MachineServer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'插入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineStreamInfo', @level2type=N'COLUMN',@level2name=N'InsertDateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineStreamInfo', @level2type=N'COLUMN',@level2name=N'OnLineCountSum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLineStreamInfo', @level2type=N'COLUMN',@level2name=N'OnLineCountKind'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameKindItem](
	[KindID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
	[JoinID] [int] NOT NULL CONSTRAINT [DF_GameKindItem_JoinID]  DEFAULT ((0)),
	[SortID] [int] NOT NULL CONSTRAINT [DF_GameKindItem_SortID]  DEFAULT ((1000)),
	[KindName] [nvarchar](32) NOT NULL,
	[ProcessName] [nvarchar](32) NOT NULL,
	[GameRuleUrl] [nvarchar](256) NOT NULL CONSTRAINT [DF_GameKindItem_ResponseUrl]  DEFAULT (N''),
	[DownLoadUrl] [nvarchar](256) NOT NULL CONSTRAINT [DF_GameKindItem_DownLoadUrl]  DEFAULT (N''),
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_GameKindItem_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_GameKindItem] PRIMARY KEY CLUSTERED 
(
	[KindID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'GameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'种类标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'TypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'挂接标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'JoinID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'SortID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'KindName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进程名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'ProcessName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'跳转地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'GameRuleUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下载地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'DownLoadUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'无效标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataBaseInfo](
	[DBInfoID] [int] IDENTITY(1,1) NOT NULL,
	[DBAddr] [nvarchar](15) NOT NULL,
	[DBPort] [int] NOT NULL CONSTRAINT [DF_TABLE1_DataBasePort]  DEFAULT ((1433)),
	[DBUser] [nvarchar](512) NOT NULL,
	[DBPassword] [nvarchar](512) NOT NULL,
	[MachineID] [nvarchar](32) NOT NULL CONSTRAINT [DF_DataBaseInfo_MachineID]  DEFAULT (N''),
	[Information] [nvarchar](128) NOT NULL CONSTRAINT [DF_SQLConnectInfo_NoteInfo]  DEFAULT (N'N('')'),
 CONSTRAINT [PK_DataBaseInfo_Index] PRIMARY KEY CLUSTERED 
(
	[DBInfoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'网络地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataBaseInfo', @level2type=N'COLUMN',@level2name=N'DBAddr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库端口' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataBaseInfo', @level2type=N'COLUMN',@level2name=N'DBPort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataBaseInfo', @level2type=N'COLUMN',@level2name=N'DBUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataBaseInfo', @level2type=N'COLUMN',@level2name=N'DBPassword'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机器标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataBaseInfo', @level2type=N'COLUMN',@level2name=N'MachineID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataBaseInfo', @level2type=N'COLUMN',@level2name=N'Information'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameGameItem](
	[GameID] [int] NOT NULL,
	[GameName] [nvarchar](31) NOT NULL,
	[SuportType] [int] NOT NULL,
	[DataBaseAddr] [nvarchar](15) NOT NULL CONSTRAINT [DF_GameGameItem_DBAddr]  DEFAULT (''),
	[DataBaseName] [nvarchar](31) NOT NULL,
	[ServerVersion] [int] NOT NULL CONSTRAINT [DF_GameModuleInfo_ModuleVersion]  DEFAULT ((0)),
	[ClientVersion] [int] NOT NULL CONSTRAINT [DF_GameModuleInfo_ClientVersion]  DEFAULT ((0)),
	[ServerDLLName] [nvarchar](31) NOT NULL,
	[ClientExeName] [nvarchar](31) NOT NULL,
 CONSTRAINT [PK_GameModuleInfo_ModuleID] PRIMARY KEY NONCLUSTERED 
(
	[GameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameGameItem', @level2type=N'COLUMN',@level2name=N'GameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameGameItem', @level2type=N'COLUMN',@level2name=N'GameName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支持类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameGameItem', @level2type=N'COLUMN',@level2name=N'SuportType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'连接地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameGameItem', @level2type=N'COLUMN',@level2name=N'DataBaseAddr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameGameItem', @level2type=N'COLUMN',@level2name=N'DataBaseName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务器版本' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameGameItem', @level2type=N'COLUMN',@level2name=N'ServerVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户端版本' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameGameItem', @level2type=N'COLUMN',@level2name=N'ClientVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务端名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameGameItem', @level2type=N'COLUMN',@level2name=N'ServerDLLName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户端名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameGameItem', @level2type=N'COLUMN',@level2name=N'ClientExeName'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameRoomInfo](
	[ServerID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](31) NOT NULL,
	[KindID] [int] NOT NULL,
	[NodeID] [int] NOT NULL,
	[SortID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[TableCount] [int] NOT NULL CONSTRAINT [DF_GameRoomInfo_TableCount]  DEFAULT ((60)),
	[ServerKind] [int] NOT NULL CONSTRAINT [DF_GameRoomInfo_ServerKind]  DEFAULT ((0)),
	[ServerType] [int] NOT NULL,
	[ServerPort] [int] NOT NULL CONSTRAINT [DF_GameRoomInfo_ServerPort]  DEFAULT ((0)),
	[ServerPasswd] [nvarchar](31) NULL,
	[DataBaseName] [nvarchar](31) NOT NULL,
	[DataBaseAddr] [nvarchar](15) NOT NULL CONSTRAINT [DF_GameRoomInfo_DataBaseAddr]  DEFAULT (''),
	[CellScore] [bigint] NOT NULL CONSTRAINT [DF_GameRoomInfo_CellScore]  DEFAULT ((0)),
	[RevenueRatio] [tinyint] NOT NULL,
	[ServiceScore] [bigint] NOT NULL CONSTRAINT [DF_GameRoomInfo_ServiceGold]  DEFAULT ((0)),
	[RestrictScore] [bigint] NOT NULL CONSTRAINT [DF_GameRoomInfo_RestrictScore]  DEFAULT ((0)),
	[MinTableScore] [bigint] NOT NULL CONSTRAINT [DF_GameRoomInfo_MinTableScore]  DEFAULT ((0)),
	[MinEnterScore] [bigint] NOT NULL CONSTRAINT [DF_GameRoomInfo_MinEnterScore]  DEFAULT ((0)),
	[MaxEnterScore] [bigint] NOT NULL CONSTRAINT [DF_GameRoomInfo_MaxEnterScore]  DEFAULT ((0)),
	[MinEnterMember] [int] NOT NULL CONSTRAINT [DF_GameRoomInfo_MinEnterMember]  DEFAULT ((0)),
	[MaxEnterMember] [int] NOT NULL CONSTRAINT [DF_GameRoomInfo_MaxEnterMember]  DEFAULT ((0)),
	[MaxPlayer] [int] NOT NULL,
	[ServerRule] [int] NOT NULL,
	[DistributeRule] [int] NOT NULL CONSTRAINT [DF_GameRoomInfo_DistributeRule]  DEFAULT ((0)),
	[MinDistributeUser] [int] NOT NULL CONSTRAINT [DF_GameRoomInfo_MinDistributeUser]  DEFAULT ((0)),
	[DistributeTimeSpace] [int] NOT NULL CONSTRAINT [DF_GameRoomInfo_DistributeTimeSpace]  DEFAULT ((0)),
	[DistributeDrawCount] [int] NOT NULL CONSTRAINT [DF_GameRoomInfo_DistributeDrawCount]  DEFAULT ((0)),
	[MinPartakeGameUser] [int] NOT NULL CONSTRAINT [DF_GameRoomInfo_MinPartakeGameUser]  DEFAULT ((0)),
	[MaxPartakeGameUser] [int] NOT NULL CONSTRAINT [DF_GameRoomInfo_MaxPartakeGameUser_1]  DEFAULT ((0)),
	[AttachUserRight] [int] NOT NULL CONSTRAINT [DF_GameRoomInfo_UserRight]  DEFAULT ((0)),
	[ServiceMachine] [nvarchar](32) NOT NULL CONSTRAINT [DF_GameRoomInfo_MachineSerial]  DEFAULT (''),
	[CustomRule] [nvarchar](2048) NOT NULL CONSTRAINT [DF_GameRoomInfo_CustomRule]  DEFAULT (''),
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_GameRoomInfo_Nullity]  DEFAULT ((0)),
	[ServerNote] [nvarchar](64) NOT NULL CONSTRAINT [DF_GameRoomInfo_ServerNote]  DEFAULT (''),
	[CreateDateTime] [datetime] NOT NULL CONSTRAINT [DF_GameRoomInfo_CreateDataTime]  DEFAULT (getdate()),
	[ModifyDateTime] [datetime] NOT NULL CONSTRAINT [DF_GameRoomInfo_ModifyDateTime]  DEFAULT (getdate()),
	[EnterPassword] [nvarchar](32) NOT NULL CONSTRAINT [DF_GameRoomInfo_EnterPassword]  DEFAULT (''),
 CONSTRAINT [PK_GameRoomInfo_ServerID] PRIMARY KEY CLUSTERED 
(
	[ServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'ServerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'挂接类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'挂接节点' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'NodeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排列标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'SortID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'GameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'桌子数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'TableCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'ServerType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务端口' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'ServerPort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'DataBaseName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'连接地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'DataBaseAddr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'CellScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'税收比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'RevenueRatio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务费用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'ServiceScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'限制积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'RestrictScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最低积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'MinTableScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'MaxPlayer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间规则' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'ServerRule'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分组规则' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'DistributeRule'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最少人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'MinDistributeUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分组间隔' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'DistributeTimeSpace'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分组局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'DistributeDrawCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏最少人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'MinPartakeGameUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏最多人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'MaxPartakeGameUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'运行机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'ServiceMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自定规则' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'CustomRule'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁止服务' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'ServerNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'CreateDateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRoomInfo', @level2type=N'COLUMN',@level2name=N'ModifyDateTime'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemMessage](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MessageType] [int] NOT NULL CONSTRAINT [DF_SystemMessage_MessageOption]  DEFAULT ((3)),
	[ServerRange] [nvarchar](1024) NOT NULL CONSTRAINT [DF_SystemMessage_ServerRange]  DEFAULT ((0)),
	[MessageString] [nvarchar](1024) NOT NULL,
	[StartTime] [datetime] NOT NULL CONSTRAINT [DF_SystemMessage_StartTime]  DEFAULT (getdate()),
	[ConcludeTime] [datetime] NOT NULL CONSTRAINT [DF_SystemMessage_ConcludeTime]  DEFAULT (dateadd(year,(1),getdate())),
	[TimeRate] [int] NOT NULL,
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_SystemMessage_Nullity]  DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_SystemMessage_CreateDate]  DEFAULT (getdate()),
	[CreateMasterID] [int] NOT NULL CONSTRAINT [DF_SystemMessage_CreateMasterID]  DEFAULT ((0)),
	[UpdateDate] [datetime] NOT NULL CONSTRAINT [DF_SystemMessage_LastUpdateDate]  DEFAULT (getdate()),
	[UpdateMasterID] [int] NOT NULL CONSTRAINT [DF_SystemMessage_UpdateMasterID]  DEFAULT ((0)),
	[UpdateCount] [int] NOT NULL CONSTRAINT [DF_SystemMessage_UpdateCount]  DEFAULT ((0)),
	[CollectNote] [nvarchar](512) NOT NULL CONSTRAINT [DF_SystemMessage_CollectNote]  DEFAULT (''),
 CONSTRAINT [PK_SystemMessage_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'索引标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息范围(1:游戏,2:房间,3:全部)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'MessageType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间范围(0:所有房间)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'ServerRange'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'MessageString'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'StartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'ConcludeTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'时间频率(多长时间发送一次)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'TimeRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁止标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建管理员ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'CreateMasterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改管理员ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'UpdateMasterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'UpdateCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemMessage', @level2type=N'COLUMN',@level2name=N'CollectNote'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameConfig](
	[KindID] [int] NOT NULL,
	[NoticeChangeGolds] [bigint] NOT NULL CONSTRAINT [DF_GameConfig_NoticeChangeGolds]  DEFAULT ((0)),
	[WinExperience] [int] NOT NULL CONSTRAINT [DF_GameConfig_Experience]  DEFAULT ((10)),
 CONSTRAINT [PK_GameKindConfig] PRIMARY KEY CLUSTERED 
(
	[KindID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameConfig', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'显示输赢公告的最低输赢金币数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameConfig', @level2type=N'COLUMN',@level2name=N'NoticeChangeGolds'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赢一局经验' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameConfig', @level2type=N'COLUMN',@level2name=N'WinExperience'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameNodeItem](
	[NodeID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[JoinID] [int] NOT NULL CONSTRAINT [DF_GameStationItem_JoinID]  DEFAULT ((0)),
	[SortID] [int] NOT NULL CONSTRAINT [DF_GameStationItem_SortID]  DEFAULT ((1000)),
	[NodeName] [nvarchar](32) NOT NULL,
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_GameStationItem_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_GameNodeItem] PRIMARY KEY CLUSTERED 
(
	[NodeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameNodeItem', @level2type=N'COLUMN',@level2name=N'NodeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameNodeItem', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'挂接标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameNodeItem', @level2type=N'COLUMN',@level2name=N'JoinID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameNodeItem', @level2type=N'COLUMN',@level2name=N'SortID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameNodeItem', @level2type=N'COLUMN',@level2name=N'NodeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'无效标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameNodeItem', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GrowLevelConfig](
	[LevelID] [int] NOT NULL,
	[Experience] [int] NOT NULL,
	[RewardGold] [int] NOT NULL,
	[RewardMedal] [int] NOT NULL,
	[LevelRemark] [nvarchar](64) NULL,
 CONSTRAINT [PK_GrowLevelConfig] PRIMARY KEY CLUSTERED 
(
	[LevelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'等级编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GrowLevelConfig', @level2type=N'COLUMN',@level2name=N'LevelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所需经验值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GrowLevelConfig', @level2type=N'COLUMN',@level2name=N'Experience'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GrowLevelConfig', @level2type=N'COLUMN',@level2name=N'RewardGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GrowLevelConfig', @level2type=N'COLUMN',@level2name=N'RewardMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'等级备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GrowLevelConfig', @level2type=N'COLUMN',@level2name=N'LevelRemark'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskInfo](
	[TaskID] [int] IDENTITY(1,1) NOT NULL,
	[TaskName] [nvarchar](50) NOT NULL CONSTRAINT [DF_TaskInfo_TaskName]  DEFAULT (''),
	[TaskDescription] [nvarchar](500) NOT NULL CONSTRAINT [DF_TaskInfo_TaskDescription]  DEFAULT (''),
	[TaskType] [int] NOT NULL,
	[UserType] [tinyint] NOT NULL,
	[KindID] [int] NOT NULL,
	[MatchID] [int] NOT NULL CONSTRAINT [DF_TaskInfo_MatchID]  DEFAULT ((0)),
	[Innings] [int] NOT NULL CONSTRAINT [DF_TaskInfo_TaskInnings]  DEFAULT ((0)),
	[StandardAwardGold] [int] NOT NULL,
	[StandardAwardMedal] [int] NOT NULL,
	[MemberAwardGold] [int] NOT NULL,
	[MemberAwardMedal] [int] NOT NULL,
	[GoodsID] [int] NOT NULL,
	[GoodsCount] [int] NOT NULL,
	[TimeLimit] [int] NOT NULL CONSTRAINT [DF_TaskInfo_TimeLimit]  DEFAULT ((0)),
	[InputDate] [datetime] NOT NULL CONSTRAINT [DF_TaskInfo_InputDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_TaskInfo] PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'TaskID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'TaskName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'TaskDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务类型 1:总赢局 2:总局数 4:首胜 8:比赛任务' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'TaskType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'可领取任务用户类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'UserType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务所属游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛任务 比赛ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'MatchID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'完成任务需要局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'Innings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'普通玩家奖励金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'StandardAwardGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'普通玩家奖励元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'StandardAwardMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员奖励金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'MemberAwardGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员奖励元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'MemberAwardMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'GoodsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'GoodsCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'时间限制 单位:分钟' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'TimeLimit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TaskInfo', @level2type=N'COLUMN',@level2name=N'InputDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SensitiveWords](
	[ForbidWords] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_SensitiveWords] PRIMARY KEY CLUSTERED 
(
	[ForbidWords] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

