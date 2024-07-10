local MythicMonday = MythicMonday

MythicMonday.msg = MythicMonday.msg or {}

function MythicMonday.msg:SendMessage(data)
  if not data then return end
  MythicMonday:Debug(MythicMonday.const.debug, "sending message", data)
  -- C_ChatInfo.SendAddonMessage(MythicMonday.const.ADDON_MESSAGE_PREFIX, data, "GUILD")
  ChatThrottleLib:SendAddonMessage("BULK", MythicMonday.const.ADDON_MESSAGE_PREFIX, tostring(data), "GUILD")
end

function MythicMonday.msg:OnAddonMessage(event, prefix, message, channel, author)
  if event == "CHAT_MSG_ADDON" and prefix == MythicMonday.const.ADDON_MESSAGE_PREFIX then
    MythicMonday:Debug(MythicMonday.const.debug, "OnAddonMessage: message, channel, author", message, channel, author)
    local type = MythicMonday:SplitString(message, '-')
    if type == "KEYSTONE" then
      MythicMonday.msg:OnKeyStoneMessage(author, message)
      return
    end
    if type == "REQUEST_KEYSTONES" then
      MythicMonday.msg:OnRequestKeystonesMessage(author)
    end
  end
end

function MythicMonday.msg:RegisterListeners()
  C_ChatInfo.RegisterAddonMessagePrefix(MythicMonday.const.ADDON_MESSAGE_PREFIX)
  MythicMonday.frames.MythicMondayFrame:RegisterEvent("CHAT_MSG_ADDON")
  MythicMonday.frames.MythicMondayFrame:SetScript("OnEvent", MythicMonday.msg.OnAddonMessage)
end

function MythicMonday.msg:OnKeyStoneMessage(author, message)
  local type, class, role, io, mapId, keystoneLevel, ilvl = MythicMonday:SplitString(message, '-')
  -- MythicMonday:Debug(MythicMonday.const.debug, "OnKeyStoneMessage: ".. author .. " (".. io ..") " .. MythicMonday:GetKeystoneLink(mapId, keystoneLevel))
  -- send to add player to roster
  MythicMonday.roster:OnMessage('OnKeyStoneMessage', author, class, role, io, MythicMonday:GetKeystoneLink(mapId, keystoneLevel), ilvl)
  -- ChatThrottleLib:SendChatMessage("BULK", MythicMonday.const.ADDON_MESSAGE_PREFIX, "OnKeyStoneMessage: ".. player .. " " .. MythicMonday:GetKeystoneLink(mapId, keystoneLevel), "PARTY")
end

function MythicMonday.msg:OnRequestKeystonesMessage(author)
  MythicMonday.msg:SendMessage(MythicMonday:GetMythicKeystoneInfo())
end