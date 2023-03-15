aura_env.dungeonCheckboxes = {
    [aura_env.DUNGEONS.AA.name] = nil,
    [aura_env.DUNGEONS.AV.name] = nil,
    [aura_env.DUNGEONS.COS.name] = nil,
    [aura_env.DUNGEONS.HOV.name] = nil,
    [aura_env.DUNGEONS.NO.name] = nil,
    [aura_env.DUNGEONS.RLP.name] = nil,
    [aura_env.DUNGEONS.SBG.name] = nil,
    [aura_env.DUNGEONS.TJS.name] = nil,
}
aura_env.givesScoreAtKeyLevelFrames = {
    checkbox = nil,
    editBox = nil,
}

function aura_env:AddDungeonOptionsFrame(container)
    self:AddAceGUIHeading(container, "Filter by dungeons")
    self:AddDungeonCheckboxes(container)

    self:AddAceGUIHeading(container, "Key levels (" .. self:GetCurrentWeeklyAffixString() .. ")")
    self:AddGivesScoreAtKeyLevelCheckbox(container)
end

function aura_env:AddDungeonCheckboxes(container)
    for _, dungeon in pairs(self.DUNGEONS) do
        self.dungeonCheckboxes[dungeon.name] = self:AddAceGUICheckbox(container, {
            label = dungeon.name,
            value = self.dungeonFilters[dungeon.name],
            disabled = self.dungeonFilters.givesScoreAtKeyLevel.enabled,
            onValueChanged = self.SetDungeonFilterChecked,
            relativeWidth = 0.5,
        })
    end
end

function aura_env:AddGivesScoreAtKeyLevelCheckbox(container)
    local givesScoreAtKeyLevelModel = self.dungeonFilters.givesScoreAtKeyLevel
    self.givesScoreAtKeyLevelFrames.checkbox = self:AddAceGUICheckbox(container, {
        value = givesScoreAtKeyLevelModel.enabled,
        label = "Gives score at level:",
        onValueChanged = self.SetGivesScoreAtKeyLevelChecked,
        relativeWidth = 0.75,
    })
    self.givesScoreAtKeyLevelFrames.editBox = self:AddAceGUINumericInputBox(container, {
        value = givesScoreAtKeyLevelModel.keyLevel,
        onValueChanged = self.SetGivesScoreAtKeyLevel,
        disabled = not givesScoreAtKeyLevelModel.enabled,
        relativeWidth = 0.2,
        maxLetters = 2,
    })
end
