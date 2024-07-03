local MythicMonday = MythicMonday
MythicMonday.const = MythicMonday.const or {}
MythicMonday.const.MAX_PLAYER_LEVEL = MAX_PLAYER_LEVEL
MythicMonday.const.ADDON_MESSAGE_PREFIX = "MythicMonday"

MythicMonday.const.ADDON_NAME = "Mythic Monday"

MythicMonday.const.MAX_GROUPS = 8

MythicMonday.const.isDebug = UnitName("player") == "Laserfox"
MythicMonday.const.d_warn = 1
MythicMonday.const.d_info = 2
MythicMonday.const.d_notice = 3
MythicMonday.const.d_debug = 4
MythicMonday.const.debugLevel = MythicMonday.const.d_debug