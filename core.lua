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
  MythicMonday:CreateGroupsContainer()
  for i=1,8 do
    local frame = MythicMonday:GetGroupFrame()
    for j=1,5 do
      local player = MythicMonday:GetGroupPlayerFrame(frame)
    end
  end
  local roster = MythicMonday:CreateRosterContainer()
  MythicMonday:GetRosterPlayerFrame(roster)
  -- for _, frame in pairs(self.frames.MythicMondayGroupFrames) do
  --   print("index", frame:GetAttribute("index"))
  -- end
end