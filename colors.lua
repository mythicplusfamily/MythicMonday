local MythicMonday = MythicMonday
MythicMonday.colors = MythicMonday.colors or {}

MythicMonday.colors.qualityColors = {
    Poor = { red = 0.6157, green = 0.6157, blue = 0.6157 },      -- Gray
    Common = { red = 1, green = 1, blue = 1 },   -- White
    Uncommon = { red = 0.1176, green = 1, blue = 0 },          -- Green
    Rare = { red = 0, green = 0.4392, blue = 0.8667 },             -- Blue
    Epic = { red = 0.6392, green = 0.2078, blue = 0.9333 },      -- Purple
    Legendary = { red = 1, green = 0.502, blue = 0 },        -- Orange
}

MythicMonday.colors.classColors = {
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