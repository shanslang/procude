USE THAccountsDB
GO

-- Ω±¿¯≈‰÷√
TRUNCATE TABLE RedPacketConfig
INSERT INTO THAccountsDB.dbo.RedPacketConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (1, 901, 5000, 0, 0);
INSERT INTO THAccountsDB.dbo.RedPacketConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (2, 501, 100000, 1, 200);
INSERT INTO THAccountsDB.dbo.RedPacketConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (3, 901, 200, 201, 202);
INSERT INTO THAccountsDB.dbo.RedPacketConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (4, 901, 5, 203, 1202);
INSERT INTO THAccountsDB.dbo.RedPacketConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (5, 901, 100, 1203, 1206);
INSERT INTO THAccountsDB.dbo.RedPacketConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (6, 501, 200000, 1207, 1306);
INSERT INTO THAccountsDB.dbo.RedPacketConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (7, 901, 50, 1307, 1314);
INSERT INTO THAccountsDB.dbo.RedPacketConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (8, 901, 10, 1315, 1334);
INSERT INTO THAccountsDB.dbo.RedPacketConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (9, 901, 2, 1335, 3334);
INSERT INTO THAccountsDB.dbo.RedPacketConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (10, 501, 20000, 3335, 7334);
INSERT INTO THAccountsDB.dbo.RedPacketConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (11, 901, 500, 7335, 7335);
INSERT INTO THAccountsDB.dbo.RedPacketConfig(ItemIndex, LuckyGoodsID, LuckyGoodsCount, RangeStart, RangeEnd) VALUES (12, 501, 50000, 7336, 7735);

GO

-- ø‚¥Ê≈‰÷√
TRUNCATE TABLE RedPacketStorage
INSERT INTO THAccountsDB.dbo.RedPacketStorage(Nullity, Consume, Deduct, Storage) VALUES (0, 3.00, 0.60, 0.00);

GO
