MythicMonday = MythicMonday
MythicMonday.events = MythicMonday.events or {}

function MythicMonday.events:RegisterEvents()
-- CHAT_MSG_CHANNEL CHAT_MSG_WHISPER CHAT_MSG_GUILD CHAT_MSG_PARTY

  MythicMonday.frames.MythicMondayRosterContainer:RegisterEvent("CHAT_MSG_CHANNEL")
  MythicMonday.frames.MythicMondayRosterContainer:RegisterEvent("CHAT_MSG_GUILD")
  MythicMonday.frames.MythicMondayRosterContainer:RegisterEvent("CHAT_MSG_PARTY")
  MythicMonday.frames.MythicMondayRosterContainer:RegisterEvent("CHAT_MSG_PARTY_LEADER")
  MythicMonday.frames.MythicMondayRosterContainer:RegisterEvent("CHAT_MSG_WHISPER")
  MythicMonday.frames.MythicMondayRosterContainer:SetScript("OnEvent", MythicMonday.events.OnChatMessage)
  -- MythicMonday.frames.MythicMondayRosterContainer:SetScript("OnEvent", function(self, event, message, author) print(event, message, author) end)
end

function MythicMonday.events:OnChatMessage(event, message, author)
  if event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_GUILD" or event == "CHAT_MSG_WHISPER" then -- or event == "CHAT_MSG_GUILD"
    MythicMonday.roster:OnMessage(event, author, message)
  end
end