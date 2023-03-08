-- LFG_LIST_APPLICATION_STATUS_UPDATED: searchResultID, newStatus, oldStatus, groupName

-- LFG_LIST_SEARCH_RESULT_UPDATED
-- LFG_LIST_APPLICATION_STATUS_UPDATED
-- LFG_LIST_SEARCH_RESULTS_RECEIVED

-- BGF_ON_UPDATE
-- BGF_ON_SORT_RESULTS

-- LFG_LIST_APPLICATION_STATUS_UPDATED, BGF_ON_SORT_RESULTS, BGF_ON_UPDATE

function(event, ...)
    if event == "BGF_ON_SORT_RESULTS" then
        local searchResults = ...
        if not searchResults then
            return
        end
        aura_env:OnLFGListUtil_SortSearchResults(searchResults)
    elseif event == "BGF_ON_UPDATE" then
        local searchEntry = ...
        if not searchEntry then
            return
        end
        aura_env:OnLFGListSearchEntry_Update(searchEntry)
    elseif event == "LFG_LIST_APPLICATION_STATUS_UPDATED" then
        local searchResultID, status = ...
        if not searchResultID and status then
            return
        end

        local leaderName = aura_env:GetLeaderNameForSearchEntry(searchResultID)

        if leaderName == "" then
            return
        end

        if status == "applied" then
            aura_env.cancelled[leaderName] = nil
            aura_env.declined[leaderName] = nil
        elseif status == "cancelled" then
            aura_env.cancelled[leaderName] = true
        elseif status == "declined" then
            aura_env.declined[leaderName] = true
        end
    end
end
