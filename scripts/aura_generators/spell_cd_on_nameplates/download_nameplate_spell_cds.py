from lib.common.lua import serializeLuaTable
from lib.weakauras.weakauras import WeakAuras
from slpp import slpp as lua


_savedVariablesPath = 'C:/Program Files (x86)/World of Warcraft/_retail_/WTF/Account/NWPARK/SavedVariables/WeakAuras.lua'
_addonCodePath = 'C:/Program Files (x86)/World of Warcraft/_retail_/Interface/AddOns/WeakAuras'


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

    # print(tjs.getActions().initAction.customFunctionAsString)
    # print(tjs.getTriggers()[0].triggerFunctionAsString)
    # print(serializeLuaTable(tjs.getConfig()['spells']))
    # print(tjs.getDebugString())

    # for i, line in enumerate(tjs.getActions().initAction.customFunctionAsString.split('\n')):
        # print(str(i) + ': ' + line)


    for dungeon in allDungeonAuras:
        for spellInfo in dungeon.getConfig()['spells'].values():
            if spellInfo.hideafter != 10:
                print(spellInfo.hideafter, dungeon.getName(), spellInfo.desc)

    # print(tjs.getActions().initAction.customFunctionAsString.count('aura_env.bossunit'))

    # print(serializeLuaTable(no.getConfig()['spells']))

    # for aura in allDungeonAuras:
    #     print(aura.getDebugString().count('[\"npcIDoffset\"] = \"\"'), aura.getDebugString().count('[\"npcIDoffset\"]'))


if __name__ == '__main__':
    run()
