function aura_env:ShouldDisplayWarning()
    return #(self:GetProblematicAddonsAndWeakAuras()) > 0
end

function aura_env:CreateWarningFrame(parent)
    local warningFrame = self:CreateAceGUIWarningFrame()
    warningFrame:SetWidth(parent.frame:GetWidth())
    self:SetAceGUIAnchor(warningFrame, parent, "TOP", "BOTTOM")

    local title = self:AddAceGUILabel(warningFrame, "Detected addons which may cause issues:")
    --local title = self:AddAceGUIIconLabel(warningFrame, self.WARNING_ICON, "Detected addons which may cause issues:")
    title.frame:SetHeight(100)
    for _, warningMessage in ipairs(self:GetProblematicAddonsAndWeakAuras()) do
        self:AddAceGUIIconLabel(warningFrame, self.WARNING_ICON, warningMessage)
        --self:AddAceGUILabel(warningFrame, warningMessage)
    end

    parent.frame:HookScript("OnHide", function()
        if warningFrame and warningFrame:IsShown() then
            AceGUI:Release(warningFrame)
        end
    end)

    return warningFrame
end

function aura_env:GetProblematicAddonsAndWeakAuras()
    local problematicAddonsAndWeakAuras = {}
    for addonName, warningMessage in pairs(self.PROBLEMATIC_ADDON_WARNINGS) do
        if IsAddOnLoaded(addonName) then
            table.insert(problematicAddonsAndWeakAuras, warningMessage)
        end
    end
    for auraName, warningMessage in pairs(self.PROBLEMATIC_WEAK_AURA_WARNINGS) do
        if self:IsWeakAuraLoaded(auraName) then
            table.insert(problematicAddonsAndWeakAuras, warningMessage)
        end
    end

    return problematicAddonsAndWeakAuras
end
