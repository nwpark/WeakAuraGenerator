aura_env.REFRESH_SEARCH_RESULTS_BACKOFF_DELAY = 5


-- Hooked to secure function
-- todo: aura_env.secureFunctionHooks.OnSearchResultsRefreshed?
function aura_env:OnSearchResultsRefreshed()
    self:DisableRefreshButton()
    self:ShowRefreshButtonCooldown(self.REFRESH_SEARCH_RESULTS_BACKOFF_DELAY)
    C_Timer.NewTimer(self.REFRESH_SEARCH_RESULTS_BACKOFF_DELAY, function()
        WeakAuras.ScanEvents("BGF_ON_REFRESH_BACKOFF_EXPIRED")
    end)
end

-- Hooked to event
-- todo: aura_env.eventHooks.OnSearchResultsRefreshed?
function aura_env:OnRefreshBackoffExpired()
    self:EnableRefreshButton()
    if self.modelValues.autoRefresh then
        -- todo: check if cursor is in frame etc etc
        --self.enabled
        --        and (self.BACKGROUND_REFRESH_ENABLED or self.CheckBox:IsShown())
        --        and (not self.CheckBox:IsVisible() or not MouseIsOver(PVEFrame))
        --        and not self.ApplicationDialog:IsVisible()
        --        and not self.SearchBox:HasFocus()
        self:RefreshSearchResults()
    end
end

function aura_env:RefreshSearchResults()
    LFGListFrame.SearchPanel.RefreshButton:Click()
    WeakAuras.ScanEvents("BGF_ON_SEARCH_RESULTS_REFRESHED")
end

function aura_env:EnableRefreshButton()
    LFGListFrame.SearchPanel.RefreshButton:Enable()
    LFGListFrame.SearchPanel.RefreshButton.Icon:Show()
end

function aura_env:DisableRefreshButton()
    LFGListFrame.SearchPanel.RefreshButton:Disable()
    LFGListFrame.SearchPanel.RefreshButton.Icon:Hide()
end
