function aura_env:AddAceGUINumericInputBox(container, params)
    local editBox = AceGUI:Create("EditBox")
    editBox.aura_env = self
    editBox:SetText(tostring(params.value or ""))
    editBox:SetDisabled(params.disabled or false)
    editBox:SetMaxLetters(params.maxLetters)
    editBox:SetRelativeWidth(params.relativeWidth or 1)
    editBox:DisableButton(true)
    local onValueChanged = function(self, event, newValue)
        local numericValue = tonumber(editBox:GetText())
        if numericValue then
            params.onValueChanged(editBox.aura_env, params.key, numericValue)
        else
            editBox:SetText()
        end
    end
    editBox:SetCallback("OnEnterPressed", onValueChanged)
    editBox.editbox:HookScript("OnEditFocusLost", onValueChanged)
    container:AddChild(editBox)
    return editBox
end
