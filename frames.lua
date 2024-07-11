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
  frame:SetPoint("TOPLEFT", padding/2, topOffset)
  frame:SetScript("OnMouseUp", function(self, button, isInside)
    MythicMonday:Debug(MythicMonday.const.debug, self:GetName(), isInside, self:GetPoint())
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
  UIDropDownMenu_SetAnchor(dropdown, dropdown:GetWidth()/2, 20, "TOPRIGHT", nil, "BOTTOMRIGHT")

  local items = {
    "\124cffa335ee\124Hitem:138019:404:140:141:142:\124h[Mythic Keystone: The Azure Vault (420)]\124h\124r",
    "\124cffa335ee\124Hitem:138019:404:140:141:142:\124h[Mythic Keystone: Neltharus (311)]\124h\124r",
    "\124cffa335ee\124Hitem:138019:404:140:141:142:\124h[Mythic Keystone: Ruby Life Pools (666)]\124h\124r",
    "\124cffa335ee\124Hitem:138019:404:140:141:142:\124h[Mythic Keystone: That One That Sucks (-1)]\124h\124r",
    "\124cffa335ee\124Hitem:138019:404:140:141:142:\124h[Mythic Keystone: I Hate This Game (69)]\124h\124r",
  }
  local function OnClick(self, arg1, arg2)
    UIDropDownMenu_SetSelectedID(dropdown, self:GetID())
    MythicMonday:Debug(MythicMonday.const.debug, "OnClick: ", arg1, arg2)
    -- get containing group container
    -- get child frames
    -- get names of characters in those frames
    -- send message to player with addon with group info and command to invite
    -- else whisper tank/healer/fallback to invite the rest of the group 
  end
  local function initialize(self, level)
    local info = UIDropDownMenu_CreateInfo()

    -- get all players in the row
    -- extract attribute holding keystone string
    -- set item [index] to keystone string

    for index, value in pairs(items) do
        -- MythicMonday:Debug(MythicMonday.const.debug, "Dropdown initialize: index, value", index, value)
        info = UIDropDownMenu_CreateInfo()
        info.text = value -- maybe parse and shorten to the dungeon acronym?
        -- info.value = index
        info.arg1 = index
        info.arg2 = value
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
  frame:SetPoint("TOPLEFT", rosterContainer, "TOPLEFT", 0, -top)
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
      -- MythicMonday:Debug(MythicMonday.const.debug, select(2, unpack(frame:GetAttribute("previousPosition"))):GetName())
      local x, y = GetCursorPosition()
      frame:SetAttribute("startingCursor", { x, y })
      frame:StartMoving(true)
    end)
    frame:SetScript("OnDragStop", function()
      frame:StopMovingOrSizing()
      -- if is valid drop, set parent to new container, 
      -- if is invalid drop, reset position to previous position
---@diagnostic disable-next-line: param-type-mismatch, deprecated
      local point, relativeTo, relativePoint, offsetX, offsetY = unpack(frame:GetAttribute("previousPosition"))
      local parentWidth = relativeTo:GetWidth()
      local frameHeight = relativeTo:GetHeight()
      local scale = UIParent:GetEffectiveScale()
      local prevX, prevY = unpack(frame:GetAttribute("startingCursor"))
      local currX, currY = GetCursorPosition()
      
      local diffX = (currX - prevX) / scale
      local diffY = (currY - prevY) / scale

      local heightAbove = offsetY
      local heightBelow = frameHeight - offsetY

      -- MythicMonday:Debug(MythicMonday.const.debug, "diffY, heightAbove, heightBelow", diffY, heightAbove, heightBelow)

      local isInsideGroupsContainerX = diffX > parentWidth and diffX < MythicMonday.frames.MythicMondayFrame:GetWidth()
      local isInsideGroupsContainerY = false
      if diffY > 0 and diffY < heightAbove then
        isInsideGroupsContainerY = true
      elseif diffY <= 0 and abs(diffY) < heightBelow then
        isInsideGroupsContainerY = true
      end
      
      MythicMonday:Debug(MythicMonday.const.debug, "isInsideGroupsContainerX, isInsideGroupsContainerY", isInsideGroupsContainerX, isInsideGroupsContainerY)
      -- MythicMonday:Debug(MythicMonday.const.debug, "frameParent, relativeTo", frame:GetParent():GetName(), relativeTo:GetName())
      -- MythicMonday:Debug(MythicMonday.const.debug, "point, relativeTo, relativePoint, offsetX, offsetY", point, relativeTo:GetName(), relativePoint, offsetX, offsetY)
      MythicMonday:Debug(MythicMonday.const.debug, "movement", diffX, diffY)
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