AceGUI = AceGUI or LibStub("AceGUI-3.0")

function aura_env:SetAceGUIAnchor(aceGUIFrame, parent, point, relativePoint)
    aceGUIFrame.frame:ClearAllPoints()
    aceGUIFrame.frame:SetParent(parent.frame)
    aceGUIFrame.frame:SetPoint(point, parent.frame, relativePoint)
end

function aura_env:AddAceGUIHeading(container, text)
    local heading = AceGUI:Create("Heading")
    heading:SetText(text)
    heading:SetFullWidth(true)
    container:AddChild(heading)
    return heading
end

function aura_env:AddAceGUILabel(container, text)
    local label = AceGUI:Create("Label")
    label:SetText(text)
    label:SetRelativeWidth(1)
    container:AddChild(label)
    return label
end

function aura_env:AddAceGUIIconLabel(container, icon, text)
    local label = AceGUI:Create("InteractiveLabel")
    label:SetImage(icon)
    label:SetText(text)
    label:SetRelativeWidth(1)
    container:AddChild(label)
    return label
end

function aura_env:CreateAceGUIFrame()
    local aceGUIFrame = AceGUI:Create("Frame")
    local childFrames = self:GetAceGUIContainerChildren(aceGUIFrame)
    childFrames.closeButton:Hide()
    childFrames.status:Hide()
    childFrames.cornerDrag:Hide()
    childFrames.bottomDrag:Hide()
    childFrames.rightDrag:Hide()
    self:AddCloseButtonToContainer(aceGUIFrame.frame)
    aceGUIFrame:SetCallback("OnClose", function(self)
        AceGUI:Release(self)
    end)
    aceGUIFrame.frame:SetFrameStrata("MEDIUM")
    return aceGUIFrame
end

function aura_env:GetAceGUIContainerChildren(aceGUIFrame)
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

function aura_env:AddCloseButtonToContainer(frame)
    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    self:ApplyCloseButtonSkin(closeButton)
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
    closeButton:SetScript("OnClick", function(self)
        self:GetParent():Hide()
    end)
end