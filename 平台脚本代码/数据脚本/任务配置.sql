USE THPlatformDB
GO

-- ��������
TRUNCATE TABLE TaskInfo
GO

INSERT INTO THPlatformDB.dbo.TaskInfo(TaskName, TaskDescription, TaskType, UserType, KindID, MatchID, Innings, StandardAwardGold, StandardAwardMedal, MemberAwardGold, MemberAwardMedal, GoodsID, GoodsCount, TimeLimit, InputDate) VALUES (N'΢�ŷ�������Ȧ', N'΢�ŷ�������Ȧ���ø�����Ѻ���һ����ֲ��㣡', 8, 3, 3001, 0, 1, 2000, 0, 0, 0, 801, 2, 86400, '2016-08-10 00:00:00.0');
INSERT INTO THPlatformDB.dbo.TaskInfo(TaskName, TaskDescription, TaskType, UserType, KindID, MatchID, Innings, StandardAwardGold, StandardAwardMedal, MemberAwardGold, MemberAwardMedal, GoodsID, GoodsCount, TimeLimit, InputDate) VALUES (N'΢���������', N'΢��������ѣ�����ע����������ID�����ɻ��1Ԫ���ѣ����ѻ��3000��Ϸ��Ŷ��', 8, 3, 3002, 0, 1, 1000, 0, 0, 0, 801, 1, 86400, '2016-08-10 00:00:00.0');
INSERT INTO THPlatformDB.dbo.TaskInfo(TaskName, TaskDescription, TaskType, UserType, KindID, MatchID, Innings, StandardAwardGold, StandardAwardMedal, MemberAwardGold, MemberAwardMedal, GoodsID, GoodsCount, TimeLimit, InputDate) VALUES (N'����QQ����', N'��������QQ���ѣ�����ע����������ID�����ɻ��1Ԫ���ѣ����ѻ��3000��Ϸ��Ŷ�� ', 8, 3, 3003, 0, 1, 1000, 0, 0, 0, 801, 1, 86400, '2016-08-10 00:00:00.0');
INSERT INTO THPlatformDB.dbo.TaskInfo(TaskName, TaskDescription, TaskType, UserType, KindID, MatchID, Innings, StandardAwardGold, StandardAwardMedal, MemberAwardGold, MemberAwardMedal, GoodsID, GoodsCount, TimeLimit, InputDate) VALUES (N'�����ƽ���', N'�����ƽ��䣬���л����ó�ֵ������Ϸ��Ŷ��', 16, 3, 3004, 0, 1, 1000, 0, 0, 0, 801, 1, 86400, '2016-08-10 00:00:00.0');
INSERT INTO THPlatformDB.dbo.TaskInfo(TaskName, TaskDescription, TaskType, UserType, KindID, MatchID, Innings, StandardAwardGold, StandardAwardMedal, MemberAwardGold, MemberAwardMedal, GoodsID, GoodsCount, TimeLimit, InputDate) VALUES (N'������ʯ����', N'������ʯ���䣬���л����ó�ֵ������Ϸ�ң������ֻ����أ�', 16, 3, 3005, 0, 1, 1000, 0, 0, 0, 801, 1, 86400, '2016-08-10 00:00:00.0');
INSERT INTO THPlatformDB.dbo.TaskInfo(TaskName, TaskDescription, TaskType, UserType, KindID, MatchID, Innings, StandardAwardGold, StandardAwardMedal, MemberAwardGold, MemberAwardMedal, GoodsID, GoodsCount, TimeLimit, InputDate) VALUES (N'�״γ�ֵ', N'�״γ�ֵ���Żݣ�����������Żݸ���࣬��������Ŷ��', 16, 3, 3006, 0, 1, 1000, 0, 0, 0, 801, 1, 86400, '2016-08-10 00:00:00.0');

GO