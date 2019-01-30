USE THAccountsDB
GO

-- ��������
TRUNCATE TABLE ChannelType
INSERT INTO THAccountsDB.dbo.ChannelType(ChannelType, TypeName) VALUES (1, N'Ӧ������');
INSERT INTO THAccountsDB.dbo.ChannelType(ChannelType, TypeName) VALUES (2, N'CPS����');
INSERT INTO THAccountsDB.dbo.ChannelType(ChannelType, TypeName) VALUES (3, N'��������');

GO

-- ҳ������
TRUNCATE TABLE ChannelPage
INSERT INTO THAccountsDB.dbo.ChannelPage(PageIndex, PageName, ChannelType, ServiceRight, PageLink) VALUES (21, N'ƻ��', 2, 1, N'CPS_IOS.aspx');
INSERT INTO THAccountsDB.dbo.ChannelPage(PageIndex, PageName, ChannelType, ServiceRight, PageLink) VALUES (22, N'��׿', 2, 2, N'CPS_Android.aspx');
INSERT INTO THAccountsDB.dbo.ChannelPage(PageIndex, PageName, ChannelType, ServiceRight, PageLink) VALUES (23, N'�ܱ���', 2, 4, N'CPS_All.aspx');
INSERT INTO THAccountsDB.dbo.ChannelPage(PageIndex, PageName, ChannelType, ServiceRight, PageLink) VALUES (31, N'ƻ��', 3, 1, N'Line_IOS.aspx');
INSERT INTO THAccountsDB.dbo.ChannelPage(PageIndex, PageName, ChannelType, ServiceRight, PageLink) VALUES (32, N'��׿', 3, 2, N'Line_Android.aspx');
INSERT INTO THAccountsDB.dbo.ChannelPage(PageIndex, PageName, ChannelType, ServiceRight, PageLink) VALUES (33, N'�ܱ���', 3, 4, N'Line_All.aspx');

GO