function aura_env:FilterSearchResults(searchResults)
    for i = #searchResults, 1, -1 do
        if self:DoesPassSearchResultFilters(searchResults[i]) then
            table.remove(searchResults, i)
        end
    end
end

function aura_env:DoesPassSearchResultFilters(searchResultID)
    return self:DoesPassDungeonFilters(searchResultID)
            and self:DoesPassPlayerRoleFilter(searchResultID)
end

function aura_env:DoesPassPlayerRoleFilter(searchResultID)
    if not self.groupMemberFilters.hasSlotForPlayerRole then
        return true
    end

    local playerClass = self:GetPlayerClass()
    local members = self:GetMembersForSearchResult(searchResultID)
    for _, member in ipairs(members) do
        if member.class == playerClass then
            return false
        end
    end
    return true
end

function aura_env:DoesPassDungeonFilters(searchResultID)
    local activityId = self:GetActivityIDForSearchResult(searchResultID)
    if self.ACTIVITIES[activityId] then
        local dungeonName = self.ACTIVITIES[activityId].name
        return not self.dungeonFilters[dungeonName]
    end
    return false
end
