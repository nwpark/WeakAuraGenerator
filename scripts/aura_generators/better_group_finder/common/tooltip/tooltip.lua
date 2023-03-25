function aura_env:ShowTooltip(text, parent)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(L.PROFILE_TOOLTIP_ANCHOR_TOOLTIP, 1, 1, 1)
    GameTooltip:Show()

    local tooltip = AceGUI.tooltip
    tooltip:SetOwner(BGFOptionsFrame.frame, "ANCHOR_NONE")
    tooltip:ClearAllPoints()
    tooltip:SetPoint("LEFT",BGFOptionsFrame.frame,"RIGHT")
    tooltip:SetText("ITS ME NICK")
    tooltip:Show()
    self:ApplyTooltipSkin(tooltip)
end
