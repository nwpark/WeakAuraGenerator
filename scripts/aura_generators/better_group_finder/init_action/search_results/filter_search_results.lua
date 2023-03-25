function aura_env:FilterSearchResults(searchResults)
    for i = #searchResults, 1, -1 do
        if not self:DoesPassSearchResultFilters(searchResults[i]) then
            table.remove(searchResults, i)
        end
    end
end

function aura_env:DoesPassSearchResultFilters(searchResultID)
    return self:DoesPassDungeonFilters(searchResultID)
            and self:DoesPassPlayerRoleFilter(searchResultID)
            and self:DoesPassPlayerClassFilter(searchResultID)
            and self:DoesPassRioScoreFilter(searchResultID)
end

function aura_env:DoesPassPlayerRoleFilter(searchResultID)
    return (not self.modelValues.hasSlotForPlayerRole)
            or self:SearchResultHasRemainingSlotsForPlayerRole(searchResultID)
end

function aura_env:DoesPassPlayerClassFilter(searchResultID)
    return (not self.modelValues.hasSlotForPlayerClass)
            or self:SearchResultHasRemainingSlotsForPlayerClass(searchResultID)
end

function aura_env:DoesPassRioScoreFilter(searchResultID)
    if not self.modelValues.minimumRioScoreEnabled then
        return true
    end
    local leaderRioScore = self:GetLeaderInfoForSearchResult(searchResultID).rioScore
    return leaderRioScore and (leaderRioScore > self.modelValues.minimumRioScoreInput)
end

function aura_env:DoesPassDungeonFilters(searchResultID)
    local activityId = self:GetActivityIDForSearchResult(searchResultID)
    if self.ACTIVITIES[activityId] then
        local dungeonName = self.ACTIVITIES[activityId].name
        return self.modelValues[dungeonName]
    end
    return false
end
