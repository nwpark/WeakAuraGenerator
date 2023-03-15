aura_env.cancelled = {}
aura_env.declined = {}

function aura_env:OnApplicationStatusUpdated(searchResultID, status)
    if not (searchResultID and status) then
        return
    end

    local activityId = self:GetActivityIDForSearchResult(searchResultID)
    local leaderName = self:GetLeaderInfoForSearchResult(searchResultID).name
    if status == "applied" then
        self.cancelled[activityId] = false
        self.declined[activityId] = false
        if leaderName then
            self.declined[leaderName] = false
            self.cancelled[leaderName] = false
        end
    elseif status == "cancelled" then
        self.cancelled[activityId] = true
        if leaderName then
            self.cancelled[leaderName] = true
        end
    elseif status == "declined" then
        self.declined[activityId] = true
        if leaderName then
            self.declined[leaderName] = true
        end
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
    local activityId = self:GetActivityIDForSearchResult(searchResultID)
    return self.cancelled[leaderName or activityId]
end

function aura_env:IsApplicationDeclined(searchResultID)
    local leaderName = self:GetLeaderInfoForSearchResult(searchResultID).name
    local activityId = self:GetActivityIDForSearchResult(searchResultID)
    return self.declined[leaderName or activityId]
end
