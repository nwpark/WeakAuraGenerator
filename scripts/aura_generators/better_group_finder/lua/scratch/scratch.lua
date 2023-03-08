NickSearchBox = CreateFrame("EditBox", "LFGListSearchBox", LFGListFrame.SearchPanel, "SearchBoxTemplate", nil)
NickSearchBox:SetAttribute("parentKey", "SearchBox")
--NickSearchBox:SetAttribute("secureReferenceKey", "LFGListSearchBox")
--NickSearchBox:SetAttribute("securityDisableSetText", "true")
--NickSearchBox:SetAttribute("securityDisablePaste", "true")
NickSearchBox:SetAttribute("inherits", "SearchBoxTemplate")
NickSearchBox:SetAttribute("letters", "64")
--NickSearchBox:RegisterEvent("OnEnterPressed")
--NickSearchBox:RegisterEvent("OnTabPressed")
--NickSearchBox:RegisterEvent("OnArrowPressed")
--NickSearchBox:RegisterEvent("OnTextChanged")
--NickSearchBox:RegisterEvent("OnEditFocusGained")
--NickSearchBox:RegisterEvent("OnEditFocusLost")
--NickSearchBox:SetScript("OnEnterPressed", LFGListSearchPanelSearchBox_OnEnterPressed)
--NickSearchBox:SetScript("OnTabPressed", LFGListSearchPanelSearchBox_OnTabPressed)
--NickSearchBox:SetScript("OnArrowPressed", LFGListSearchPanelSearchBox_OnArrowPressed)
--NickSearchBox:SetScript("OnTextChanged", LFGListSearchPanelSearchBox_OnTextChanged)
--NickSearchBox:SetScript("OnEditFocusGained", function(self)
--    LFGListSearchPanel_UpdateAutoComplete(LFGListFrame.SearchPanel)
--    SearchBoxTemplate_OnEditFocusGained(self)
--end)
--NickSearchBox:SetScript("OnEditFocusLost", function(self)
--    LFGListSearchPanel_UpdateAutoComplete(LFGListFrame.SearchPanel)
--    SearchBoxTemplate_OnEditFocusLost(self)
--end)
NickSearchBox:SetText("19-19")
RealLFGListFrameSearchBox = LFGListFrame.SearchPanel.SearchBox
LFGListFrame.SearchPanel.SearchBox = NickSearchBox
LFGListSearchPanel_DoSearch(NickSearchBox)
LFGListFrame.SearchPanel.SearchBox = RealLFGListFrameSearchBox


LFGListFrame.SearchPanel.SearchBox:SetAttribute("secureReferenceKey", "LFGListSearchBox")
LFGListFrame.SearchPanel.SearchBox:SetAttribute("securityDisableSetText", "false")
LFGListFrame.SearchPanel.SearchBox:SetAttribute("securityDisablePaste", "false")
LFGListFrame.SearchPanel.SearchBox:SetText("19")
LFGListFrame.SearchPanel.SearchBox.OnEnterPressed = function(self) print("nick") end

LFGListSearchPanelSearchBox_OnEnterPressed = function(self) print("nick") end

LFGListSearchPanel_OnShow
LFGListSearchPanel_InitButton
LFGListSearchPanel_UpdateResultList
LFGListSearchPanel_UpdateButtonStatus
LFGListSearchPanel_SetCategory
LFGListSearchPanel_SignUp
LFGListSearchPanel_AutoCompleteAdvance
LFGListSearchPanel_UpdateResults
LFGListSearchPanel_OnEvent
LFGListSearchPanel_Clear
LFGListSearchPanel_DoSearch
LFGListSearchPanel_SelectResult
LFGListSearchPanel_OnLoad
LFGListSearchPanel_UpdateAutoComplete
LFGListSearchPanel_ValidateSelected
LFGListSearchPanel_EvaluateTutorial
LFGListSearchPanel_CreateGroupInstead

C_LFGList.DeclineApplicant
C_LFGList.GetApplicantDungeonScoreForListing
C_LFGList.GetApplicantPvpRatingInfoForListing
C_LFGList.GetOwnedKeystoneActivityAndGroupAndLevel
C_LFGList.RefreshApplicants
C_LFGList.GetNumPendingApplicantMembers
C_LFGList.IsPlayerAuthenticatedForLFG
C_LFGList.GetApplicationInfo
C_LFGList.ClearCreationTextFields
C_LFGList.GetSearchResults
C_LFGList.GetSearchResultEncounterInfo
C_LFGList.GetLfgCategoryInfo
C_LFGList.ApplyToGroup
C_LFGList.GetNumApplicants
C_LFGList.GetAvailableActivities
C_LFGList.RequestAvailableActivities
C_LFGList.Search
C_LFGList.SetSearchToQuestID
C_LFGList.GetDefaultLanguageSearchFilter
C_LFGList.IsCurrentlyApplying
C_LFGList.SaveLanguageSearchFilter
C_LFGList.SetSearchToActivity
C_LFGList.AcceptInvite
C_LFGList.GetActivityInfoTable
C_LFGList.GetActivityGroupInfo
C_LFGList.UpdateListing
C_LFGList.GetApplicants
C_LFGList.GetSearchResultMemberInfo
C_LFGList.GetAvailableLanguageSearchFilter
C_LFGList.HasSearchResultInfo
C_LFGList.GetApplicant Info
C_LFGList.GetApplicantMemberStats
C_LFGList.DeclineInvite
C_LFGList.RemoveListing
C_LFGList.GetFilteredSearchResults
C_LFGList.CanCreateQuestGroup
C_LFGList.HasActivityList
C_LFGList.ClearSearchResults
C_LFGList.ValidateRequiredPvpRatingForActivity
C_LFGList.RemoveApplicant
C_LFGList.GetActivityFullName
C_LFGList.InviteApplicant
C_LFGList.GetLanguageSearchFilter
C_LFGList.GetApplications
C_LFGList.GetRoleCheckInfo
C_LFGList.SetEntryTitle
C_LFGList.GetApplicantMemberInfo
C_LFGList.ValidateRequiredDungeonScore
C_LFGList.HasActiveEntryInfo
C_LFGList.DoesEntryTitleMatchPrebuiltTitle
C_LFGList.GetSearchResultInfo
C_LFGList.CanActiveEntryUseAutoAccept
C_LFGList.GetPlaystyleString
C_LFGList.GetNumInvitedApplicantMembers
C_LFGList.GetSearchResultFriends
C_LFGList.GetKeystoneForActivity
C_LFGList.GetAvailableCategories
C_LFGList.SetApplicantMemberRole
C_LFGList.CreateListing
C_LFGList.GetAvailableRoles
C_LFGList.GetAvailableActivityGroups
C_LFGList.ClearApplicationTextFields
