USE THAccountsDB
GO
-- 系统设置
TRUNCATE TABLE [dbo].[SystemStatusInfo]
GO

INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'BankPrerequisite', 20, N'存取条件，存取游戏币必须大于此数才可操作！', N'存取条件', N'键值：表示存取金币数必须大于此数才可存取', 35);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'ChannelReward', 20000, N'渠道用户绑定成功后获得的奖励', N'渠道奖励', N'键值：表示渠道用户绑定成功后奖励的金币数', 110);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'EducateGrantScore', 50000000, N'练习场赠送游戏币', N'练习赠送', N'键值：练习场赠送游戏币', 103);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'EnjoinInsure', 0, N'由于系统维护，暂时停止游戏系统的保险柜服务，请留意网站公告信息！', N'银行服务', N'键值：0-开启，1-关闭', 30);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'EnjoinLogon', 0, N'由于系统维护，暂时停止游戏系统的登录服务，请留意网站公告信息！', N'登录服务', N'键值：0-开启，1-关闭', 25);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'EnjoinRegister', 0, N'由于系统维护，暂时停止游戏系统的注册服务，请留意网站公告信息！', N'注册服务', N'键值：0-开启，1-关闭', 10);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'GrantIPCount', 2, N'新用户注册每天赠送限制！', N'注册赠送限制', N'键值：表示同一个IP最多赠送的次数，超过此数将不赠送金币', 20);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'GrantScoreCount', 20000, N'新用户注册系统送游戏币的数目！', N'注册赠送', N'键值：表示赠送的游戏币数量', 15);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'HideModel', 0, N'位说明：10-分享功能 9-弹出活动 8-找刺激 7-微信、支付宝 6-活动礼包 5-商城 4-VIP排行 3-银行赠送 2-指导费 1-大喇叭 0-兑换码', N'默认隐藏', N'键值：隐藏是否开启，键值：0-关闭隐藏，1-开启隐藏', 1000);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'MaxWinScoreGift', 500000, N'赠送最大赢钱', N'赠送最大赢钱', N'键值：赠送最大赢钱', 104);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'MedalExchangeRate', 1000, N'元宝与游戏币兑换率', N'元宝兑换率', N'键值：1个元宝兑换多少游戏币', 90);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'PresentExchangeRate', 1500, N'魅力与游戏币兑换率', N'魅力兑换率', N'键值: 1点魅力兑换多少游戏币', 95);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'RateCurrency', 1, N'人民币与游戏豆的汇率 人民币:游戏豆', N'游戏豆汇率', N'键值：人民币与游戏豆的汇率', 1);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'RateGold', 10000, N'游戏豆与游戏币的汇率 游戏豆:游戏币', N'游戏币汇率', N'键值：游戏豆与游戏币的汇率', 5);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'RevenueRateTake', 0, N'取款操作税收比率（千分比）！', N'取款税率', N'键值：表示银行取款操作税收比率值（千分比）！', 40);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'RevenueRateTransfer', 0, N'转账操作税收比率（千分比）！', N'普通转账税率', N'键值：表示普通玩家银行转账操作税收比率值（千分比）！', 55);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'RevenueRateTransferMember', 0, N'转账操作会员税收比率（千分比）！', N'会员转账税率', N'键值：表示会员玩家银行转账操作税收比率值（千分比）！', 60);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'SubsistenceAllowancesCondition', 1000, N'领取低保玩家游戏币不能低于', N'低保领取条件', N'键值：领取低保玩家金币不能低于该金币数', 80);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'SubsistenceAllowancesGold', 1000, N'每次低保的游戏币数', N'低保每次金额', N'键值：每次低保的金币数', 70);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'SubsistenceAllowancesNumber', 3, N'每天领取低保的最多次数', N'低保每日次数', N'键值：每天领取低保的最多次数', 75);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'TaskTakeCount', 10, N'每天可领取任务的最大数目', N'领取任务数目', N'键值：每天可领取任务的最大数目', 101);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'TransferMaxTax', 1000, N'转账封顶税收！', N'转账税收封顶', N'键值：银行转账封顶税收，0-不封顶', 65);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'TransferPrerequisite', 10000, N'转账条件，转账游戏币数必须大于此数才可转账！', N'转账条件', N'键值：表示转账金币数必须大于此数才可转账', 50);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'TransferStauts', 1, N'转账功能被关闭，请留意网站公告', N'转账状态', N'键值：转账是否开启，键值：0-关闭转账，1-开启转账', 45);
INSERT INTO THAccountsDB.dbo.SystemStatusInfo(StatusName, StatusValue, StatusString, StatusTip, StatusDescription, SortID) VALUES (N'WinExperience', 10, N'赢局奖励的经验值', N'赢局经验', N'键值：赢局奖励的经验值', 100);

GO