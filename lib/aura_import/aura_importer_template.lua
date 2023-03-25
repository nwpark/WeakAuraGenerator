local _, Private = ...

AuraImporter = AuraImporter or LibStub("AceAddon-3.0"):NewAddon("AuraImporter", "AceConsole-3.0")

local function onAddonLoaded()
    if Private.IsAuraUpToDate("AURA_NAME", "AURA_HASH") then
        AuraImporter:Print("'AURA_NAME' is already up to date")
    else
        AuraImporter:Print("Updating aura 'AURA_NAME'")
        WeakAurasSaved["displays"]["AURA_NAME"] = AURA_SERIALIZED
        Private.SetAuraHash("AURA_NAME", "AURA_HASH")
    end
end

local function areBothAddonsLoadedForFirstTime(loadedAddOnName)
    if not (loadedAddOnName == "WeakAuras" or loadedAddOnName == "AuraImporter") then
        return false
    end
    return IsAddOnLoaded("WeakAuras") and IsAddOnLoaded("AuraImporter") and WeakAurasSaved and AuraImporterSaved
end

local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(self, event, addOnName)
		if addOnName == "AuraImporter" then
			AuraImporterSaved = AuraImporterSaved or {}
		end
        if areBothAddonsLoadedForFirstTime(addOnName) then
            onAddonLoaded()
        end
end)
