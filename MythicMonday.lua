local MythicMonday = MythicMonday
MythicMonday:Init()
MythicMonday.msg:RegisterListeners()
MythicMonday.msg:SendMessage(MythicMonday:GetMythicKeystoneInfo())