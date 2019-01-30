USE THAccountsDB
GO

-- 奖励限制
TRUNCATE TABLE RewardLimit
INSERT INTO THAccountsDB.dbo.RewardLimit(RewardLimit, RechargeAmount) VALUES (36, 0);
INSERT INTO THAccountsDB.dbo.RewardLimit(RewardLimit, RechargeAmount) VALUES (43, 100);
INSERT INTO THAccountsDB.dbo.RewardLimit(RewardLimit, RechargeAmount) VALUES (70, 150);
INSERT INTO THAccountsDB.dbo.RewardLimit(RewardLimit, RechargeAmount) VALUES (90, 300);
INSERT INTO THAccountsDB.dbo.RewardLimit(RewardLimit, RechargeAmount) VALUES (136, 500);
INSERT INTO THAccountsDB.dbo.RewardLimit(RewardLimit, RechargeAmount) VALUES (180, 1000);
INSERT INTO THAccountsDB.dbo.RewardLimit(RewardLimit, RechargeAmount) VALUES (324, 2000);
INSERT INTO THAccountsDB.dbo.RewardLimit(RewardLimit, RechargeAmount) VALUES (438, 5000);
INSERT INTO THAccountsDB.dbo.RewardLimit(RewardLimit, RechargeAmount) VALUES (532, 10000);
INSERT INTO THAccountsDB.dbo.RewardLimit(RewardLimit, RechargeAmount) VALUES (623, 20000);

GO

-- 物品类型
TRUNCATE TABLE PackageGoodsType
INSERT INTO THAccountsDB.dbo.PackageGoodsType(GoodsType, TypeName, Nullity) VALUES (1, N'捕鱼类型', 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsType(GoodsType, TypeName, Nullity) VALUES (2, N'宝箱类型', 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsType(GoodsType, TypeName, Nullity) VALUES (3, N'话费类型', 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsType(GoodsType, TypeName, Nullity) VALUES (4, N'宝石类型', 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsType(GoodsType, TypeName, Nullity) VALUES (5, N'金币类型', 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsType(GoodsType, TypeName, Nullity) VALUES (6, N'实物类型', 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsType(GoodsType, TypeName, Nullity) VALUES (7, N'礼包类型', 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsType(GoodsType, TypeName, Nullity) VALUES (8, N'抽奖类型', 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsType(GoodsType, TypeName, Nullity) VALUES (9, N'红包类型', 0);

GO

-- 物品配置
TRUNCATE TABLE PackageGoodsInfo
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (101, N'锁定', 1, 0.20, 0, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (102, N'加速', 1, 0.20, 0, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (103, N'挂机', 1, 0.20, 0, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (104, N'划鱼', 1, 0.20, 0, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (201, N'黄金宝箱', 2, 1.00, 0, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (202, N'钻石宝箱', 2, 5.00, 0, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (301, N'话费', 3, 0.00, 50, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (401, N'宝石卡', 4, 0.00, 0, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (501, N'金币卡', 5, 0.00, 0, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (601, N'小米手机', 6, 0.00, 0, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (602, N'华为手机', 6, 0.00, 0, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (603, N'苹果手机', 6, 0.00, 0, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (701, N'新手礼包', 7, 0.00, 0, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (801, N'抽奖卡', 8, 0.00, 0, 0);
INSERT INTO THAccountsDB.dbo.PackageGoodsInfo(GoodsID, GoodsName, GoodsType, GoodsPrice, LimitCount, Nullity) VALUES (901, N'红包', 9, 0.00, 0, 0);

GO

-- 宝箱配置
TRUNCATE TABLE PackageBoxConfig
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (201, 301, 1, 132, 331);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (201, 301, 3, 62, 131);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (201, 301, 5, 22, 61);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (201, 301, 10, 2, 21);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (201, 301, 20, 1, 1);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (201, 501, 2000, 788, 1137);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (201, 501, 5000, 438, 787);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (201, 501, 10000, 388, 437);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (201, 501, 50000, 343, 387);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (201, 501, 100000, 333, 342);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (201, 501, 1000000, 332, 332);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (201, 901, 1, 1138, 1157);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (201, 901, 2, 1158, 1167);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (202, 301, 3, 757, 956);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (202, 301, 5, 257, 756);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (202, 301, 10, 7, 256);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (202, 301, 50, 2, 6);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (202, 301, 100, 1, 1);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (202, 501, 10000, 1723, 2322);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (202, 501, 50000, 1223, 1722);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (202, 501, 100000, 973, 1222);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (202, 501, 200000, 963, 972);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (202, 501, 500000, 958, 962);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (202, 501, 1000000, 957, 957);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (202, 901, 5, 2323, 2372);
INSERT INTO THAccountsDB.dbo.PackageBoxConfig(GoodsID, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (202, 901, 10, 2373, 2397);

GO

-- 抽奖配置
TRUNCATE TABLE LotteryConfig
INSERT INTO THAccountsDB.dbo.LotteryConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (1, 501, 1888, 1, 90);
INSERT INTO THAccountsDB.dbo.LotteryConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (2, 301, 10, 91, 100);
INSERT INTO THAccountsDB.dbo.LotteryConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (3, 501, 2888, 101, 190);
INSERT INTO THAccountsDB.dbo.LotteryConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (4, 301, 5, 191, 210);
INSERT INTO THAccountsDB.dbo.LotteryConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (5, 501, 4888, 211, 290);
INSERT INTO THAccountsDB.dbo.LotteryConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (6, 301, 3, 291, 320);
INSERT INTO THAccountsDB.dbo.LotteryConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (7, 501, 6888, 321, 395);
INSERT INTO THAccountsDB.dbo.LotteryConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (8, 201, 1, 396, 495);
INSERT INTO THAccountsDB.dbo.LotteryConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (9, 301, 1, 496, 595);
INSERT INTO THAccountsDB.dbo.LotteryConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (10, 202, 1, 596, 645);

GO

-- 礼包配置
TRUNCATE TABLE PackagePacksConfig
INSERT INTO THAccountsDB.dbo.PackagePacksConfig(GoodsID, PacksGoodsID, PacksGoodsCount) VALUES (701, 201, 1);
INSERT INTO THAccountsDB.dbo.PackagePacksConfig(GoodsID, PacksGoodsID, PacksGoodsCount) VALUES (701, 202, 1);
INSERT INTO THAccountsDB.dbo.PackagePacksConfig(GoodsID, PacksGoodsID, PacksGoodsCount) VALUES (701, 301, 5);
INSERT INTO THAccountsDB.dbo.PackagePacksConfig(GoodsID, PacksGoodsID, PacksGoodsCount) VALUES (701, 501, 10000);

GO
