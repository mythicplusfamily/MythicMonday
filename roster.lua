local MythicMonday = MythicMonday

MythicMonday.roster = MythicMonday.roster or {}

function MythicMonday.roster:OnMessage(event, author, class, role, io, message, ilvl)
  local keystone = FindKeystoneLink(message)
  if keystone then
    MythicMonday:Debug(MythicMonday.const.debug, event, author, class, role, io, keystone, ilvl)
    MythicMonday.roster:AddPlayerToRoster(author, class, role, io, keystone, ilvl)
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

function MythicMonday.roster:AddPlayerToRoster(name, class, role, io, keystone, ilvl)
  local rosterContainer = MythicMonday.frames.MythicMondayRosterContainer
  local rosterChildren = rosterContainer:GetChildren()
  if rosterChildren then
    MythicMonday:Debug(MythicMonday.const.debug, "Length: ", #rosterChildren)
  end
  for key, value in pairs(rosterChildren or {}) do
    if key == 0 then
      -- MythicMonday:Debug(MythicMonday.const.debug, "rosterChildren: key, value", key, value:GetName())
    end
    -- MythicMonday:Debug(MythicMonday.const.debug, "rosterChildren: key, value", key, value)
  end
  if not rosterContainer then
    MythicMonday:Debug(MythicMonday.const.warn, "No roster container found")
  end
  local rosterPlayerFrame = MythicMonday:GetRosterPlayerFrame(rosterContainer, name, class, io, ilvl)
  rosterPlayerFrame:SetAttribute("character", {
    name,
    class,
    role,
    io,
    ilvl,
    keystone
  })
  rosterPlayerFrame:SetScript("OnMouseDown", function() 
---@diagnostic disable-next-line: deprecated
    MythicMonday:Debug(MythicMonday.const.debug, unpack(rosterPlayerFrame:GetAttribute("character")))
  end)
---@diagnostic disable-next-line: deprecated
  MythicMonday:Debug(MythicMonday.const.debug, "AddPlayerToRoster", unpack(rosterPlayerFrame:GetAttribute("character")))
end