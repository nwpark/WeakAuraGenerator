from lib.common.lua import serializeLuaTable, LuaTable
from lib.weakauras.weakauras import WeakAuras
from slpp import slpp as lua

_savedVariablesPath = 'C:/Program Files (x86)/World of Warcraft/_retail_/WTF/Account/NWPARK/SavedVariables/WeakAuras.lua'
_addonCodePath = 'C:/Program Files (x86)/World of Warcraft/_retail_/Interface/AddOns/WeakAuras'


# enabled
# desc
# spellID
# concernsMeleeDps
# concernsRangedDps
# concernsTank
# concernsHealer
# oncombat: Whether to track spell cooldown based on combat start. You will have to specify a timer AND the unitID of the enemy
# combattimer: Timer for on combat start
#   npcID: Only needed if you use on combat timer
# hideafter: After how many seconds of a state being at 0seconds remaining it'll autohide to prevent something from being stuck forever. 0 = instant
# casttype: When to start Timer (1 = On Cast Start, 2 = On Cast Success)
# defaultCooldown: Duration until next Cast
# cooldownAfterInterrupt: Duration until next Cast if the npc is interrupted (0 = Deactivated)

# npcIDoffset: Overwrite the cooldown for the specified npcID. This should be used when multiple npc's use the same spell but with a different cooldown. You can specifiy multiple unitID's with a space
#   offsetnum: Specify the cooldown for the specified npcID. If you're using multiple npcID's, seperate the individual cooldown by a space
# overwrite: With this you can specify a spellid to be used as icon instead of using the normal icon from the spellid
# progressive: Changing timers based on cast count. Put Numbers seperated by space. First number is the time from 1st to 2nd cast, then 2nd to 3rd cast and so on.
#   repeating: Enabled = Progressive timer will start from the beginning when it reaches the end. Disabled = Lowest value will continue showing.
# spelltrigger: If you want one spell to trigger other spell's(for example a transition spell triggering a cooldown on other spells) this is where you can specifiy those, seperated by a space.
#   spelltimer: Duration when the triggered spells will happen, again seperated by a space if you have multiple
# loop: With this enabled the timer will loop in case the spell was not cast when reaching 0 until either the mob dies or recasts its spell. This is a rare case for mobs that cast their spells on a strict timer and skip casts when they were stunned to still properly track the cd of the next cast, should be used wisely. Does not work with progressive timers
# highlight: Highlighted Spells will be displayed in a seperate Aura


def getDependingSpells(spellIDs, spellTimers):
    if spellIDs == "0" or spellIDs == "":
        return None
    spellIDs = [int(spellID) for spellID in spellIDs.split(' ')]
    spellTimers = [float(spellTimer) for spellTimer in spellTimers.split(' ')]
    return dict(zip(spellIDs, spellTimers))


def getProgressiveCooldowns(progressiveCooldownStr):
    if progressiveCooldownStr == "0" or progressiveCooldownStr == "":
        return None
    return [float(cooldown) for cooldown in progressiveCooldownStr.split(' ')]


def getNpcSpecificCooldowns(npcIDs, cooldownOffsets):
    if npcIDs == "" or cooldownOffsets == "":
        return None
    npcIDs = [npcID for npcID in npcIDs.split(' ')]
    cooldownOffsets = [float(cooldownOffset) for cooldownOffset in cooldownOffsets.split(' ')]
    return dict(zip(npcIDs, cooldownOffsets))


def formatSpellInfo(spellInfoLuaTable):
    return {
        'desc': spellInfoLuaTable.desc,
        'spellID': spellInfoLuaTable.spellID,

        # concerned role fields
        'concernsMeleeDps': spellInfoLuaTable.mdps,
        'concernsRangedDps': spellInfoLuaTable.rdps,
        'concernsTank': spellInfoLuaTable.tank,
        'concernsHealer': spellInfoLuaTable.heal,

        # spell cooldown fields
        'defaultCooldown': spellInfoLuaTable.duration,
        'initialCooldownOnCombat': spellInfoLuaTable.combattimer,
        'progressiveCooldowns': getProgressiveCooldowns(spellInfoLuaTable.progressive),
        'progressiveCooldownRepeats': spellInfoLuaTable.repeating,
        'npcSpecificCooldowns': getNpcSpecificCooldowns(spellInfoLuaTable.npcIDoffset, spellInfoLuaTable.offsetnum),

        # spell cooldown trigger fields
        'cooldownTriggeredOnCastStart': spellInfoLuaTable.casttype == 1,
        'cooldownTriggeredOnCastSuccess': spellInfoLuaTable.casttype == 2,
        'cooldownTriggeredOnCombat': spellInfoLuaTable.oncombat,
        'hideAfter': spellInfoLuaTable.hideafter,

        # other fields
        'iconOverride': spellInfoLuaTable.overwrite,
        'npcID': spellInfoLuaTable.npcID,
        'dependingSpells': getDependingSpells(spellInfoLuaTable.spelltrigger, spellInfoLuaTable.spelltimer),
    }


def run():
    weakAuras = WeakAuras(_addonCodePath, _savedVariablesPath)

    hov = weakAuras.getAura('Halls of Valor')
    cos = weakAuras.getAura('Court of Stars')
    tjs = weakAuras.getAura('Temple of the Jade Serpent')
    sbg = weakAuras.getAura('Shadowmoon Burial Grounds')
    rlp = weakAuras.getAura('Ruby Life Pools')
    no = weakAuras.getAura('The Nokhud Offensive')
    av = weakAuras.getAura('The Azure Vault')
    aa = weakAuras.getAura("Algeth'ar Academy")

    allDungeonAuras = [hov, cos, tjs, sbg, rlp, no, av, aa]

    tjsSpells = no.getConfig()['spells']
    formattedTjsSpellInfo = [formatSpellInfo(spellInfo) for spellInfo in tjsSpells.values()]

    print(lua.encode(formattedTjsSpellInfo))


if __name__ == '__main__':
    run()
