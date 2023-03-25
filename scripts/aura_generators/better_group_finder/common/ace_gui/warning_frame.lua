function aura_env:CreateAceGUIWarningFrame()
    local container = AceGUI:Create("SimpleGroup")

    container.frame:SetFrameStrata("MEDIUM")
    container.frame:Show()

    self:AddAceGUIHeading(container, "WARNING")
    return container
end
