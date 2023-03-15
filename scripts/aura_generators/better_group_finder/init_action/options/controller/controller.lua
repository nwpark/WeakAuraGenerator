function aura_env:SetDungeonFilterChecked(dungeonName, shouldEnable)
    -- Update model
    self.dungeonFilters[dungeonName] = shouldEnable

    -- Update view
    self.dungeonCheckboxes[dungeonName]:SetValue(shouldEnable)

    self:RefreshLFGSearchResults()
end

function aura_env:SetGivesScoreAtKeyLevelChecked(_, shouldEnable)
    self:SetGivesScoreAtKeyLevelFilter(shouldEnable, self.dungeonFilters.givesScoreAtKeyLevel.keyLevel)
end

function aura_env:SetGivesScoreAtKeyLevel(_, keyLevel)
   self:SetGivesScoreAtKeyLevelFilter(self.dungeonFilters.givesScoreAtKeyLevel.enabled, keyLevel)
end

function aura_env:SetGivesScoreAtKeyLevelFilter(shouldEnable, keyLevel)
    -- Update model
    self.dungeonFilters.givesScoreAtKeyLevel.enabled = shouldEnable
    self.dungeonFilters.givesScoreAtKeyLevel.keyLevel = keyLevel

    -- Update view
    local keyLevelCheckbox = self.givesScoreAtKeyLevelFrames.checkbox
    local keyLevelEditBox = self.givesScoreAtKeyLevelFrames.editBox
    keyLevelCheckbox:SetValue(shouldEnable)
    keyLevelEditBox:SetText(tostring(keyLevel or ""))
    keyLevelEditBox.editbox:ClearFocus()
    keyLevelEditBox:SetDisabled(not shouldEnable)
    for dungeonName, dungeonCheckbox in pairs(self.dungeonCheckboxes) do
        dungeonCheckbox:SetDisabled(shouldEnable)
        if shouldEnable then
            local dungeonGivesScoreAtKeyLevel = self:DungeonGivesScoreAtKeyLevel(dungeonName, keyLevel)
            self:SetDungeonFilterChecked(dungeonName, dungeonGivesScoreAtKeyLevel)
        end
    end
end
