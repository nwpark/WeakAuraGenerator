function aura_env:DebugInfo(message)
    WeakAuras.ScanEvents("DEBUG_LOG_INFO", 'BetterGroupFinder', message)
end

function aura_env:DebugWarn(message)
    WeakAuras.ScanEvents("DEBUG_LOG_WARN", 'BetterGroupFinder', message)
end
