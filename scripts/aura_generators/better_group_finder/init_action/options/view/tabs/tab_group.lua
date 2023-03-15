aura_env.DUNGEON_OPTIONS = "DUNGEON_OPTIONS"
aura_env.MEMBER_OPTIONS = "MEMBER_OPTIONS"

aura_env.OPTIONS_TABS = {
    {text= "Dungeons", value = aura_env.DUNGEON_OPTIONS},
    {text= "Group Members", value = aura_env.MEMBER_OPTIONS},
}


function aura_env:AddOptionsTabs(container)
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
        self:AddDungeonOptionsFrame(widget)
    elseif selectedGroup == self.MEMBER_OPTIONS then
        self:AddMemberOptionsFrame(widget)
    end
end
