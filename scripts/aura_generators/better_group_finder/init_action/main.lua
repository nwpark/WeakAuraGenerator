if not BetterGroupFinderInitialized then
    hooksecurefunc("LFGListUtil_SortSearchResults", function(searchEntry)
        WeakAuras.ScanEvents("BGF_ON_SORT_RESULTS", searchEntry)
    end)
    hooksecurefunc("LFGListSearchEntry_Update", function(searchEntry)
        WeakAuras.ScanEvents("BGF_ON_UPDATE", searchEntry)
    end)

    hooksecurefunc("PVEFrame_ShowFrame", function()
        WeakAuras.ScanEvents("BGF_SHOW_OPTIONS")
    end)
    PVEFrame:HookScript("OnShow", function()
        WeakAuras.ScanEvents("BGF_SHOW_OPTIONS")
    end)
    PVEFrame:HookScript("OnHide", function()
        WeakAuras.ScanEvents("BGF_HIDE_OPTIONS")
    end)

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

    BetterGroupFinderInitialized = true
end
