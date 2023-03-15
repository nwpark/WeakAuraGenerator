function aura_env:GetRioScore(playerName)
    local normalizedPlayerName = self:GetNormalizedPlayerName(playerName)
    local playerFactionID = self:GetPlayerFactionID()
    local playerProfile = RaiderIO and RaiderIO.GetProfile(normalizedPlayerName, playerFactionID)
    if not (playerProfile and playerProfile.mythicKeystoneProfile) then
        return nil
    end

    return playerProfile.mythicKeystoneProfile.currentScore
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
