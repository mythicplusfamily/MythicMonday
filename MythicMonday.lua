local MythicMonday = MythicMonday
MythicMonday:Init()

local renderAttempts = 1
function TryRender()
  
  local name = GetGuildRosterInfo(1)
  if not name then
    renderAttempts = renderAttempts + 1
    MythicMonday:Debug(MythicMonday.const.debug, "Render Attempt: "..renderAttempts)
    if renderAttempts >= 5 then
      return
    end
    C_Timer.After(1, TryRender)
  end
  MythicMonday:Debug(MythicMonday.const.debug, "Frame Rendered")
  MythicMonday:Render()
   -- TODO: need to sort out how i'm going to render UI before registering events
   -- attach even registration to UI creation?
  MythicMonday.events:RegisterEvents()
  TryRegisterListeners()
  -- MythicMonday.frames.MythicMondayFrame:Show()
end
-- C_Timer.After(1, TryRender)
local registerAttempts = 1
function TryRegisterListeners()
  local roster = MythicMonday.frames.MythicMondayRosterContainer
  if roster or registerAttempts >= 5 then
    MythicMonday.msg:RegisterListeners()
    return
  end
  MythicMonday:Debug(MythicMonday.const.debug, "Register Attempt: "..registerAttempts)
  registerAttempts = registerAttempts + 1
  C_Timer.After(1, TryRegisterListeners)
end

TryRender()