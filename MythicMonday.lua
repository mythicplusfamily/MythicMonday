local MythicMonday = MythicMonday
MythicMonday:Init()
MythicMonday.msg:RegisterListeners()
MythicMonday.msg:SendMessage(MythicMonday:GetMythicKeystoneInfo())
local attempts = 1
function TryRender()
  
  local name = GetGuildRosterInfo(1)
  if not name or attempts > 5 then
    print("Attempt: "..attempts)
    C_Timer.After(1, TryRender)
    return
  end
  MythicMonday:Debug(MythicMonday.const.debug, "Frame Rendered")
  MythicMonday:Render()
   -- TODO: need to sort out how i'm going to render UI before registering events
   -- attach even registration to UI creation?
  MythicMonday.events:RegisterEvents()
  -- MythicMonday.frames.MythicMondayFrame:Show()
end

C_Timer.After(1, TryRender)