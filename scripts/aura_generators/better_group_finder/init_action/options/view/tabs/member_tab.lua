function aura_env:AddMemberOptionsFrame(container)
    self:AddAceGUIHeading(container, "Filter by group members")

    self:AddAceGUICheckbox(container, {
        label = "Has slot for current player role (" .. self:GetCurrentPlayerRoleString() .. ")",
        value = false,
        onValueChanged = function() end
    })

    --self:AddAceGUICheckbox(container, {
    --    label = "Has slots for party roles",
    --    value = false,
    --    onValueChanged = function() end
    --})

    self:AddAceGUICheckbox(container, {
        label = "Has bloodlust (or has 2+ slots)",
        value = false,
        onValueChanged = function() end
    })

    self:AddAceGUICheckbox(container, {
        label = "Has curse dispel (or has 2+ slots)",
        value = false,
        onValueChanged = function() end
    })

    self:AddAceGUICheckbox(container, {
        label = "Has poison dispel (or has 2+ slots)",
        value = false,
        onValueChanged = function() end
    })
end
