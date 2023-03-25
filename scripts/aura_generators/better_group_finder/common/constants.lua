aura_env.CANCELLED = "CANCELLED"
aura_env.DECLINED = "DECLINED"
aura_env.DELISTED = "DELISTED"
aura_env.OKAY = "OKAY"

aura_env.DUNGEONS = {
    AA = {name = "AA", activityId = 1160},
    AV = {name = "AV", activityId = 1180},
    COS = {name = "COS", activityId = 466},
    HOV = {name = "HOV", activityId = 461},
    NO = {name = "NO", activityId = 1184},
    RLP = {name = "RLP", activityId = 1176},
    SBG = {name = "SBG", activityId = 1193},
    TJS = {name = "TJS", activityId = 1192},
}

-- TODO: activity ids for mythic / heroic / normal
aura_env.ACTIVITIES = {
    [1160] = aura_env.DUNGEONS.AA,
    [1180] = aura_env.DUNGEONS.AV,
    [466] = aura_env.DUNGEONS.COS,
    [461] = aura_env.DUNGEONS.HOV,
    [1184] = aura_env.DUNGEONS.NO,
    [1176] = aura_env.DUNGEONS.RLP,
    [1193] = aura_env.DUNGEONS.SBG,
    [1192] = aura_env.DUNGEONS.TJS,
}

aura_env.AFFIX_IDS = {
    TYRANNICAL = 9,
    FORTIFIED = 10,
}

aura_env.WARNING_ICON = [[Interface/EncounterJournal/UI-EJ-WarningTextIcon]]
--aura_env.WARNING_ICON = [[Interface/buttons/adventureguidemicrobuttonalert.blp]]
--aura_env.WARNING_ICON = [[Interface/DialogFrame/DialogAlertIcon]]

aura_env.PROBLEMATIC_ADDON_WARNINGS = {
    ["PremadeGroupsFilter"] = "Addon detected: \"Premade Groups Filter\""
}

-- todo replace with uid instead of key
aura_env.PROBLEMATIC_WEAK_AURA_WARNINGS = {
    ["Dungeon RIO and Class"] = "WeakAura detected: \"Dungeon RIO and Class\"",
    ["Better R.IO With Colors and Best Key"] = "WeakAura detected: \"Better R.IO With Colors and Best Key\"",
    ["Better LFG Class Colors"] = "WeakAura detected: \"Better LFG Class Colors\"",
    ["Group Finder Custom Extension"] = "WeakAura detected: \"Group Finder Custom Extension\"",
    ["Dungeon RIO and Class - Extended"] = "WeakAura detected: \"Dungeon RIO and Class - Extended\"",
}
