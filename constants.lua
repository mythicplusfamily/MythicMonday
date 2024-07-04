local MythicMonday = MythicMonday
MythicMonday.const = MythicMonday.const or {}
MythicMonday.const.MAX_PLAYER_LEVEL = MAX_PLAYER_LEVEL
MythicMonday.const.ADDON_MESSAGE_PREFIX = "MythicMonday"

MythicMonday.const.ADDON_NAME = "Mythic Monday"

MythicMonday.const.MAX_GROUPS = 8

MythicMonday.const.isDebug = UnitName("player") == "Laserfox"

MythicMonday.const.announce = 1
MythicMonday.const.warn = 2
MythicMonday.const.info = 3
MythicMonday.const.notice = 4
MythicMonday.const.debug = 5
--@non-debug@
MythicMonday.const.debugLevel = MythicMonday.const.debug
--@end-non-debug@
--@debug@
MythicMonday.const.debugLevel = MythicMonday.const.debug
--@end-debug@
