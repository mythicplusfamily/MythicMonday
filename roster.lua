local MythicMonday = MythicMonday

MythicMonday.roster = MythicMonday.roster or {}

function MythicMonday.roster:OnMessage(event, author, message)
  if event == "CHAT_MSG_ADDON" or event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_GUILD" or event == "CHAT_MSG_WHISPER" then -- or event == "CHAT_MSG_GUILD"
    local keystone = FindKeystoneLink(message)
    local class = UnitClass(author)
    print("TEST", keystone)
    if keystone then
      MythicMonday:Debug(MythicMonday.const.debug, event, author, class, keystone)
    end
  end
end

function FindKeystoneLink(inputString)
  -- Match the Keystone link pattern "|Hkeystone:([0-9]+):([0-9]+):([0-9]+):([0-9]+):([0-9]+):([0-9]+)|h%[([^%]]+)%]|h"
  local pattern = "%[Keystone:.-]" --"|cffa335ee|Hkeystone:%d+:%d+:%d+:%d+:%d+:%d+:%d+%[Keystone: [^%]]+%(%d+%)]|h|r"
  pattern = "|cffa335ee.+%[Keystone: .+|h|r"
  local link = string.match(inputString, pattern)
  -- MythicMonday:Debug(MythicMonday.const.debug, "Link found", link)
  return link
end
