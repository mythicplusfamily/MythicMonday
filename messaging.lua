local MythicMonday = MythicMonday

MythicMonday.msg = MythicMonday.msg or {}

function MythicMonday.msg:SendMessage(data)
  if not data then return end
  MythicMonday:Debug(MythicMonday.const.info, "sending message", data)
  -- C_ChatInfo.SendAddonMessage(MythicMonday.const.ADDON_MESSAGE_PREFIX, data, "GUILD")
  ChatThrottleLib:SendAddonMessage("BULK", MythicMonday.const.ADDON_MESSAGE_PREFIX, tostring(data), "GUILD")
end

function MythicMonday.msg:OnAddonMessage(event, prefix, message, channel, author)
  if event == "CHAT_MSG_ADDON" and prefix == MythicMonday.const.ADDON_MESSAGE_PREFIX then
    MythicMonday:Debug(MythicMonday.const.info, "event, prefix, message, channel, author", event, prefix, message, channel, author)
    local type = MythicMonday:SplitString(message, '-')
    if type == "KEYSTONE" then
      MythicMonday.msg:OnKeyStoneMessage(author, message)
    end
  end
end

function MythicMonday.msg:RegisterListeners()
  MythicMonday.frames.MythicMondayFrame = _G["MythicMondayContainer"]
  C_ChatInfo.RegisterAddonMessagePrefix(MythicMonday.const.ADDON_MESSAGE_PREFIX)
  -- TODO: probably make an invisible frame to listen for events
  if not MythicMonday.frames.MythicMondayFrame then
    return
  end
  MythicMonday.frames.MythicMondayFrame:RegisterEvent("CHAT_MSG_ADDON")
  MythicMonday.frames.MythicMondayFrame:SetScript("OnEvent", MythicMonday.msg.OnAddonMessage)
end

function MythicMonday.msg:OnKeyStoneMessage(author, message)
  local type, role, mapId, keystoneLevel = MythicMonday:SplitString(message, '-')
  MythicMonday:Debug(MythicMonday.const.debug, "OnKeyStoneMessage: ".. author .. " " .. MythicMonday:GetKeystoneLink(mapId, keystoneLevel))
  MythicMonday.roster:OnMessage("CHAT_MSG_ADDON", author, message)
  -- ChatThrottleLib:SendChatMessage("BULK", MythicMonday.const.ADDON_MESSAGE_PREFIX, "OnKeyStoneMessage: ".. player .. " " .. MythicMonday:GetKeystoneLink(mapId, keystoneLevel), "PARTY")
end