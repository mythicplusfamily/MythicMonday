MythicMonday = MythicMonday or {}

local function SlashCommand(arg) 
  if arg == "s" or arg == "show" then
    if (MythicMonday.frames.MythicMondayFrame:IsShown()) then
      MythicMonday.frames.MythicMondayFrame:Hide()
    else
      MythicMonday.frames.MythicMondayFrame:Show()
    end
  end
  if arg == "debug" then
    MythicMonday.const.isDebug = not MythicMonday.const.isDebug
  end
end


function MythicMonday:Init()
  local addonName = "MythicMonday"
  SLASH_MythicMonday1 = "/mm"
  SlashCmdList[addonName] = SlashCommand
  MythicMonday:CreateMainFrame()
  MythicMonday:CreateRosterContainer()
end

function MythicMonday:Render()
  MythicMonday:CreateGroupsContainer()
  local guildIndex = 1
  for i=1,4 do
    local groupFrame = MythicMonday:GetGroupFrame()
    for j=1,5 do
      local name, _, _, _, class = GetGuildRosterInfo(guildIndex)
      if not name then return end
      local player = MythicMonday:GetGroupPlayerFrame(groupFrame, name, class, guildIndex * 150) -- math.random(2000,3000))
      guildIndex = guildIndex + 1
    end
  end
  -- local roster = MythicMonday:CreateRosterContainer()
  -- for i=41,51 or GetNumGuildMembers() do
  --   local name, _, _, _, class = GetGuildRosterInfo(i)
  --   local frame = MythicMonday:GetRosterPlayerFrame(roster, name, class, math.random(2000,3000))
  -- end
end