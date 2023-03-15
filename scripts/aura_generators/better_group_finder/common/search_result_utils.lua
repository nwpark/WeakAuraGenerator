function aura_env:GetLeaderInfoForSearchResult(searchResultID)
    local leaderName = self:GetLeaderNameForSearchResult(searchResultID)
    return {
        name = leaderName,
        rioScore = leaderName and self:GetRioScore(leaderName)
    }
end

function aura_env:GetLeaderNameForSearchResult(searchResultID)
    local resultInfo = C_LFGList.GetSearchResultInfo(searchResultID)
    return resultInfo.leaderName
end

function aura_env:GetActivityIDForSearchResult(searchResultID)
    return C_LFGList.GetSearchResultInfo(searchResultID).activityID
end

function aura_env:SearchResultHasRemainingSlotsForPlayerRole(searchResultID)
    local memberCounts = C_LFGList.GetSearchResultMemberCounts(searchResultID)
    if not (memberCounts) then
        return true
    end

    local playerRole = GetSpecializationRole(GetSpecialization())
    if playerRole == "TANK" then
        return memberCounts["TANK_REMAINING"] > 0
    elseif playerRole == "HEALER" then
        return memberCounts["HEALER_REMAINING"] > 0
    else
        return memberCounts["DAMAGER_REMAINING"] > 0
    end
end

function aura_env:GetMembersForSearchResult(searchResultID)
    local searchResultInfo = C_LFGList.GetSearchResultInfo(searchResultID)
    local members = {}
    for memberIndex = 1, searchResultInfo.numMembers do
        table.insert(members, self:GetMemberInfo(searchResultID, memberIndex))
    end
    return members
end

function aura_env:GetMemberInfo(searchResultID, memberIndex)
    local role, class = C_LFGList.GetSearchResultMemberInfo(searchResultID, memberIndex)
    local isLeader = memberIndex == 1
    return {
        role = role,
        class = class,
        isLeader = isLeader
    }
end
