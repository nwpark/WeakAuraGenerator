aura_env.cancelled = {}
aura_env.declined = {}


-- Generic utils -------------------------------------------------------------------------------------------------------
aura_env.GetNormalizedPlayerName = function(aura_env, playerName)
    if not playerName then
        return ""
    end

    if string.match(playerName, "-") then
        return playerName
    end

    local realmName = string.gsub(GetRealmName(), " ", "")
    return playerName .. "-" .. realmName
end

aura_env.GetRioProfile = function(aura_env, playerName)
    if not (playerName and RaiderIO) then
        return nil
    end

    local FACTIONS = { Alliance = 1, Horde = 2, Neutral = 3 }
    local playerFactionID = FACTIONS[UnitFactionGroup("player")]
    playerName = aura_env:GetNormalizedPlayerName(playerName)

    return RaiderIO.GetProfile(playerName, playerFactionID)
end

aura_env.GetRioScore = function(aura_env, playerName)
    if not playerName then
        return 0
    end

    local playerProfile = aura_env:GetRioProfile(playerName)
    if not (playerProfile and playerProfile.mythicKeystoneProfile) then
        return 0
    end

    return playerProfile.mythicKeystoneProfile.currentScore or 0
end

aura_env.ColorToHex = function(aura_env, color)
    color = color or 0
    color = math.floor(color * 255)
    local hexColor = string.format("%x", color)
    if (hexColor:len() == 1) then
        return "0" .. hexColor
    end
    return hexColor
end

aura_env.GetRioScoreHexColor = function(aura_env, rioScore)
    if not (rioScore and RaiderIO) then
        return nil
    end

    local r, g, b = RaiderIO.GetScoreColor(rioScore)
    return aura_env:ColorToHex(r) .. aura_env:ColorToHex(g) .. aura_env:ColorToHex(b)
end

-- todo return nil not ""
aura_env.GetLeaderNameForSearchEntry = function(aura_env, searchResultID)
    if not searchResultID then
        return ""
    end
    local resultInfo = C_LFGList.GetSearchResultInfo(searchResultID)
    if resultInfo then
        return resultInfo.leaderName
    end
    return ""
end

aura_env.GetFormattedRioScoreText = function(aura_env, searchResultID)
    if not searchResultID then
        return ""
    end
    local leaderName = aura_env:GetLeaderNameForSearchEntry(searchResultID)
    local rioScore = aura_env:GetRioScore(leaderName)

    if not rioScore then
        return ""
    end

    local textColor = aura_env:GetRioScoreHexColor(rioScore)
    if not textColor then
        return ""
    end

    return "|cff" .. textColor .. tostring(rioScore) .. "|r"
end

aura_env.GetSearchEntryStatusText = function(aura_env, searchResultID)
    if not searchResultID then
        return ""
    end

    local leaderName = aura_env:GetLeaderNameForSearchEntry(searchResultID)

    if leaderName and aura_env.cancelled[leaderName] then
        return "CANCELLED"
    elseif leaderName and aura_env.declined[leaderName] then
        return "DECLINED"
    else
        return ""
    end
end

aura_env.IsDungeonFinderFrameOpen = function(aura_env)
    if not (LFGListFrame and LFGListFrame.SearchPanel) then
        return false
    end

    return LFGListFrame.SearchPanel:IsShown() and LFGListFrame.SearchPanel.categoryID == 2
end

-- Core ----------------------------------------------------------------------------------------------------------------

aura_env.HasRemainingSlotsForPlayerRole = function(aura_env, searchResultID)
    local memberCounts = C_LFGList.GetSearchResultMemberCounts(searchResultID)
    local playerRole = GetSpecializationRole(GetSpecialization())

    if playerRole == "TANK" then
        return memberCounts["TANK_REMAINING"] > 0
    elseif playerRole == "HEALER" then
        return memberCounts["HEALER_REMAINING"] > 0
    else
        return memberCounts["DAMAGER_REMAINING"] > 0
    end
