local MythicMonday = MythicMonday

function MythicMonday:GetClassColor(className)
  local color = MythicMonday.colors.classColors[className]
  if color then
      return color
  else
      return {red=1, green=0, blue=0}
  end
end

-- DragAndDrop handlers

function MythicMonday:HandleMouseDown(self, button)
  if button == "LeftButton" then
    self:StartMoving()
  end
end


function MythicMonday:HandleMouseUp(self, button, isInside)
  MythicMonday:Debug(MythicMonday.const.debug, "OnMouseUp:", self:GetName(), isInside)
  if button == "LeftButton" then
    self:StopMovingOrSizing()
  end
end

-- Keystones

function MythicMonday:GetMythicKeystoneInfo()
  -- Get the player's name
  local _, _, _, _, role = GetSpecializationInfoByID(GetInspectSpecialization("player"))
  -- Get the Challenge Map ID and Keystone Level
  local challengeMapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
  local keystoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()
  local keystoneSummary = C_PlayerInfo.GetPlayerMythicPlusRatingSummary("player")
  local class = UnitClass("player")
  local _, ilvl = GetAverageItemLevel()
  -- Check if the player has a Mythic+ Keystone
  if challengeMapID and keystoneLevel and keystoneSummary then
    -- Return the player's name, Challenge Map ID, and Keystone Level as a string
    local io = keystoneSummary.currentSeasonScore
    return MythicMonday:JoinStrings("-", "KEYSTONE", class, role, io, challengeMapID, keystoneLevel, ilvl)
  else
    -- Return nil indicating that the player does not have a Mythic+ Keystone
    return nil
  end
end

function MythicMonday:GetKeystoneLink(challengeMapID, keystoneLevel)
  -- Get the name of the challenge map
  local mapName = C_ChallengeMode.GetMapUIInfo(challengeMapID)

  -- Create the keystone link
  local keystoneLink = "|cffa335ee|Hkeystone:180653:" .. challengeMapID .. ":" .. keystoneLevel .. ":".. self:GetKeystoneAffixText(keystoneLevel) .."|h[Keystone: " .. mapName .. " (" .. keystoneLevel .. ")]|h|r"
  
  return keystoneLink
end

function MythicMonday:GetKeystoneAffixText(keystoneLevel)
  local stop = 1
  if tonumber(keystoneLevel) > 4 then
    stop = 2
  end
  if tonumber(keystoneLevel) > 9 then
    stop = 3
  end
  local currentAffixes = C_MythicPlus.GetCurrentAffixes()
  local affixIds = { 0, 0, 0, 0 }
  for k,v in ipairs(currentAffixes) do
    if k > stop then break end
    affixIds[k] = v.id
  end
---@diagnostic disable-next-line: deprecated
  return MythicMonday:JoinStrings(":", unpack(affixIds))
end

-- Utils

function MythicMonday:SplitString(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
---@diagnostic disable-next-line: deprecated
  return unpack(t)
end

function MythicMonday:JoinStrings(separator, ...)
  local argTable = {...}
  if not separator or #argTable == 0 then
    self:Debug(self.const.debug, "no separator:", separator, "or no strings to join", argTable)
    return ""
  end
  return table.concat(argTable, separator)
end

local debugLabels = {
  "|cffFF0000".. MythicMonday.const.ADDON_NAME .." Announce:|r",
  "|cffFFFF00".. MythicMonday.const.ADDON_NAME .." Warn:|r",
  "|cff00FF00".. MythicMonday.const.ADDON_NAME .." Info:|r",
  "|cff00FFFF".. MythicMonday.const.ADDON_NAME .." Notice:|r",
  "|cff888888".. MythicMonday.const.ADDON_NAME .." Debug:|r"
}
function MythicMonday:Debug(debugLevel, ...)
  if MythicMonday.const.isDebug and debugLevel <= MythicMonday.const.debugLevel then
    print(debugLabels[debugLevel], ...)
  end
end

function MythicMonday:LerpColor(t, color1, color2)
  local red = math.floor(color1.red + t * (color2.red - color1.red))
  local green = math.floor(color1.green + t * (color2.green - color1.green))
  local blue = math.floor(color1.blue + t * (color2.blue - color1.blue))
  return { red, green, blue }
end

function MythicMonday:GetQualityColorByIO(io)
  local color = MythicMonday.colors.qualityColors["Poor"]
  io = tonumber(io)
  if io > 3000 then
    color = MythicMonday.colors.qualityColors["Artifact"]
  elseif io > 2500 then
    color = MythicMonday.colors.qualityColors["Legendary"]
  elseif io > 2000 then
    color = MythicMonday.colors.qualityColors["Epic"]
  elseif io > 1500 then
    color = MythicMonday.colors.qualityColors["Rare"]
  elseif io > 1000 then
    color = MythicMonday.colors.qualityColors["Uncommon"]
  elseif io > 500 then
    color = MythicMonday.colors.qualityColors["Common"]
  end
  return color
end

