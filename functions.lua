local MythicMonday = MythicMonday

function MythicMonday:GetClassColor(className)
  -- Mapping of class names to their colors
  local classColors = {
      ["Warrior"] = {red = 0.78, green = 0.61, blue = 0.43},
      ["Paladin"] = {red = 0.96, green = 0.55, blue = 0.73},
      ["Hunter"] = {red = 0.67, green = 0.83, blue = 0.45},
      ["Rogue"] = {red = 1.00, green = 0.96, blue = 0.41},
      ["Priest"] = {red = 1.00, green = 1.00, blue = 1.00},
      ["Death Knight"] = {red = 0.77, green = 0.12, blue = 0.23},
      ["Shaman"] = {red = 0.00, green = 0.44, blue = 0.87},
      ["Mage"] = {red = 0.41, green = 0.80, blue = 0.94},
      ["Warlock"] = {red = 0.58, green = 0.51, blue = 0.79},
      ["Monk"] = {red = 0.00, green = 1.00, blue = 0.59},
      ["Druid"] = {red = 1.00, green = 0.49, blue = 0.04},
      ["Demon Hunter"] = {red = 0.64, green = 0.19, blue = 0.79},
      ["Evoker"] = {red = 0.20, green = 0.58, blue = 0.50}
  }

  -- Get the color for the given class name
  local color = classColors[className]

  -- Check if the color was found
  if color then
      -- Return the color
      return color
  else
      -- Return an error message if the class name is not recognized
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
  MythicMonday:Debug(MythicMonday.const.d_debug, isInside)
  if button == "LeftButton" then
    self:StopMovingOrSizing()
  end
end

-- KEYSTONE

function MythicMonday:GetMythicKeystoneInfo()
  -- Get the player's name
  local _, _, _, _, role = GetSpecializationInfoByID(GetInspectSpecialization("player"))
  -- Get the Challenge Map ID and Keystone Level
  local challengeMapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
  local keystoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()

  -- Check if the player has a Mythic+ Keystone
  if challengeMapID and keystoneLevel then
    -- Return the player's name, Challenge Map ID, and Keystone Level as a string
    return MythicMonday:JoinStrings("-", "KEYSTONE", role, challengeMapID, keystoneLevel)
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
  return MythicMonday:JoinStrings(":", unpack(affixIds))
end

-- UTILS

function MythicMonday:SplitString(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return unpack(t)
end

function MythicMonday:JoinStrings(separator, ...)
  if not separator then
    self:Debug(self.const.d_warn, "no separator")
    return ""
  end
  local argTable = {...}
  return table.concat(argTable, separator)
end

function MythicMonday:Debug(debugLevel, ...)
  if MythicMonday.const.isDebug and debugLevel <MythicMonday.const.debugLevel then
    print(debugLevel, ...)
  end
end