local _, Private = ...

function Private.SetAuraHash(auraName, auraHash)
    AuraImporterSaved[auraName] = auraHash
end

function Private.IsAuraUpToDate(auraName, auraHash)
    return AuraImporterSaved[auraName] == auraHash
end
