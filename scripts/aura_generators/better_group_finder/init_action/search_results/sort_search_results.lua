function aura_env:SortSearchResults(searchResults)
    -- TODO: pending results at top
    table.sort(searchResults, function(searchResultID1, searchResultID2)
        local compareApplicationStates = self:CompareApplicationStates(searchResultID1, searchResultID2)
        local compareRioScore = self:CompareRioScore(searchResultID1, searchResultID2)

        if compareApplicationStates ~= 0 then
            return compareApplicationStates > 0
        elseif compareRioScore ~= 0 then
            return compareRioScore > 0
        else
            return searchResultID1 > searchResultID2
        end
    end)
end

function aura_env:CompareApplicationStates(searchResultID1, searchResultID2)
    local applicationState1 = self:GetApplicationState(searchResultID1)
    local applicationState2 = self:GetApplicationState(searchResultID2)
    if applicationState1 == applicationState2 then
        return 0
    elseif applicationState1 == self.OKAY then
        return 1
    else
        return -1
    end
end

function aura_env:CompareRioScore(searchResultID1, searchResultID2)
    local rioScore1 = self:GetLeaderInfoForSearchResult(searchResultID1).rioScore
    local rioScore2 = self:GetLeaderInfoForSearchResult(searchResultID2).rioScore
    if rioScore1 == rioScore2 then
        return 0
    elseif not rioScore1 then
        return -1
    elseif not rioScore2 then
        return 1
    else
        return rioScore1 - rioScore2
    end
end
