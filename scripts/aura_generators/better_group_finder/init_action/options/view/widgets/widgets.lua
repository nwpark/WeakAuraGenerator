aura_env.widgets = {}

aura_env.DUNGEON_OPTIONS = "DUNGEON_OPTIONS"
aura_env.MEMBER_OPTIONS = "MEMBER_OPTIONS"

aura_env.OPTIONS_TABS = {
    {text= "Dungeons", value = aura_env.DUNGEON_OPTIONS},
    {text= "Group Members", value = aura_env.MEMBER_OPTIONS},
}

function aura_env:AddOptionsFrameWidgets(container)
    self:AddAceGUIHeading(container, "Options")

    self.widgets[self.modelKeys.autoRefresh] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.autoRefresh])
    self.widgets[self.modelKeys.minimumRioScoreEnabled] = self:AddAceGUICheckbox(container, self.widgetConfig[self.modelKeys.minimumRioScoreEnabled])
    self.widgets[self.modelKeys.minimumRioScoreInput] = self:AddAceGUINumericInputBox(container, self.widgetConfig[self.modelKeys.minimumRioScoreInput])

    self:AddOptionsFrameTabWidgets(container)
end

function aura_env:AddOptionsFrameTabWidgets(container)
    local tabGroup = AceGUI:Create("TabGroup")
    tabGroup.aura_env = self
    tabGroup:SetFullWidth(true)
    tabGroup:SetLayout("Flow")
    tabGroup:SetTabs(self.OPTIONS_TABS)
    tabGroup:SetCallback("OnGroupSelected", function(widget, _, selectedGroup)
        widget.aura_env:OnOptionsTabSelected(widget, selectedGroup)
    end)
    tabGroup:SelectTab(self.OPTIONS_TABS[1].value)

    container:AddChild(tabGroup)
end

function aura_env:OnOptionsTabSelected(widget, selectedGroup)
    widget:ReleaseChildren()
    if selectedGroup == self.DUNGEON_OPTIONS then
        self:AddDungeonOptionsWidgets(widget)
    elseif selectedGroup == self.MEMBER_OPTIONS then
        self:AddMemberOptionsWidgets(widget)
    end
end
