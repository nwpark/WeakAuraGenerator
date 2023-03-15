aura_env.minimumRioScoreFilter = {
    enabled = false,
    minimumRioScore = 2500,
}

aura_env.dungeonFilters = {
    AA = true,
    AV = true,
    COS = true,
    HOV = true,
    NO = true,
    RLP = true,
    SBG = true,
    TJS = true,
    givesScoreAtKeyLevel = {
        enabled = false,
        keyLevel = aura_env:GetLowestTimedKeyLevelForCurrentAffix() + 1,
    },
}

aura_env.groupMemberFilters = {
    hasSlotForPlayerRole = false,
    hasSlotsForPartyRoles = false,
    hasBloodlust = false,
    hasCurseDispel = false,
    hasPoisonDispel = false,
}
