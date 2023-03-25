function aura_env:AddMemberOptionsWidgets(container)
    self:AddAceGUIHeading(container, "Filter by group members")

    self.widgets[self.modelKeys.hasSlotForPlayerRole] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.hasSlotForPlayerRole])
    self.widgets[self.modelKeys.hasSlotForPlayerClass] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.hasSlotForPlayerClass])
    self.widgets[self.modelKeys.hasSlotsForPartyRoles] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.hasSlotsForPartyRoles])
    self.widgets[self.modelKeys.hasBloodlust] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.hasBloodlust])
    self.widgets[self.modelKeys.hasCurseDispel] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.hasCurseDispel])
    self.widgets[self.modelKeys.hasPoisonDispel] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.hasPoisonDispel])
end
