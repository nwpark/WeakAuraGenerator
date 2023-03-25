function aura_env:OnLFGListUtil_SortSearchResults(searchResults)
    if not (searchResults and #searchResults > 0 and self:IsDungeonFinderFrameOpen()) then
        return
    end

    self:FilterSearchResults(searchResults)
    self:SortSearchResults(searchResults)

    LFGListFrame.SearchPanel.results = searchResults
    LFGListFrame.SearchPanel.totalResults = #searchResults
    LFGListSearchPanel_UpdateResults(LFGListFrame.SearchPanel)
end
