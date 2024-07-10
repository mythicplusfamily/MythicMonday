local MythicMonday = MythicMonday
MythicMonday.frames = MythicMonday.frames or {}
MythicMonday.frames.MythicMondayGroupFrames = {}
MythicMonday.frames.MythicMondayPlayerFrames = {}

function MythicMonday:CreateMainFrame()
  self.frames.MythicMondayFrame = CreateFrame("Frame", "MythicMondayContainer", UIParent, "MythicMondayContainerTemplate")
  self.frames.MythicMondayFrame:SetPoint("CENTER")
  self.frames.MythicMondayFrame:SetMovable(true)
  self.frames.MythicMondayFrame:EnableMouse(true)
  self.frames.MythicMondayTitleFrame = CreateFrame("Frame", "MythicMondayContainerTitle", self.frames.MythicMondayFrame, "MythicMondayContainerTitleTemplate")
  local title = self.frames.MythicMondayTitleFrame
  title:EnableMouse(true)
  title:SetScript(
    "OnMouseDown",
    function(self, button)
      MythicMonday:HandleMouseDown(MythicMonday.frames.MythicMondayFrame, button)
    end
  )
  title:SetScript(
    "OnMouseUp",
    function(self, button, isInside)
      MythicMonday:HandleMouseUp(MythicMonday.frames.MythicMondayFrame, button, isInside)
    end
  )
  -- self.frames.MythicMondayFrame:RegisterForDrag("LeftButton")
  -- self.frames.MythicMondayFrame:SetScript("OnDragStart", self.frames.MythicMondayFrame.StartMoving)
  -- self.frames.MythicMondayFrame:SetScript("OnDragStop", self.frames.MythicMondayFrame.StopMovingOrSizing)
  -- local title = CreateFrame("Frame", "MythicMondayContainerTitle", self.frames.MythicMondayFrame, "MythicMondayContainerTitleTemplate")
  -- title:SetPoint("TOP", 0, -20)
  if not self.const.isDebug then 
    tinsert(UISpecialFrames, self.frames.MythicMondayFrame:GetName())
  end
end

function MythicMonday:CreateRosterContainer()
  self.frames.MythicMondayRosterContainer = CreateFrame("Frame", "MythicMondayRosterContainer", self.frames.MythicMondayFrame, "MythicMondayRosterContainerTemplate")
  self.frames.MythicMondayRosterContainer:EnableMouse(true)
  local title = self.frames.MythicMondayRosterContainer:CreateFontString("RosterTitle", "OVERLAY", "GameFontNormal")
  title:SetPoint("TOP", 0, -15)
  title:SetText("Roster")
  return self.frames.MythicMondayRosterContainer
end

function MythicMonday:CreateGroupsContainer()
  self.frames.MythicMondayGroupsContainer = CreateFrame("Frame", "MythicMondayGroupsContainer", self.frames.MythicMondayFrame, "MythicMondayGroupsContainerTemplate")
  return self.frames.MythicMondayGroupsContainer
end

function MythicMonday:GetGroupFrame()
  local frame
  local length = #self.frames.MythicMondayGroupFrames
  if length == 0 then
    frame = self:CreateGroupFrame(length)
    frame:SetAttribute("inUse", true)
    return frame
  end
  for _,f in pairs(self.frames.MythicMondayGroupFrames) do
    if not f:GetAttribute("inUse") then
      frame = f
      break
    end

    if not frame then
      frame = self:CreateGroupFrame(length)
    end
    frame:SetAttribute("inUse", true)
    return frame
  end
end

function MythicMonday:CreateGroupFrame(index)
  index = index or 0
  index = index + 1
  local padding = 20
  local groupContainer = self.frames.MythicMondayGroupsContainer
  local groupContainerHeight = groupContainer:GetHeight()
  local groupContainerWidth = groupContainer:GetWidth()
  local groupWidth = groupContainerWidth - padding
  local groupHeight, topOffset = self:ComputeItemHeightAndOffset(index, groupContainerHeight, padding, self.const.MAX_GROUPS)
  local frame = CreateFrame("Frame", "GroupFrame"..index, groupContainer, "MythicMondayGroupTemplate")
  frame:SetAttribute("index", index)
  frame:SetSize(groupWidth, groupHeight)
  frame:SetPoint("LEFT", padding/2, 0)
  frame:SetPoint("TOP", 0, topOffset)
  frame:SetScript("OnMouseUp", function(self, button, isInside)
    print("mouseUp", isInside, self:GetName())
  end)
  table.insert(self.frames.MythicMondayGroupFrames, frame)
  self:CreateKeystoneDropdown(frame)
  return frame
end

function MythicMonday:CreateKeystoneDropdown(frame) 
  local dropdown = CreateFrame("Frame", "$parentKeystoneDropdown", frame, "UIDropDownMenuTemplate")
  dropdown:SetPoint("RIGHT", 0, 0)
  -- dropdown:SetWidth(frame:GetWidth()/6)
  -- UIDropDownMenu_SetWidth(dropdown, frame:GetWidth() / 6)
  dropdown:SetWidth(80)
  UIDropDownMenu_SetWidth(dropdown, 80)
  UIDropDownMenu_SetText(dropdown, "Select a Keystone")
  local items = {
    "Keystone 1",
    "Keystone 2",
    "Keystone 3",
    "Keystone 4",
    "Keystone 5",
  }
  local function OnClick(self, value1, value2, isChecked)
    UIDropDownMenu_SetSelectedID(dropdown, self:GetID())
    MythicMonday:Debug(MythicMonday.const.debug, "OnClick: value1, value2, isChecked", self:GetName(), value1, value2, isChecked)
    -- MythicMonday.msg:SendMessage(MythicMonday:GetMythicKeystoneInfo())
  end
  local function initialize(self, level)
    local info = UIDropDownMenu_CreateInfo()

    -- get all players in the row
    -- extract attribute holding keystone string
    -- set item [index] to keystone string

    for index, value in pairs(items) do
        MythicMonday:Debug(MythicMonday.const.debug, "Dropdown initialize: index, value", index, value)
        info = UIDropDownMenu_CreateInfo()
        info.text, info.arg1 = "Index: " .. index, value
        info.func = OnClick
        UIDropDownMenu_AddButton(info, level)
    end
    return dropdown
  end

  UIDropDownMenu_Initialize(dropdown, initialize)
  UIDropDownMenu_SetSelectedID(dropdown, 1)
