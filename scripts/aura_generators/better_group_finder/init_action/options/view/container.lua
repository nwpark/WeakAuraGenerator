function aura_env:ShowOptionsFrame()
    if not (BGFOptionsFrame and BGFOptionsFrame:IsShown()) then
        self:CreateOptionsFrame()
    end
end

function aura_env:HideOptionsFrame()
    if BGFOptionsFrame and BGFOptionsFrame:IsShown() then
        BGFOptionsFrame:Hide()
    end
end

function aura_env:CreateOptionsFrame()
    self:InitializeModelValues()
    self:InitializeWidgetConfig()

    BGFOptionsFrame = self:CreateAceGUIFrame()
    BGFOptionsFrame:SetTitle("Mythic Dungeon Finder")
    BGFOptionsFrame:SetWidth(300)
    BGFOptionsFrame:SetHeight(PVEFrame:GetHeight())
    BGFOptionsFrame:SetLayout("Flow")

    self:AddOptionsFrameWidgets(BGFOptionsFrame)
    self:UpdateOptionsFrameAnchors()
    if self:ShouldDisplayWarning() then
        self:CreateWarningFrame(BGFOptionsFrame)
    end
end

function aura_env:UpdateOptionsFrameAnchors()
    local xOffset = (RaiderIO_ProfileTooltip and RaiderIO_ProfileTooltip:GetWidth()) or 0
    local anchorFrame = PremadeGroupsFilterDialog or GroupFinderFrame
    BGFOptionsFrame:ClearAllPoints()
    BGFOptionsFrame:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", xOffset, 0)
end
