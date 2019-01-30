USE THAccountsDB
GO

-- 渠道配置
TRUNCATE TABLE ChannelType
INSERT INTO THAccountsDB.dbo.ChannelType(ChannelType, TypeName) VALUES (1, N'应用渠道');
INSERT INTO THAccountsDB.dbo.ChannelType(ChannelType, TypeName) VALUES (2, N'CPS渠道');
INSERT INTO THAccountsDB.dbo.ChannelType(ChannelType, TypeName) VALUES (3, N'线下渠道');

GO

-- 页面配置
TRUNCATE TABLE ChannelPage
INSERT INTO THAccountsDB.dbo.ChannelPage(PageIndex, PageName, ChannelType, ServiceRight, PageLink) VALUES (21, N'苹果', 2, 1, N'CPS_IOS.aspx');
INSERT INTO THAccountsDB.dbo.ChannelPage(PageIndex, PageName, ChannelType, ServiceRight, PageLink) VALUES (22, N'安卓', 2, 2, N'CPS_Android.aspx');
INSERT INTO THAccountsDB.dbo.ChannelPage(PageIndex, PageName, ChannelType, ServiceRight, PageLink) VALUES (23, N'总报表', 2, 4, N'CPS_All.aspx');
INSERT INTO THAccountsDB.dbo.ChannelPage(PageIndex, PageName, ChannelType, ServiceRight, PageLink) VALUES (31, N'苹果', 3, 1, N'Line_IOS.aspx');
INSERT INTO THAccountsDB.dbo.ChannelPage(PageIndex, PageName, ChannelType, ServiceRight, PageLink) VALUES (32, N'安卓', 3, 2, N'Line_Android.aspx');
INSERT INTO THAccountsDB.dbo.ChannelPage(PageIndex, PageName, ChannelType, ServiceRight, PageLink) VALUES (33, N'总报表', 3, 4, N'Line_All.aspx');

GO