local MythicMonday = MythicMonday

function MythicMonday:AddPlayerToRoster(player)
  
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
  local argTable = {...}
  return table.concat(argTable, separator)
end
