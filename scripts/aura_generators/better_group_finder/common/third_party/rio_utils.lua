function aura_env:GetRioScore(playerName)
    local keystoneProfile = self:GetRioKeystoneProfile(playerName)
    return keystoneProfile and keystoneProfile.currentScore
end

function aura_env:GetMainRioScore(playerName)
    local keystoneProfile = self:GetRioKeystoneProfile(playerName)
    return keystoneProfile
            and keystoneProfile.mainCurrentScore
            and keystoneProfile.mainCurrentScore > 0
            and keystoneProfile.mainCurrentScore
end

function aura_env:GetRioKeystoneProfile(playerName)
    local normalizedPlayerName = self:GetNormalizedPlayerName(playerName)
    local playerFactionID = self:GetPlayerFactionID()
    local playerProfile = RaiderIO and RaiderIO.GetProfile(normalizedPlayerName, playerFactionID)
    return playerProfile and playerProfile.mythicKeystoneProfile
end

function aura_env:FormatRioScore(rioScore)
    local r, g, b = RaiderIO.GetScoreColor(rioScore)
    return "|cff" .. self:RgbColorToHex(r, g, b) .. tostring(rioScore) .. "|r"
end

function aura_env:DungeonGivesScoreAtKeyLevel(dungeonName, keyLevel)
    local bestDungeonRunsForCurrentAffix = self:GetBestDungeonRunsForCurrentAffix()
    return bestDungeonRunsForCurrentAffix[dungeonName] < keyLevel
end

function aura_env:GetLowestTimedKeyLevelForCurrentAffix()
    local bestDungeonRunsForCurrentAffix = self:GetBestDungeonRunsForCurrentAffix()
    local lowestTimedKeyLevel = math.huge
    for _, keyLevel in pairs(bestDungeonRunsForCurrentAffix) do
        if keyLevel < lowestTimedKeyLevel then
            lowestTimedKeyLevel = keyLevel
        end
    end
    return lowestTimedKeyLevel
end

function aura_env:GetBestDungeonRunsForCurrentAffix()
    local bestDungeonRuns = {}
    for _, sortedDungeon in pairs(RaiderIO.GetProfile("player").mythicKeystoneProfile.sortedDungeons) do
        local dungeonName = sortedDungeon.dungeon.shortName
        if self:IsTyrannicalWeek() then
            bestDungeonRuns[dungeonName] = sortedDungeon.tyrannicalLevel
        else
            bestDungeonRuns[dungeonName] = sortedDungeon.fortifiedLevel
        end
    end
    return bestDungeonRuns
end
