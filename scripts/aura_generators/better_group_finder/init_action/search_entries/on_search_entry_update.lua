function aura_env:OnLFGListSearchEntry_Update(searchEntry)
    if not (searchEntry and self:IsDungeonFinderFrameOpen()) then
        return
    end

    self:UpdateSearchEntryName(searchEntry)
    self:UpdateRoleIcons(searchEntry)
    --self:UpdateSearchEntryColors(searchEntry)
end

function aura_env:UpdateSearchEntryName(searchEntry)
    local searchEntryName = searchEntry.Name:GetText()
    local applicatonState = self:GetApplicationState(searchEntry.resultID)
    local rioScore = self:GetLeaderInfoForSearchResult(searchEntry.resultID).rioScore

    if rioScore then
        searchEntryName = "[" .. self:FormatRioScore(rioScore) ..  "] " .. searchEntryName
    end

    if applicatonState ~= self.OKAY then
        searchEntryName = applicatonState .. " " .. searchEntryName
    end

    searchEntry.Name:SetText(searchEntryName)
end

function aura_env:UpdateSearchEntryColors(searchEntry)
    local searchResultID = searchEntry.resultID
    if not (self:IsSearchResultCancelled(searchResultID) or self:IsSearchResultDeclined(searchResultID)) then
        return
    end

    --local fontR, fontG, fontB, fontA = LFG_LIST_DELISTED_FONT_COLOR:GetRGBA()
    local fontR, fontG, fontB, fontA = DISABLED_FONT_COLOR:GetRGBA()

    -- Search entry colors
    searchEntry.ResultBG:SetColorTexture(fontR, fontG, fontB, fontA)
    searchEntry.PendingLabel:SetTextColor(fontR, fontG, fontB, fontA)
    searchEntry.Name:SetTextColor(fontR, fontG, fontB, fontA)
    searchEntry.ActivityName:SetTextColor(fontR, fontG, fontB, fontA)

    if not searchEntry.DataDisplay then
        return
    end

    -- Role count colors
    if searchEntry.DataDisplay.RoleCount then
        local roleCount = searchEntry.DataDisplay.RoleCount
        roleCount.TankCount:SetTextColor(fontR, fontG, fontB, fontA)
        roleCount.HealerCount:SetTextColor(fontR, fontG, fontB, fontA)
        roleCount.DamagerCount:SetTextColor(fontR, fontG, fontB, fontA)
        roleCount.TankIcon:SetDesaturated(true)
        roleCount.HealerIcon:SetDesaturated(true)
        roleCount.DamagerIcon:SetDesaturated(true)
        roleCount.TankIcon:SetAlpha(0.5)
        roleCount.HealerIcon:SetAlpha(0.5)
        roleCount.DamagerIcon:SetAlpha(0.5)
    end

    -- Role count colors
    if searchEntry.DataDisplay.PlayerCount then
        local playerCount = searchEntry.DataDisplay.PlayerCount
        playerCount.Count:SetTextColor(fontR, fontG, fontB, fontA)
        playerCount.Icon:SetDesaturated(true)
        playerCount.Icon:SetAlpha(0.5)
    end

    -- Enumerate colors
    if searchEntry.DataDisplay.Enumerate then
        local enumerate = searchEntry.DataDisplay.Enumerate
        for i=1, #enumerate.Icons do
            if enumerate.Icons[i] then
                enumerate.Icons[i]:SetDesaturated(true)
                enumerate.Icons[i]:SetAlpha(0.5)
            end
        end
    end
end
