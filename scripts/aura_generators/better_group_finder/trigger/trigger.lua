-- LFG_LIST_SEARCH_RESULT_UPDATED
-- LFG_LIST_APPLICATION_STATUS_UPDATED
-- LFG_LIST_SEARCH_RESULTS_RECEIVED

function(event, ...)
    if event == "BGF_ON_SORT_RESULTS" then
        local searchResults = ...
        aura_env:OnLFGListUtil_SortSearchResults(searchResults)
    elseif event == "BGF_ON_UPDATE" then
        local searchEntry = ...
        aura_env:OnLFGListSearchEntry_Update(searchEntry)
    elseif event == "LFG_LIST_APPLICATION_STATUS_UPDATED" then
        local searchResultID, newStatus, oldStatus, groupName = ...
        aura_env:OnApplicationStatusUpdated(searchResultID, newStatus)
    elseif event == "BGF_ON_SEARCH_RESULTS_REFRESHED" then
        aura_env:OnSearchResultsRefreshed()
    elseif event == "BGF_ON_REFRESH_BACKOFF_EXPIRED" then
        aura_env:OnRefreshBackoffExpired()
    end
end
