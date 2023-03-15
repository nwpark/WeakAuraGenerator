function(event, tag, message)
    if event == "DEBUG_LOG_WARN" then
        aura_env:Warn(tag, message)
    elseif event == "DEBUG_LOG_INFO" then
        aura_env:Info(tag, message)
    elseif event == "DEBUG_LOG_SHOW" then
        aura_env:ShowDebugLog()
    elseif event == "STATUS" then
        print('statuus')
    end
end
