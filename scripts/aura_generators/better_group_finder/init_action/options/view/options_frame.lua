AceGUI = AceGUI or LibStub("AceGUI-3.0")


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
    BGFOptionsFrame = self:CreateAceGUIFrame()
    BGFOptionsFrame:SetTitle("Mythic Dungeon Finder")
    BGFOptionsFrame:SetStatusText("Mythic Dungeon Finder v0.1")
    BGFOptionsFrame:SetWidth(300)
    BGFOptionsFrame:SetHeight(PVEFrame:GetHeight())
    BGFOptionsFrame:SetLayout("Flow")

    self:AddStandardOptions(BGFOptionsFrame)
    self:AddOptionsTabs(BGFOptionsFrame)

    self:UpdateOptionsFrameAnchors()
end

function aura_env:UpdateOptionsFrameAnchors()
    --local anchorFrame = RaiderIO_ProfileTooltip or PremadeGroupsFilterDialog or PVEFrame
    --BGFOptionsFrame:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 0, 0)

    if PremadeGroupsFilterDialog then
        BGFOptionsFrame:SetPoint("TOPLEFT", PremadeGroupsFilterDialog, "TOPRIGHT", 0, 0)
    elseif RaiderIO_ProfileTooltip then
        local xOffset = (RaiderIO_ProfileTooltip and RaiderIO_ProfileTooltip:GetWidth()) or 0
        BGFOptionsFrame:SetPoint("TOPLEFT", GroupFinderFrame, "TOPRIGHT", xOffset, 0)
    end
end
