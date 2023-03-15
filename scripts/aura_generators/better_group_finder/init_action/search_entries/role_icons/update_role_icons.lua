aura_env.ROLE_ORDER = {
    TANK = 1,
    HEALER = 2,
    DAMAGER = 3
}
aura_env.roleIconFrames = {}


function aura_env:UpdateRoleIcons(searchEntry)
    self:ResetRoleIconFrames(searchEntry)

    if not self:ShouldDisplayRoleIconsForSearchResult(searchEntry.resultID) then
        return
    end

    local roleIconFrames = self:GetOrCreateRoleIconFrames(searchEntry)
    local isDelisted = C_LFGList.GetSearchResultInfo(searchEntry.resultID).isDelisted

    local members = self:GetMembersForSearchResult(searchEntry.resultID)
    self:SortMembers(members)
    for i, member in ipairs(members) do
        local roleIconFrame = roleIconFrames[i]
        self:UpdateRoleIconFrameForMember(roleIconFrame, member, isDelisted)
    end
end

function aura_env:ShouldDisplayRoleIconsForSearchResult(searchResultID)
    -- Check if already applied/invited/timedout/declined/declined_full/declined_delisted
    local _, appStatus, pendingStatus = C_LFGList.GetApplicationInfo(searchResultID)
    if appStatus ~= "none" or pendingStatus then
        return false
    end

    -- Check if dungeon-like group
    local searchResultInfo = C_LFGList.GetSearchResultInfo(searchResultID)
    local activityInfo = C_LFGList.GetActivityInfoTable(searchResultInfo.activityID)
    if activityInfo.displayType ~= Enum.LFGListDisplayType.RoleEnumerate then
        return false
    end

    if searchResultInfo.isDelisted then
        return false
    end

    return true
end

function aura_env:SortMembers(members)
    table.sort(members, function (a, b)
        if self.ROLE_ORDER[a.role] ~= self.ROLE_ORDER[b.role] then
            return self.ROLE_ORDER[a.role] < self.ROLE_ORDER[b.role]
        end
        return a.class < b.class
    end)
end
