function aura_env:InitializeHooks()
    hooksecurefunc("LFGListUtil_SortSearchResults", function(searchEntry)
        WeakAuras.ScanEvents("BGF_ON_SORT_RESULTS", searchEntry)
        --return self:OnLFGListUtil_SortSearchResults(searchEntry)
    end)
    hooksecurefunc("LFGListSearchEntry_Update", function(searchEntry)
        WeakAuras.ScanEvents("BGF_ON_UPDATE", searchEntry)
    end)

    PVEFrame:HookScript("OnShow", function() self:ShowOptionsFrame() end)
    PVEFrame:HookScript("OnHide", function() self:HideOptionsFrame() end)

    hooksecurefunc("LFGListSearchEntry_OnClick", function(searchEntry, button)
        local panel = LFGListFrame.SearchPanel
        if button ~= "RightButton" and LFGListSearchPanelUtil_CanSelectResult(searchEntry.resultID) and panel.SignUpButton:IsEnabled() then
            if panel.selectedResult ~= searchEntry.resultID then
                LFGListSearchPanel_SelectResult(panel, searchEntry.resultID)
            end
            LFGListSearchPanel_SignUp(panel)
        end
    end)
    LFGListApplicationDialog:HookScript("OnShow", function(self)
        if self.SignUpButton:IsEnabled() and not IsShiftKeyDown() then
            self.SignUpButton:Click()
        end
    end)
end

function aura_env:OnShow()
    aura_env:ShowOptionsFrame()
end

function aura_env:OnHide()
    aura_env:HideOptionsFrame()
end

if not BetterGroupFinderInitialized then
    C_MythicPlus.RequestMapInfo()
    C_MythicPlus.RequestCurrentAffixes()

    aura_env:InitializeHooks()

    BetterGroupFinderInitialized = true
end
