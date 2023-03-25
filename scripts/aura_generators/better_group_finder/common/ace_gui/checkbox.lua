---@shape CheckboxParams
---@field key string
---@field label string
---@field value boolean
---@field disabled boolean | nil
---@field relativeWidth number | nil
---@field onValueChanged function

---@param params CheckboxParams
function aura_env:AddAceGUICheckbox(container, params)
    local checkBox = AceGUI:Create("CheckBox")
    checkBox.aura_env = self
    checkBox:SetType("checkbox")
    checkBox:SetLabel(params.label)
    checkBox:SetValue(params.value)
    checkBox:SetDisabled(params.disabled or false)
    checkBox:SetRelativeWidth(params.relativeWidth or 1)
    checkBox:SetCallback("OnValueChanged", function(self, event, newValue)
        params.onValueChanged(self.aura_env, params.key, newValue)
    end)
    container:AddChild(checkBox)
    return checkBox
end
