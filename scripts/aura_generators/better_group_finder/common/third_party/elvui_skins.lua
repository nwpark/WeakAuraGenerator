function aura_env:ApplyCloseButtonSkin(closeButton)
    local skins = self:GetElvUISkins()
    if skins then
      skins:HandleCloseButton(closeButton)
    end
end

function aura_env:ApplyTooltipSkin(tooltipFrame)
    local elvUITooltip = self:GetElvUITooltip()
    if elvUITooltip then
        elvUITooltip:SetStyle(tooltipFrame)
    end
end

function aura_env:GetElvUISkins()
    return IsAddOnLoaded("ElvUI") and ElvUI and ElvUI[1] and ElvUI[1]:GetModule("Skins")
end

function aura_env:GetElvUITooltip()
    return IsAddOnLoaded("ElvUI") and ElvUI and ElvUI[1] and ElvUI[1]:GetModule("Tooltip")
end
