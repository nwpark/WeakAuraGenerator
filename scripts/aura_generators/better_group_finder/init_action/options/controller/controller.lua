function aura_env:OnCheckboxValueChanged(modelKey, value)
    self:SetWAConfigValue(modelKey, value)
    self.modelValues[modelKey] = value
    self.widgets[modelKey]:SetValue(value)

    self:RefreshSearchResults()
end

function aura_env:OnGivesScoreAtKeyLevelCheckboxValueChanged(modelKey, value)
    local keyLevel = self.modelValues.givesScoreAtKeyLevelInput
    self:OnGivedScoreAtKeyLevelValuesChanged(value, keyLevel)
end

function aura_env:OnGivesScoreAtKeyLevelInputValueChanged(modelKey, value)
    self:OnGivedScoreAtKeyLevelValuesChanged(true, value)
end

function aura_env:OnGivedScoreAtKeyLevelValuesChanged(isEnabled, keyLevel)
    self:SetWAConfigValue(self.modelKeys.givesScoreAtKeyLevelEnabled, isEnabled)
    self:SetWAConfigValue(self.modelKeys.givesScoreAtKeyLevelInput, keyLevel)
    self.modelValues.givesScoreAtKeyLevelEnabled = isEnabled
    self.modelValues.givesScoreAtKeyLevelInput = keyLevel

    local checkboxWidget = self.widgets[self.modelKeys.givesScoreAtKeyLevelEnabled]
    local inputWidget = self.widgets[self.modelKeys.givesScoreAtKeyLevelInput]
    checkboxWidget:SetValue(isEnabled)
    inputWidget:SetText(tostring(keyLevel or ""))
    inputWidget.editbox:ClearFocus()
    inputWidget:SetDisabled(not isEnabled)
    for modelKey, dungeonCheckboxWidget in pairs(self:GetDungeonCheckboxWidgets()) do
        dungeonCheckboxWidget:SetDisabled(isEnabled)
        if isEnabled then
            local dungeonGivesScoreAtKeyLevel = self:DungeonGivesScoreAtKeyLevel(modelKey, keyLevel)
            self.modelValues[modelKey] = dungeonGivesScoreAtKeyLevel
            self.widgets[modelKey]:SetValue(dungeonGivesScoreAtKeyLevel)
        end
    end

    self:RefreshSearchResults()
end

function aura_env:OnMinimumRioScoreCheckboxValueChanged(modelKey, value)
    self:SetWAConfigValue(modelKey, value)
    self.modelValues.minimumRioScoreEnabled = value
    self.widgets[modelKey]:SetValue(value)
    self.widgets[self.modelKeys.minimumRioScoreInput]:SetDisabled(not value)

    self:RefreshSearchResults()
end

function aura_env:OnMinimumRioScoreInputValueChanged(modelKey, value)
    self:SetWAConfigValue(modelKey, value)
    self.modelValues.minimumRioScoreInput = value
    self.widgets[modelKey]:SetText(tostring(value or ""))
    self.widgets[modelKey].editbox:ClearFocus()

    self:RefreshSearchResults()
end

aura_env.controllers = {
    [aura_env.modelKeys.autoRefresh] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.minimumRioScoreEnabled] = aura_env.OnMinimumRioScoreCheckboxValueChanged,
    [aura_env.modelKeys.minimumRioScoreInput] = aura_env.OnMinimumRioScoreInputValueChanged,
    [aura_env.modelKeys.AA] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.AV] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.COS] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.HOV] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.NO] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.RLP] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.SBG] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.TJS] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.givesScoreAtKeyLevelEnabled] = aura_env.OnGivesScoreAtKeyLevelCheckboxValueChanged,
    [aura_env.modelKeys.givesScoreAtKeyLevelInput] = aura_env.OnGivesScoreAtKeyLevelInputValueChanged,
    [aura_env.modelKeys.hasSlotForPlayerClass] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.hasSlotForPlayerRole] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.hasSlotsForPartyRoles] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.hasBloodlust] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.hasCurseDispel] = aura_env.OnCheckboxValueChanged,
    [aura_env.modelKeys.hasPoisonDispel] = aura_env.OnCheckboxValueChanged,
}
