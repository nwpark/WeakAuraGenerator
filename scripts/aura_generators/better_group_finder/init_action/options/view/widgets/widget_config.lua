aura_env.widgetConfig = {}

function aura_env:InitializeWidgetConfig()
    self.widgetConfig = {
        [self.modelKeys.autoRefresh] = self:CheckboxParams(self.modelKeys.autoRefresh, "Auto refresh search results", {}),
        [self.modelKeys.minimumRioScoreEnabled] = self:CheckboxParams(self.modelKeys.minimumRioScoreEnabled, "Minimum RIO score:", {relativeWidth = 0.7}),
        [self.modelKeys.minimumRioScoreInput] = self:NumericInputParams(self.modelKeys.minimumRioScoreInput, self.modelKeys.minimumRioScoreEnabled, {relativeWidth = 0.25, maxLetters = 4}),
        [self.modelKeys.AA] = self:CheckboxParams(self.modelKeys.AA, "AA", {disabled = self.modelValues.givesScoreAtKeyLevelEnabled, relativeWidth = 0.5}),
        [self.modelKeys.AV] = self:CheckboxParams(self.modelKeys.AV, "AV", {disabled = self.modelValues.givesScoreAtKeyLevelEnabled, relativeWidth = 0.5}),
        [self.modelKeys.COS] = self:CheckboxParams(self.modelKeys.COS, "COS", {disabled = self.modelValues.givesScoreAtKeyLevelEnabled, relativeWidth = 0.5}),
        [self.modelKeys.HOV] = self:CheckboxParams(self.modelKeys.HOV, "HOV", {disabled = self.modelValues.givesScoreAtKeyLevelEnabled, relativeWidth = 0.5}),
        [self.modelKeys.NO] = self:CheckboxParams(self.modelKeys.NO, "NO", {disabled = self.modelValues.givesScoreAtKeyLevelEnabled, relativeWidth = 0.5}),
        [self.modelKeys.RLP] = self:CheckboxParams(self.modelKeys.RLP, "RLP", {disabled = self.modelValues.givesScoreAtKeyLevelEnabled, relativeWidth = 0.5}),
        [self.modelKeys.SBG] = self:CheckboxParams(self.modelKeys.SBG, "SBG", {disabled = self.modelValues.givesScoreAtKeyLevelEnabled, relativeWidth = 0.5}),
        [self.modelKeys.TJS] = self:CheckboxParams(self.modelKeys.TJS, "TJS", {disabled = self.modelValues.givesScoreAtKeyLevelEnabled, relativeWidth = 0.5}),
        [self.modelKeys.givesScoreAtKeyLevelEnabled] = self:CheckboxParams(self.modelKeys.givesScoreAtKeyLevelEnabled, "Gives score at level:", {relativeWidth = 0.75}),
        [self.modelKeys.givesScoreAtKeyLevelInput] = self:NumericInputParams(self.modelKeys.givesScoreAtKeyLevelInput, self.modelKeys.givesScoreAtKeyLevelEnabled, {relativeWidth = 0.2, maxLetters = 2}),
        [self.modelKeys.hasSlotForPlayerRole] = self:CheckboxParams(self.modelKeys.hasSlotForPlayerRole, "Has slot for " .. self:GetCurrentPlayerRoleString(), {}),
        [self.modelKeys.hasSlotForPlayerClass] = self:CheckboxParams(self.modelKeys.hasSlotForPlayerClass, self:GetPlayerClassString() .. "s == 0", {}),
        [self.modelKeys.hasSlotsForPartyRoles] = self:CheckboxParams(self.modelKeys.hasSlotsForPartyRoles, "Party fit", {disabled = true}),
        [self.modelKeys.hasBloodlust] = self:CheckboxParams(self.modelKeys.hasBloodlust, "Doesn't need bloodlust", {disabled = true}),
        [self.modelKeys.hasCurseDispel] = self:CheckboxParams(self.modelKeys.hasCurseDispel, "Doesn't need curse dispel", {disabled = true}),
        [self.modelKeys.hasPoisonDispel] = self:CheckboxParams(self.modelKeys.hasPoisonDispel, "Doesn't need poison dispel", {disabled = true}),
    }
end

function aura_env:CheckboxParams(modelKey, label, params)
    params = params or {}
    return {
        key = modelKey,
        label = label,
        value = self.modelValues[modelKey],
        onValueChanged = self.controllers[modelKey],
        disabled = params.disabled or false,
        relativeWidth = params.relativeWidth or 1
    }
end

function aura_env:NumericInputParams(modelKey, checkboxModelKey, params)
    params = params or {}
    return {
        key = modelKey,
        value = self.modelValues[modelKey],
        onValueChanged = self.controllers[modelKey],
        disabled = not self.modelValues[checkboxModelKey],
        maxLetters = params.maxLetters or 4,
        relativeWidth = params.relativeWidth or 1,
    }
end
