aura_env.logEntries = {}

--DevTools_Dump(self.aura_env)

aura_env.Warn = function(aura_env, tag, message)
    aura_env:AppendLogEntry("WARN", tag, message)
end

aura_env.Info = function(aura_env, tag, message)
    aura_env:AppendLogEntry("INFO", tag, message)
end

aura_env.ShowDebugLog = function(aura_env)
    local tags = aura_env:GetTagsFromLogEntries()
    aura_env:CreateFrames(tags)
    aura_env:RenderLogText()
end

aura_env.ClearLog = function(aura_env)
    aura_env.logEntries = {}
    aura_env:RenderLogText()
end

aura_env.OnDropdownValueChanged = function(aura_env)
    aura_env:RenderLogText()
end

aura_env.AppendLogEntry = function(aura_env, level, tag, message)
    local logEntry = {
        timestamp = time(),
        tag = tag,
        level = level,
        message = message
    }
    table.insert(aura_env.logEntries, logEntry)
    aura_env:AddLogTagToGui(tag)
    aura_env:RenderLogText()
end

aura_env.RenderLogText = function(aura_env)
    local logText = ""
    local filteredLogEntries = aura_env:GetFilteredLogEntries()
    for i, logEntry in ipairs(filteredLogEntries) do
        logText = logText .. aura_env:FormatLogEvent(logEntry, i) .. "\n"
    end
    aura_env:SetGuiText(logText)
end

aura_env.GetFilteredLogEntries = function(aura_env)
    local selectedLevel = aura_env:GetSelectedLogLevel()
    local selectedTag = aura_env:GetSelectedLogTag()
    local filteredLogEntries = {}
    for _, logEntry in ipairs(aura_env.logEntries) do
        local levelMatches = not selectedLevel or (selectedLevel == aura_env.ALL) or (selectedLevel == logEntry.level)
        local tagMatches = not selectedTag or (selectedTag == aura_env.ALL) or (selectedTag == logEntry.tag)
        if tagMatches and levelMatches then
            table.insert(filteredLogEntries, logEntry)
        end
    end
    return filteredLogEntries
end

aura_env.FormatLogEvent = function(aura_env, logEntry, index)
    local prefix = "[" .. aura_env:FormatTimestamp(logEntry.timestamp) .. "] [" .. logEntry.level .. "]"
    return prefix .. ": " .. logEntry.message
end

aura_env.GetTagsFromLogEntries = function(aura_env)
    local tags = {}
    tags[aura_env.ALL] = aura_env.ALL
    for _, logEntry in ipairs(aura_env.logEntries) do
        tags[logEntry.tag] = logEntry.tag
    end
    return tags
end
