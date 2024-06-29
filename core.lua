MythicMonday = MythicMonday or {}

local function SlashCommand(arg) 
  if arg == "s" or arg == "show" then
    if (MythicMonday.frames.MythicMondayFrame:IsShown()) then
      MythicMonday.frames.MythicMondayFrame:Hide()
    else
      MythicMonday.frames.MythicMondayFrame:Show()
    end
  end
end


function MythicMonday:Init()
  local addonName = "MythicMonday"
  SLASH_MythicMonday1 = "/mm"
  SlashCmdList[addonName] = SlashCommand
  MythicMonday:CreateMainFrame()
  MythicMonday:Render()
end

function MythicMonday:Render()
  MythicMonday:CreateGroupsContainer()
  for i=1,8 do
    local groupFrame = MythicMonday:GetGroupFrame()
    for j=1,5 do
      local name, _, _, _, class = GetGuildRosterInfo(i * j)
      local player = MythicMonday:GetGroupPlayerFrame(groupFrame, name, class)
    end
  end
  local roster = MythicMonday:CreateRosterContainer()
  for i=41,51 or GetNumGuildMembers() do
    local name, _, _, _, class = GetGuildRosterInfo(i)
    local frame = MythicMonday:GetRosterPlayerFrame(roster, name, class)
  end
end