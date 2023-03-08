local f = CreateFrame("Frame")
    f:RegisterEvent("ADDON_LOADED")
    f:SetScript("OnEvent", function(self, event, addOnName)
        if addOnName == "WeakAuras" and WeakAurasSaved then
            WeakAurasSaved["displays"]["AURA_NAME"] = AURA_SERIALIZED
        end
end)
