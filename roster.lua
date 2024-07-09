local MythicMonday = MythicMonday

MythicMonday.roster = MythicMonday.roster or {}

function MythicMonday.roster:OnMessage(event, author, class, role, io, message)
  local keystone = FindKeystoneLink(message)
  if keystone then
    MythicMonday:Debug(MythicMonday.const.debug, event, author, class, role, io, keystone)
    MythicMonday.roster:AddPlayerToRoster(author, class, role, io, keystone)
  end
  -- send to add player to roster
end

function FindKeystoneLink(inputString)
  -- Match the Keystone link pattern "|Hkeystone:([0-9]+):([0-9]+):([0-9]+):([0-9]+):([0-9]+):([0-9]+)|h%[([^%]]+)%]|h"
  -- local pattern = "%[Keystone:.-]" --"|cffa335ee|Hkeystone:%d+:%d+:%d+:%d+:%d+:%d+:%d+%[Keystone: [^%]]+%(%d+%)]|h|r"
  -- pattern = "|cffa335ee.+%[Keystone: .+%]|h|r"
  local pattern = "|cffa335ee|Hkeystone:%d+:%d+:%d+:%d+:%d+:%d+:%d+|h%[Keystone: [^%]]+%(%d+%)%]|h|r"
  local link = string.match(inputString, pattern)
  -- MythicMonday:Debug(MythicMonday.const.debug, "Link found", link)
  return link
end

function MythicMonday.roster:AddPlayerToRoster(author, class, role, io, keystone)
  MythicMonday:Debug(MythicMonday.const.debug, 'AddPlayerToRoster', author, class, role, io, keystone)
end