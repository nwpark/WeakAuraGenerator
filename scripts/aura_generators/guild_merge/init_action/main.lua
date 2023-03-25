local function initializeGetMemberIdsSortedByName()
  local getMemberIdsSortedByName = CommunitiesUtil.GetMemberIdsSortedByName
  CommunitiesUtil.GetMemberIdsSortedByName = function(...)
    local clubId, streamId = ...
    if clubId ~= C_Club.GetGuildClubId() then
      return getMemberIdsSortedByName(...)
    end
    local memberIds = getMemberIdsSortedByName(...)
    table.insert(memberIds, 9999)
    return memberIds
  end
end

local function initializeGetMemberInfo()
  local getMemberInfo = CommunitiesUtil.GetMemberInfo
  CommunitiesUtil.GetMemberInfo = function(...)
    local clubId, memberIds = ...
    if clubId ~= C_Club.GetGuildClubId() then
      return getMemberInfo(...)
    end
    local memberInfo = getMemberInfo(...)
    table.insert(memberInfo, {
      profession2ID=182,
      profession2Rank=1,
      guid="Player-1084-0A329401",
      clubType=2,
      presence=1,
      profession1Rank=600,
      profession2Name="Herbalism",
      role=4,
      profession1ID=202,
      isRemoteChat=false,
      level=70,
      achievementPoints=4620,
      overallDungeonScore=3090,
      guildRankOrder=5,
      memberId=9999,
      guildRank="Raider",
      profession1Name="Engineering",
      classID=7,
      isSelf=false,
      name="Elrix",
      faction=0,
      zone="GM Island",
      memberNote="Too good for Aeon",
      race=2
    })
    return memberInfo
  end
end

aura_env.RunCommand = function(command)
  ChatFrame1EditBox:Insert("/run " .. command)
  ChatEdit_ParseText(ChatFrame1EditBox)
end

aura_env.StoreGlobal = function(index, value)
  aura_env.RunCommand(index .. " = " .. tostring(value))
end

if not GuildMergerInitialized then
  print('Initializing aura: GuildMerger')
  C_ChatInfo.RegisterAddonMessagePrefix("GM_INSERT_ID")
  C_ChatInfo.RegisterAddonMessagePrefix("GM_INSERT_MEMBER")
  initializeGetMemberIdsSortedByName()
  initializeGetMemberInfo()
  aura_env.StoreGlobal("GuildMergerInitialized", true)
end

table.insert(CommunitiesFrame.MemberList.memberIds, 999)
table.insert(CommunitiesFrame.MemberList.allMemberList, {
      profession2ID=182,
      profession2Rank=1,
      guid="Player-1084-0A329401",
      clubType=2,
      presence=1,
      profession1Rank=600,
      profession2Name="Herbalism",
      role=4,
      profession1ID=202,
      isRemoteChat=false,
      level=70,
      achievementPoints=4620,
      overallDungeonScore=3090,
      guildRankOrder=5,
      memberId=9999,
      guildRank="Raider",
      profession1Name="Engineering",
      classID=7,
      isSelf=false,
      name="Elrix",
      faction=0,
      zone="GM Island",
      memberNote="Too good for Aeon",
      race=2
})
CommunitiesFrame.MemberList:UpdateMemberCount()
CommunitiesFrame.MemberList:Update()