end

function MythicMonday:ComputeItemHeightAndOffset(index, parentHeight, padding, numItems)
  -- Calculate the total padding space needed for all items
  local totalPadding = (numItems - 1) * padding
  -- Calculate the height available for all items after padding
  local availableHeight = parentHeight - totalPadding
  -- Calculate the height of each item
  local itemHeight = availableHeight / numItems
  -- Calculate the top offset for the item at the given index
  local topOffset = - (index - 1) * (itemHeight + padding)

  return itemHeight, topOffset
end

function MythicMonday:GetRosterPlayerFrame(rosterContainer, name, class, io, ilvl)
  local frame = self:GetPlayerFrame(rosterContainer)
  -- local padding = 0
  -- local containerHeight = rosterContainer:GetHeight()
  local containerWidth = rosterContainer:GetWidth()
  -- local availableHeight = containerHeight - (padding * 2)
  local playerWidth = containerWidth --(availableHeight/6) - padding
  local playerHeight = 40 -- groupContainerHeight - (padding * 2)
  frame:SetSize(playerWidth, playerHeight)
  local numChildren = select("#", rosterContainer:GetChildren())
  local top = playerHeight * numChildren
  frame:SetPoint("TOP", rosterContainer, "TOP", 0, -top)
  local red, green, blue = MythicMonday:GetPlayerIOColor(io)
  frame:SetBackdropColor(red, green, blue, 1)
  local playerName = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  playerName:SetPoint("CENTER")
  playerName:SetText(name .. " |cffffd700" .. (ilvl or ""))
  local color = MythicMonday:GetClassColor(class)
  playerName:SetTextColor(color.red, color.green, color.blue, 1)
  return frame
end

function MythicMonday:GetGroupPlayerFrame(groupContainer, name, class, io)
  local frame = self:GetPlayerFrame(groupContainer)
  local padding = 0
  local groupContainerHeight = groupContainer:GetHeight()
  local groupContainerWidth = groupContainer:GetWidth()
  local availableWidth = groupContainerWidth - (padding * 2)
  local playerWidth = (availableWidth/6) - padding
  local playerHeight = groupContainerHeight - (padding * 2)
  frame:SetSize(playerWidth, playerHeight)
  frame:SetPoint("TOPLEFT", groupContainer, "TOPLEFT", playerWidth * ((frame:GetAttribute("index") % 5)), 0)
  local red, green, blue = MythicMonday:GetPlayerIOColor(io)
  frame:SetBackdropColor(red, green, blue, 1)
  local playerName = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  playerName:SetPoint("CENTER")
  playerName:SetText(name .. " |cffffd700" .. io)
  local color = MythicMonday:GetClassColor(class)
  playerName:SetTextColor(color.red, color.green, color.blue, 1)
  return frame
end

function MythicMonday:GetPlayerFrame(container)
  local frame
  local length = #self.frames.MythicMondayPlayerFrames
  if length == 0 then
    frame = self:CreatePlayerFrame(length, container)
    frame:SetAttribute("inUse", true)
    return frame
  end
  for _,f in pairs(self.frames.MythicMondayPlayerFrames) do
    if not f:GetAttribute("inUse") then
      frame = f
      break
    end

    if not frame then
      frame = self:CreatePlayerFrame(length, container)
    end
    frame:SetAttribute("inUse", true)
    return frame
  end
end

function MythicMonday:CreatePlayerFrame(index, container)
  index = index or 0
  local frame = CreateFrame("Frame", "PlayerFrame"..index, container, "BackdropTemplate")
  frame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    insets = { left = 0, right = 0, top = 0, bottom = 0 },
  })
  frame:SetBackdropColor(0, 0, 0, 0.75) 
  frame:SetAttribute("index", index)
  if MythicMonday.featureflags.DraggablePlayerFrames then
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function()
      frame:SetAttribute("previousPosition", {frame:GetPoint()})
      frame:StartMoving()
    end)
    frame:SetScript("OnDragStop", function()
      frame:StopMovingOrSizing()
      -- if is valid drop, set parent to new container, 
      -- if is invalid drop, reset position to previous position
---@diagnostic disable-next-line: param-type-mismatch, deprecated
      local point, relativeTo, relativePoint, offsetX, offsetY = unpack(frame:GetAttribute("previousPosition"))
      frame:SetPoint(point, relativeTo, relativePoint, offsetX, offsetY)
      -- local parent = frame:GetParent()
      -- if parent then
      --   print(frame:GetAttribute("previousPosition"))
      --   MythicMonday:Debug(MythicMonday.const.debug, parent:GetName(), point, relativeTo, relativePoint, offsetX, offsetY)
      -- end
    end)
  end
  table.insert(self.frames.MythicMondayPlayerFrames, frame)
  return frame
end

function MythicMonday:ReleaseFrame(frame)
  frame:Hide()
  frame:SetAttribute("inUse", false)
end