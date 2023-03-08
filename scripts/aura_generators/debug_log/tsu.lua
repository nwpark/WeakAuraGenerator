local AceGUI = LibStub("AceGUI-3.0")


aura_env.render = function(aura_env)
    local frame = _G["HX_AS_PARENT_FRAME"]

    if aura_env.isActive then
        frame:Show()
        local anchorFrame = PremadeGroupsFilterDialog or RaiderIO_ProfileTooltip or GroupFinderFrame
        frame:ClearAllPoints()
        frame:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT")
        frame:SetPoint("BOTTOMLEFT", anchorFrame, "BOTTOMRIGHT")

        if aura_env.autoSigningEnabled then
            frame:GetUserData("buttons"):GetUserData("startButton"):SetDisabled(true)
            frame:GetUserData("buttons"):GetUserData("stopButton"):SetDisabled(false)
        else
            frame:GetUserData("buttons"):GetUserData("stopButton"):SetDisabled(true)
            frame:GetUserData("buttons"):GetUserData("startButton"):SetDisabled(false)
        end

        local text = ""
        for k, _ in pairs(aura_env.activityIDBlacklist) do
            text = text .. k .. "\n"
        end
        frame:GetUserData("text"):SetText(text)
    else
        frame:Hide()
    end
end


aura_env.getActivityID = function(aura_env, resultID)
    if resultID == nil then
        return nil
    end

    return C_LFGList.GetSearchResultInfo(resultID).activityID
end


aura_env.toggleFrame = function(aura_env)
end


aura_env.isLfgFrameOpen = function(aura_env)
    return PVEFrame:IsVisible()
    and LFGListFrame.activePanel == LFGListFrame.SearchPanel
    and LFGListFrame.SearchPanel:IsVisible()
end


aura_env.beginAutoSigning = function(aura_env)
    aura_env.autoSigningEnabled = true
    aura_env:render()
    WeakAuras.ScanEvents("HX_AS_LOOP", "nil")
end


aura_env.endAutoSigning = function(aura_env)
    aura_env.autoSigningEnabled = false
    aura_env:render()
end


aura_env.signToKeys = function(aura_env)
    if not aura_env.autoSigningEnabled then
        return
    end

    for i = 1, 10, 1 do
        local entry = _G["LFGListSearchPanelScrollFrameButton" .. i]

        if entry ~= nil then
            aura_env:signToKeyEntry(entry)
        end
    end

    C_Timer.After(3, function() LFGListFrame.SearchPanel.RefreshButton:Click() end)
    C_Timer.After(5, function() WeakAuras.ScanEvents("HX_AS_LOOP", "nil") end)
end


aura_env.signToKeyEntry = function(aura_env, entry)
    local activityID = aura_env:getActivityID(entry.resultID)
    if aura_env.activityIDBlacklist[activityID] ~= nil then
        return
    end

    entry:Click()

    if LFGListFrame.SearchPanel.SignUpButton:IsEnabled() then
        LFGListFrame.SearchPanel.SignUpButton:Click()
        LFGListApplicationDialog.SignUpButton:Click()
    end
end


aura_env.activate = function(aura_env)
    if aura_env.isActive then
        return
    end

    aura_env.isActive = true
    aura_env:render()
end


aura_env.deactivate = function(aura_env)
    if not aura_env.isActive then
        return
    end

    aura_env.isActive = false
    aura_env:render()
end


aura_env.initFrames = function(aura_env)
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Auto LFG Signer")
    frame:SetWidth(300)
    frame:SetHeight(400)
    frame:SetCallback("OnClose", function(widget)
            WeakAuras.ScanEvents("HX_AS_TOGGLE", "nil")
    end)
    frame:SetLayout("Flow")
    frame:SetPoint("TOPLEFT", GroupFinderFrame, "TOPRIGHT")

    local textFrame = AceGUI:Create("MultiLineEditBox")
    textFrame:SetLabel("Blacklisted activities:")
    textFrame:SetFullWidth(true)
    textFrame:DisableButton(true)
    textFrame:SetNumLines(16)
    frame:AddChild(textFrame)
    frame:SetUserData("text", textFrame)

    local buttons = aura_env:createButtons()
    frame:AddChild(buttons)
    frame:SetUserData("buttons", buttons)

    frame:Hide()
    _G["HX_AS_PARENT_FRAME"] = frame
    return frame
end


aura_env.createButtons = function(aura_env)
    local frame = AceGUI:Create("SimpleGroup")

    local startButton = AceGUI:Create("Button")
    startButton:SetText("Start")
    startButton:SetCallback("OnClick", function()
            WeakAuras.ScanEvents("HX_AS_BEGIN", "nil")
    end)
    frame:AddChild(startButton)
    frame:SetUserData("startButton", startButton)

    local stopButton = AceGUI:Create("Button")
    stopButton:SetText("Stop")
    stopButton:SetCallback("OnClick", function()
            WeakAuras.ScanEvents("HX_AS_END", "nil")
    end)
    frame:AddChild(stopButton)
    frame:SetUserData("stopButton", stopButton)

    return frame
end


if (not _G["HxAutoSignerInitialized"]) then
    aura_env:initFrames()
    aura_env.activityIDBlacklist = {}

    hooksecurefunc("LFGListFrame_SetActivePanel", function() WeakAuras.ScanEvents("HX_AS_TOGGLE", "nil") end)
    hooksecurefunc("GroupFinderFrame_ShowGroupFrame", function() WeakAuras.ScanEvents("HX_AS_TOGGLE", "nil") end)
    hooksecurefunc("PVEFrame_ShowFrame", function() WeakAuras.ScanEvents("HX_AS_TOGGLE", "nil") end)
    PVEFrame:HookScript("OnShow", function() WeakAuras.ScanEvents("HX_AS_TOGGLE", "nil") end)
    PVEFrame:HookScript("OnHide", function() WeakAuras.ScanEvents("HX_AS_TOGGLE", "nil") end)

    _G["HxAutoSignerInitialized"] = true;
end
