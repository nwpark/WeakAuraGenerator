aura_env.autoRefreshCooldownIcon = nil


function aura_env:ShowRefreshButtonCooldown(seconds)
    local cooldownFrame = self:GetRefreshButtonCooldownFrame()
    cooldownFrame.cooldown:SetCooldown(GetTime(), seconds)

    C_Timer.NewTicker(0.1, function()
        self:UpdateCooldownFrameText(cooldownFrame.cooldown)
    end, seconds/0.1)
end

function aura_env:GetRefreshButtonCooldownFrame()
    if not self.autoRefreshCooldownIcon then
        self.autoRefreshCooldownIcon = self:CreateRefreshButtonCooldownFrame()
    end
    return self.autoRefreshCooldownIcon
end

function aura_env:CreateRefreshButtonCooldownFrame()
    local refreshButton = LFGListFrame.SearchPanel.RefreshButton
    -- todo: replace with simple cooldown (not aura)?
    local cooldownFrame = CreateFrame("Button", nil, refreshButton, "CompactAuraTemplate")

    cooldownFrame:SetAllPoints(refreshButton)

    cooldownFrame.cooldown:SetReverse(false)

    cooldownFrame.cooldown.text = cooldownFrame.cooldown:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    cooldownFrame.cooldown.text:SetAllPoints()
    cooldownFrame.cooldown.text:SetText('')
    cooldownFrame.cooldown.text:SetTextColor(1, 1, 1, 1)

    return cooldownFrame
end

function aura_env:UpdateCooldownFrameText(cooldownFrame)
    local startTime, duration = cooldownFrame:GetCooldownTimes()
    local expirationTime = (startTime + duration) / 1000
    local remainingTime = math.floor(expirationTime - GetTime() + 0.5)

    if remainingTime >= 0.3 then
        cooldownFrame.text:SetText(format("%d", remainingTime))
    else
        cooldownFrame.text:SetText("")
        cooldownFrame:Hide()
    end
end
