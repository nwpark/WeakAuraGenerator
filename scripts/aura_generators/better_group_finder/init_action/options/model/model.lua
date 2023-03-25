---@shape ModelKeys
---@field autoRefresh string
---@field minimumRioScoreEnabled string
---@field minimumRioScoreInput string
---@field AA string
---@field AV string
---@field COS string
---@field HOV string
---@field NO string
---@field RLP string
---@field SBG string
---@field TJS string
---@field givesScoreAtKeyLevelEnabled string
---@field givesScoreAtKeyLevelInput string
---@field hasSlotForPlayerRole string
---@field hasSlotForPlayerClass string
---@field hasSlotsForPartyRoles string
---@field hasBloodlust string
---@field hasCurseDispel string
---@field hasPoisonDispel string
aura_env.modelKeys = {
    autoRefresh = "autoRefresh",
    minimumRioScoreEnabled = "minimumRioScoreEnabled",
    minimumRioScoreInput = "minimumRioScoreInput",
    AA = "AA",
    AV = "AV",
    COS = "COS",
    HOV = "HOV",
    NO = "NO",
    RLP = "RLP",
    SBG = "SBG",
    TJS = "TJS",
    givesScoreAtKeyLevelEnabled = "givesScoreAtKeyLevelEnabled",
    givesScoreAtKeyLevelInput = "givesScoreAtKeyLevelInput",
    hasSlotForPlayerRole = "hasSlotForPlayerRole",
    hasSlotForPlayerClass = "hasSlotForPlayerClass",
    hasSlotsForPartyRoles = "hasSlotsForPartyRoles",
    hasBloodlust = "hasBloodlust",
    hasCurseDispel = "hasCurseDispel",
    hasPoisonDispel = "hasPoisonDispel",
}

---@shape ModelValues
---@field autoRefresh boolean
---@field minimumRioScoreEnabled boolean
---@field minimumRioScoreInput number
---@field AA boolean
---@field AV boolean
---@field COS boolean
---@field HOV boolean
---@field NO boolean
---@field RLP boolean
---@field SBG boolean
---@field TJS boolean
---@field givesScoreAtKeyLevelEnabled boolean
---@field givesScoreAtKeyLevelInput number
---@field hasSlotForPlayerRole boolean
---@field hasSlotForPlayerClass boolean
---@field hasSlotsForPartyRoles boolean
---@field hasBloodlust boolean
---@field hasCurseDispel boolean
---@field hasPoisonDispel boolean
aura_env.modelValues = nil

function aura_env:InitializeModelValues()
    if self.modelValues then
        return
    end
    self.modelValues = self:GetWAConfig() or {
        autoRefresh = false,
        minimumRioScoreEnabled = false,
        minimumRioScoreInput = 2500,
        AA = true,
        AV = true,
        COS = true,
        HOV = true,
        NO = true,
        RLP = true,
        SBG = true,
        TJS = true,
        givesScoreAtKeyLevelEnabled = false,
        givesScoreAtKeyLevelInput = 0,
        hasSlotForPlayerClass = true,
        hasSlotForPlayerRole = true,
        hasSlotsForPartyRoles = false,
        hasBloodlust = false,
        hasCurseDispel = false,
        hasPoisonDispel = false,
    }
    if self.modelValues.givesScoreAtKeyLevelInput == 0 then
        self.modelValues.givesScoreAtKeyLevelInput = self:GetLowestTimedKeyLevelForCurrentAffix() + 1
    end
    if self.modelValues.minimumRioScoreInput == 0 then
        self.modelValues.minimumRioScoreInput = 2500
    end
end