end

aura_env.ShouldIgnoreSearchEntry = function(aura_env, searchResultID)
    local leaderName = aura_env:GetLeaderNameForSearchEntry(searchResultID)
    if not leaderName then
        return false
    end

    return aura_env.declined[leaderName] or aura_env.cancelled[leaderName]
end

aura_env.SortSearchResults = function(aura_env, searchResults)
    if #searchResults == 0 then
        return
    end

    table.sort(searchResults, function(searchResultID1, searchResultID2)
        local searchResultInfo1 = searchResultID1 and C_LFGList.GetSearchResultInfo(searchResultID1)
        local searchResultInfo2 = searchResultID2 and C_LFGList.GetSearchResultInfo(searchResultID2)

        if not (searchResultInfo1 and searchResultInfo2) then
            return searchResultInfo1 ~= nil
        end

        local shouldIgnore1 = aura_env:ShouldIgnoreSearchEntry(searchResultID1)
        local shouldIgnore2 = aura_env:ShouldIgnoreSearchEntry(searchResultID2)
        local leaderName1 = aura_env:GetLeaderNameForSearchEntry(searchResultID1)
        local leaderName2 = aura_env:GetLeaderNameForSearchEntry(searchResultID2)
        local rioScore1 = aura_env:GetRioScore(leaderName1)
        local rioScore2 = aura_env:GetRioScore(leaderName2)

        if shouldIgnore1 and shouldIgnore2 then
            return rioScore1 > rioScore2
        elseif shouldIgnore1 then
            return false
        elseif shouldIgnore2 then
            return true
        end

        return rioScore1 > rioScore2
    end)

    LFGListSearchPanel_UpdateResults(LFGListFrame.SearchPanel)
end

aura_env.UpdateSearchEntryName = function(aura_env, searchEntry)
    local rioScoreText = aura_env:GetFormattedRioScoreText(searchEntry.resultID)
    local statusText = aura_env:GetSearchEntryStatusText(searchResultID)
    local prefix = ""

    if rioScoreText ~= "" then
        prefix = prefix .. "[" .. rioScoreText ..  "] "
    end

    if statusText ~= "" then
        prefix = prefix .. statusText .. " "
    end

    local searchEntryName = searchEntry.Name:GetText()
    searchEntry.Name:SetText(prefix .. searchEntryName)
end

aura_env.UpdateSearchEntryColors = function(aura_env, searchEntry)
    local leaderName = aura_env:GetLeaderNameForSearchEntry(searchEntry.resultID)

    if not (aura_env.cancelled[leaderName] or aura_env.declined[leaderName]) then
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

-- Hooked functions ----------------------------------------------------------------------------------------------------

aura_env.OnLFGListSearchEntry_Update = function(aura_env, searchEntry)
    if not aura_env:IsDungeonFinderFrameOpen() then
        return
    end

    aura_env:UpdateSearchEntryName(searchEntry)
    aura_env:UpdateSearchEntryColors(searchEntry)
end

aura_env.OnLFGListUtil_SortSearchResults = function(aura_env, searchResults)
    if not (searchResults and #searchResults > 0 and aura_env:IsDungeonFinderFrameOpen()) then
        return
    end

    aura_env:SortSearchResults(searchResults)
end

if not _G["BetterPremadeGroupFinderLoaded"] then
    hooksecurefunc("LFGListUtil_SortSearchResults", function(searchEntry)
        WeakAuras.ScanEvents("BGF_ON_SORT_RESULTS", searchEntry)
        -- aura_env:OnLFGListUtil_SortSearchResults(searchEntry)
    end)
    hooksecurefunc("LFGListSearchEntry_Update", function(searchEntry)
        WeakAuras.ScanEvents("BGF_ON_UPDATE", searchEntry)
        -- aura_env:OnLFGListSearchEntry_Update(searchEntry)
    end)
    _G["BetterPremadeGroupFinderLoaded"] = true
end


