aura_env.cancelled = {}
aura_env.declined = {}

function aura_env:OnApplicationStatusUpdated(searchResultID, status)
    if not (searchResultID and status) then
        return
    end

    local leaderName = self:GetLeaderInfoForSearchResult(searchResultID).name
    if not leaderName then
        return
    end
    if status == "applied" then
        self.declined[leaderName] = false
        self.cancelled[leaderName] = false
    elseif status == "cancelled" then
        self.cancelled[leaderName] = true
    elseif status == "declined" then
        self.declined[leaderName] = true
    end
end

function aura_env:GetApplicationState(searchResultID)
    if C_LFGList.GetSearchResultInfo(searchResultID).isDelisted then
        return self.DELISTED
    elseif self:IsApplicationDeclined(searchResultID) then
        return self.DECLINED
    elseif self:IsApplicationCancelled(searchResultID) then
        return self.CANCELLED
    else
        return self.OKAY
    end
end

function aura_env:IsApplicationCancelled(searchResultID)
    local leaderName = self:GetLeaderInfoForSearchResult(searchResultID).name
    return leaderName and self.cancelled[leaderName]
end

function aura_env:IsApplicationDeclined(searchResultID)
    local leaderName = self:GetLeaderInfoForSearchResult(searchResultID).name
    return leaderName and self.declined[leaderName]
end
