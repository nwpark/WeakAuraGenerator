aura_env.DISABLED_ROLE_INDICATOR_COLOR = { r = 0.2, g = 0.2, b = 0.2 }
aura_env.ROLE_ICONS = {
    TANK = "roleicon-tiny-tank",
    HEALER = "roleicon-tiny-healer",
    DAMAGER = "roleicon-tiny-dps",
}


function aura_env:ResetRoleIconFrames(searchEntry)
    local roleIconFrames = self.roleIconFrames[searchEntry]
    if roleIconFrames then
        for _, roleIconFrame in pairs(roleIconFrames) do
            self:ResetRoleIconFrame(roleIconFrame)
        end
    end
end

function aura_env:GetOrCreateRoleIconFrames(searchEntry)
    if self.roleIconFrames[searchEntry] then
        return self.roleIconFrames[searchEntry]
    end

    local roleIconFrames = {}
    for i = 1, 5 do
        roleIconFrames[i] = self:CreateRoleIconFrame(searchEntry, i)
    end
    self.roleIconFrames[searchEntry] = roleIconFrames
    return roleIconFrames
end

function aura_env:CreateRoleIconFrame(parent, index)
    local frame = CreateFrame("Frame", nil, parent, nil)
    frame:SetFrameStrata("HIGH")
    frame:SetSize(18, 36)
    frame:SetPoint("CENTER")
    frame:SetPoint("RIGHT", parent, "RIGHT", -12 - (5 - index) * 18, 0)
    frame:Hide()

    frame.LeaderCrown = frame:CreateTexture("$parentLeaderCrown", "OVERLAY")
    frame.LeaderCrown:SetSize(10, 5)
    frame.LeaderCrown:SetPoint("TOP", 0, -5)
    frame.LeaderCrown:SetAtlas("groupfinder-icon-leader", false, "LINEAR")
    frame.LeaderCrown:Hide()

    frame.ClassCircle = frame:CreateTexture("$parentClassCircle", "BACKGROUND")
    frame.ClassCircle:SetSize(16, 16)
    frame.ClassCircle:SetPoint("CENTER", 0, -1)
    frame.ClassCircleMask = frame:CreateMaskTexture()
    frame.ClassCircleMask:SetSize(18, 18)
    frame.ClassCircleMask:SetAllPoints(frame.ClassCircle)
    frame.ClassCircleMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    frame.ClassCircle:AddMaskTexture(frame.ClassCircleMask)
    frame.ClassCircle:Hide()

    frame.RoleIcon = frame:CreateTexture("$parentRoleIcon", "ARTWORK")
    frame.RoleIcon:SetSize(12, 12)
    frame.RoleIcon:SetPoint("CENTER", 0, -1)
    frame.RoleIcon:Hide()

    return frame
end

function aura_env:UpdateRoleIconFrameForMember(roleIconFrame, member, isDelisted)
    local color = isDelisted and self.DISABLED_ROLE_INDICATOR_COLOR or RAID_CLASS_COLORS[member.class]
    local alpha = isDelisted and 0.5 or 1.0

    roleIconFrame.ClassCircle:SetColorTexture(color.r, color.g, color.b, 1)
    roleIconFrame.ClassCircle:Show()

    roleIconFrame.RoleIcon:SetAtlas(self.ROLE_ICONS[member.role])
    roleIconFrame.RoleIcon:SetDesaturated(isDelisted)
    roleIconFrame.RoleIcon:SetAlpha(alpha)
    roleIconFrame.RoleIcon:Show()

    if member.isLeader then
        roleIconFrame.LeaderCrown:SetDesaturated(isDelisted)
        roleIconFrame.LeaderCrown:SetAlpha(alpha)
        roleIconFrame.LeaderCrown:Show()
    end

    roleIconFrame:Show()
end

function aura_env:ResetRoleIconFrame(roleIconFrame)
    roleIconFrame:Hide()
    roleIconFrame.LeaderCrown:Hide()
    roleIconFrame.ClassCircle:Hide()
    roleIconFrame.RoleIcon:Hide()
end
