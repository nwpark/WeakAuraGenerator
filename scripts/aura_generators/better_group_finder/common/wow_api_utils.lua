aura_env.PLAYER_ROLE_STRINGS = {
    DAMAGER = "dps",
    HEALER = "healer",
    TANK = "tank"
}

function aura_env:GetNormalizedPlayerName(playerName)
    if string.match(playerName, "-") then
        return playerName
    end

    local realmName = string.gsub(GetRealmName(), " ", "")
    return playerName .. "-" .. realmName
end

function aura_env:IsDungeonFinderFrameOpen()
    if not (LFGListFrame and LFGListFrame.SearchPanel) then
        return false
    end

    return LFGListFrame.SearchPanel:IsShown() and LFGListFrame.SearchPanel.categoryID == 2
end

function aura_env:GetPlayerFactionID()
    local factions = { Alliance = 1, Horde = 2, Neutral = 3 }
    return factions[UnitFactionGroup("player")]
end

function aura_env:GetCurrentPlayerRoleString()
    local playerRole = self:GetCurrentPlayerRole()
    return self.PLAYER_ROLE_STRINGS[playerRole]
end

function aura_env:GetCurrentPlayerRole()
    return GetSpecializationRole(GetSpecialization())
end

function aura_env:GetCurrentWeeklyAffixString()
    if self:IsTyrannicalWeek() then
        return "Tyrannical"
    end
    return "Fortified"
end

function aura_env:IsTyrannicalWeek()
    return self:GetCurrentWeeklyAffix() == self.AFFIX_IDS.TYRANNICAL
end

function aura_env:IsFortifiedWeek()
    return self:GetCurrentWeeklyAffix() == self.AFFIX_IDS.FORTIFIED
end

function aura_env:GetCurrentWeeklyAffix()
    C_MythicPlus.GetCurrentAffixes()
    for _, affixInfo in pairs(C_MythicPlus.GetCurrentAffixes()) do
        if affixInfo.id == self.AFFIX_IDS.TYRANNICAL then
            return self.AFFIX_IDS.TYRANNICAL
        elseif affixInfo.id == self.AFFIX_IDS.FORTIFIED then
            return self.AFFIX_IDS.FORTIFIED
        end
    end
end

function aura_env:RefreshLFGSearchResults()
    LFGListSearchPanel_DoSearch(LFGListFrame.SearchPanel)
end

function aura_env:GetPlayerClass()
    local _, className = UnitClass("player")
    return className
end
