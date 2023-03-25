function aura_env:IsWeakAuraLoaded(auraName)
    local weakAurasSavedDisplays = self:GetWeakAurasSavedDisplays()
    return weakAurasSavedDisplays and weakAurasSavedDisplays[auraName] ~= nil
end

function aura_env:SetWAConfigValue(key, value)
    local config = self:GetWAConfig()
    if not config then
        return
    end
    config[key] = value
end

function aura_env:GetWAConfig()
    local weakAurasSavedDisplays = self:GetWeakAurasSavedDisplays()
    return weakAurasSavedDisplays and weakAurasSavedDisplays[self.id] and weakAurasSavedDisplays[self.id]["config"]
end

function aura_env:GetWeakAurasSavedDisplays()
    if not WeakAurasSavedAlias then
        ChatFrame1EditBox:Insert("/run WeakAurasSavedAlias = WeakAurasSaved")
        ChatEdit_ParseText(ChatFrame1EditBox)
    end
    return (WeakAurasSavedAlias and WeakAurasSavedAlias.displays) or {}
end
