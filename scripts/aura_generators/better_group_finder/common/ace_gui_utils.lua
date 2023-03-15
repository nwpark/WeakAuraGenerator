function aura_env:AddAceGUIHeading(container, text)
    local heading = AceGUI:Create("Heading")
    heading:SetText(text)
    heading:SetFullWidth(true)
    container:AddChild(heading)
end

function aura_env:AddAceGUILabel(container, text)
    local label = AceGUI:Create("Label")
    label:SetText(text)
    label:SetRelativeWidth(1)
    container:AddChild(label)
end

function aura_env:AddAceGUICheckbox(container, params)
    local checkBox = AceGUI:Create("CheckBox")
    checkBox.aura_env = self
    checkBox:SetType("checkbox")
    checkBox:SetLabel(params.label)
    checkBox:SetValue(params.value)
    checkBox:SetDisabled(params.disabled or false)
    checkBox:SetRelativeWidth(params.relativeWidth or 1)
    checkBox:SetCallback("OnValueChanged", function(self, _, newValue)
        params.onValueChanged(self.aura_env, params.label, newValue)
    end)
    container:AddChild(checkBox)
    return checkBox
end

function aura_env:AddAceGUINumericInputBox(container, params)
    local editBox = AceGUI:Create("EditBox")
    editBox.aura_env = self
    editBox:SetText(tostring(params.value or ""))
    editBox:SetDisabled(params.disabled or false)
    editBox:SetMaxLetters(params.maxLetters)
    editBox:SetRelativeWidth(params.relativeWidth or 1)
    editBox:DisableButton(true)
    local onValueChanged = function()
        local newValue = tonumber(editBox:GetText())
        if newValue then
            params.onValueChanged(editBox.aura_env, params.label, newValue)
        else
            editBox:SetText()
        end
    end
    editBox:SetCallback("OnEnterPressed", onValueChanged)
    editBox.editbox:HookScript("OnEditFocusLost", onValueChanged)
    container:AddChild(editBox)
    return editBox
end

function aura_env:CreateAceGUIFrame()
    local aceGUIFrame = AceGUI:Create("Frame")
    local childFrames = self:GetAceGUIChildFrames(aceGUIFrame)
    childFrames.closeButton:Hide()
    childFrames.cornerDrag:Hide()
    childFrames.bottomDrag:Hide()
    childFrames.rightDrag:Hide()
    self:AddCloseButtonToFrame(aceGUIFrame.frame)
    aceGUIFrame:SetCallback("OnClose", function(self)
        AceGUI:Release(self)
    end)
    return aceGUIFrame
end

function aura_env:GetAceGUIChildFrames(aceGUIFrame)
    local closeButton, status, title, cornerDrag, bottomDrag, rightDrag, content = aceGUIFrame.frame:GetChildren()
    return {
        closeButton = closeButton,
        status = status,
        title = title,
        cornerDrag = cornerDrag,
        bottomDrag = bottomDrag,
        rightDrag = rightDrag,
        content = content
    }
end

function aura_env:AddCloseButtonToFrame(frame)
    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    self:ApplyCloseButtonSkin(closeButton)
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
    closeButton:SetScript("OnClick", function(self)
        self:GetParent():Hide()
    end)
end