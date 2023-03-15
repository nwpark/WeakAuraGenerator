AceGUI = AceGUI or LibStub("AceGUI-3.0")

aura_env.IsGUIShown = function(aura_env)
    return NPDebugLog and NPDebugLog:IsShown()
end

aura_env.SetGuiText = function(aura_env, text)
    if not aura_env:IsGUIShown() then
        return
    end
    NPDebugLog.textFrame:SetText(text)
    C_Timer.After(0, function()
        --NPDebugLog.textFrame.scrollBar.ScrollDownButton:Click()
        NPDebugLog.textFrame:SetCursorPosition(99999999)
    end)
end

aura_env.AddLogTagToGui = function(aura_env, tag)
    if not aura_env:IsGUIShown() then
        return
    end
    if not NPDebugLog.logTagDropdown.list[tag] then
        NPDebugLog.logTagDropdown:AddItem(tag, tag)
    end
end

aura_env.GetSelectedLogTag = function(aura_env)
    if not aura_env:IsGUIShown() then
        return aura_env.ALL
    end
    return NPDebugLog.logTagDropdown.value
end

aura_env.GetSelectedLogLevel = function(aura_env)
    if not aura_env:IsGUIShown() then
        return aura_env.ALL
    end
    return NPDebugLog.logLevelDropdown.value
end

aura_env.CreateFrames = function(aura_env, tags)
    NPDebugLog = AceGUI:Create("Frame")
    NPDebugLog:SetTitle("DebugLog")
    NPDebugLog:SetWidth(400)
    NPDebugLog:SetAutoAdjustHeight(true)
    NPDebugLog:SetLayout("Flow")
    NPDebugLog:SetPoint("CENTER", UIParent, "CENTER")
    NPDebugLog.aura_env = aura_env
    NPDebugLog:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
    end)
    local closeButton = select(1, NPDebugLog.frame:GetChildren())
    closeButton:Hide()

    -- Level dropdown
    NPDebugLog.logLevelDropdown = AceGUI:Create("Dropdown")
    NPDebugLog.logLevelDropdown.aura_env = aura_env
    NPDebugLog.logLevelDropdown:SetRelativeWidth(0.35)
    NPDebugLog.logLevelDropdown:SetLabel('Log level:')
    NPDebugLog.logLevelDropdown:SetList({
        WARN = aura_env.WARN,
        INFO = aura_env.INFO,
        ALL = aura_env.ALL
    })
    NPDebugLog.logLevelDropdown:SetValue(aura_env.ALL)
    NPDebugLog.logLevelDropdown:SetCallback("OnValueChanged", function(self, _, level)
        self.aura_env:OnDropdownValueChanged()
    end)
    NPDebugLog:AddChild(NPDebugLog.logLevelDropdown)

    -- Tag dropdown
    NPDebugLog.logTagDropdown = AceGUI:Create("Dropdown")
    NPDebugLog.logTagDropdown.aura_env = aura_env
    NPDebugLog.logTagDropdown:SetRelativeWidth(0.35)
    NPDebugLog.logTagDropdown:SetLabel('Tag:')
    NPDebugLog.logTagDropdown:SetList(tags or {ALL = aura_env.ALL})
    NPDebugLog.logTagDropdown:SetValue(aura_env.ALL)
    NPDebugLog.logTagDropdown:SetCallback("OnValueChanged", function(self, _, logTag)
        self.aura_env:OnDropdownValueChanged()
    end)
    NPDebugLog:AddChild(NPDebugLog.logTagDropdown)

    -- Clear button
    NPDebugLog.clearButton = AceGUI:Create("Button")
    NPDebugLog.clearButton.aura_env = aura_env
    NPDebugLog.clearButton:SetRelativeWidth(0.25)
    NPDebugLog.clearButton:SetText("Clear")
    NPDebugLog.clearButton:SetCallback("OnClick", function(self)
        self.aura_env:ClearLog()
    end)
    NPDebugLog:AddChild(NPDebugLog.clearButton)

    -- Log text
    NPDebugLog.textFrame = AceGUI:Create("MultiLineEditBox")
    NPDebugLog.textFrame:SetLabel("Log events:")
    NPDebugLog.textFrame:SetFullWidth(true)
    NPDebugLog.textFrame:DisableButton(true)
    NPDebugLog.textFrame:SetNumLines(24)
    NPDebugLog:AddChild(NPDebugLog.textFrame)

    NPDebugLog.closeButton = AceGUI:Create("Button")
    NPDebugLog.closeButton:SetWidth(100)
    NPDebugLog.closeButton:SetText("Close")
    NPDebugLog.closeButton:SetCallback("OnClick", function(self)
        self.parent:Hide()
    end)
    NPDebugLog:AddChild(NPDebugLog.closeButton)
end


if (not NPDebugLogInitialized) then
    local debugButton = AceGUI:Create("Button")
    debugButton:SetWidth(80)
    debugButton:SetText("Debug")
    debugButton:SetCallback("OnClick", function(self)
        WeakAuras.ScanEvents("DEBUG_LOG_SHOW")
    end)
    debugButton.frame:ClearAllPoints()
    debugButton.frame:SetParent(MinimapPanel)
    debugButton.frame:SetPoint("TOPRIGHT", MinimapPanel, "BOTTOMRIGHT", 0, -30)
    debugButton.frame:Show()

    NPDebugLogInitialized = true
end

