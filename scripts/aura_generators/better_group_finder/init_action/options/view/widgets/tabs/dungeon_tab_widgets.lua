function aura_env:AddDungeonOptionsWidgets(container)
    self:AddAceGUIHeading(container, "Filter by dungeons")

    self.widgets[self.modelKeys.AA] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.AA])
    self.widgets[self.modelKeys.AV] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.AV])
    self.widgets[self.modelKeys.COS] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.COS])
    self.widgets[self.modelKeys.HOV] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.HOV])
    self.widgets[self.modelKeys.NO] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.NO])
    self.widgets[self.modelKeys.RLP] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.RLP])
    self.widgets[self.modelKeys.SBG] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.SBG])
    self.widgets[self.modelKeys.TJS] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.TJS])

    self:AddAceGUIHeading(container, "Key levels (" .. self:GetCurrentWeeklyAffixString() .. ")")

    self.widgets[self.modelKeys.givesScoreAtKeyLevelEnabled] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.givesScoreAtKeyLevelEnabled])
    self.widgets[self.modelKeys.givesScoreAtKeyLevelInput] = self:AddAceGUINumericInputBox(container, self.widgetConfig[self.modelKeys.givesScoreAtKeyLevelInput])
end

function aura_env:GetDungeonCheckboxWidgets()
    return {
        [self.modelKeys.AA] = self.widgets[self.modelKeys.AA],
        [self.modelKeys.AV] = self.widgets[self.modelKeys.AV],
        [self.modelKeys.COS] = self.widgets[self.modelKeys.COS],
        [self.modelKeys.HOV] = self.widgets[self.modelKeys.HOV],
        [self.modelKeys.NO] = self.widgets[self.modelKeys.NO],
        [self.modelKeys.RLP] = self.widgets[self.modelKeys.RLP],
        [self.modelKeys.SBG] = self.widgets[self.modelKeys.SBG],
        [self.modelKeys.TJS] = self.widgets[self.modelKeys.TJS],
    }
end
