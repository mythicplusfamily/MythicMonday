local MythicMonday = MythicMonday

MythicMonday.msg = MythicMonday.msg or {}

function MythicMonday.msg:SendMessage(data)
  print("sending message", data)
  -- C_ChatInfo.SendAddonMessage(MythicMonday.const.ADDON_MESSAE_PREFIX, data, "GUILD")
  ChatThrottleLib:SendAddonMessage("BULK", MythicMonday.const.ADDON_MESSAE_PREFIX, tostring(data), "PARTY")
end

function MythicMonday.msg:OnAddonMessage(event, prefix, message, channel, sender)
  if event == "CHAT_MSG_ADDON" and prefix == MythicMonday.const.ADDON_MESSAE_PREFIX then
    -- print("event, prefix, message, channel, sender", event, prefix, message, channel, sender)
    local type = MythicMonday:SplitString(message, '-')
    if type == "KEYSTONE" then
      MythicMonday.msg:OnKeyStoneMessage(sender, message)
    end
  end
end

function MythicMonday.msg:RegisterListeners()
  C_ChatInfo.RegisterAddonMessagePrefix(MythicMonday.const.ADDON_MESSAE_PREFIX)
  MythicMonday.frames.MythicMondayFrame:RegisterEvent("CHAT_MSG_ADDON")
  MythicMonday.frames.MythicMondayFrame:SetScript("OnEvent", MythicMonday.msg.OnAddonMessage)
end

function MythicMonday.msg:OnKeyStoneMessage(player, message)
  local type, role, mapId, keystoneLevel = MythicMonday:SplitString(message, '-')
  print("OnKeyStoneMessage: ".. player .. " " .. MythicMonday:GetKeystoneLink(mapId, keystoneLevel))
  ChatThrottleLib:SendChatMessage("BULK", MythicMonday.const.ADDON_MESSAE_PREFIX, "OnKeyStoneMessage: ".. player .. " " .. MythicMonday:GetKeystoneLink(mapId, keystoneLevel), "PARTY")
end