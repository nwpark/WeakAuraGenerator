function aura_env:AddStandardOptions(container)
    self:AddAceGUIHeading(container, "Options")
    self:AddAutoRefreshCheckbox(container)

    --self:AddAceGUIHeading(container, "Filtering")
    self:AddMinimumScoreCheckbox(container)
end

function aura_env:AddMinimumScoreCheckbox(container)
    self:AddAceGUICheckbox(container, {
        label = "Minimum RIO score:",
        --label = "Minimum RIO score ..............................................",
        relativeWidth = 0.7,
        value = false,
        onValueChanged = self.OnDungeonTabCheckBoxChanged
    })
    self:AddAceGUINumericInputBox(container, {
        label = "Minimum RIO score",
        value = 2500,
        relativeWidth = 0.25,
        maxLetters = 4,
        disabled = true,
        onValueChanged = self.OnDungeonMinimumRioScoreChanged,
    })
end

function aura_env:OnDungeonMinimumRioScoreChanged(label, newValue)
    Dump(label, newValue)
end

function aura_env:AddAutoRefreshCheckbox(container)
    self:AddAceGUICheckbox(container, {
        label = "Auto refresh search results",
        --relativeWidth = 0.5,
        value = false,
        --onValueChanged = self.OnDungeonTabCheckBoxChanged
    })
end
