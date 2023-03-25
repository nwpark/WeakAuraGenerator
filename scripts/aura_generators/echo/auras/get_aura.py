from enum import Enum
from os import path

from lib.common.lua import parseLuaTableFromFile
from lib.weakauras.aura import Aura
from lib.weakauras.weakauras import WeakAuras


class AuraType(Enum):
    Icon = 1
    Bar = 2

    def templateAuraName(self):
        if self.name == self.Icon.name:
            return 'Icon Aura example'

    def templateFileName(self):
        if self.name == self.Icon.name:
            return 'icon_aura_template.lua'


def getOrCreateAura(weakAuras: WeakAuras, auraName: str, parentGroupName: str, auraType: AuraType) -> Aura:
    if weakAuras.auraExists(auraName):
        aura = weakAuras.getAura(auraName)
        if aura.luaTable['parent'] == parentGroupName:
            print(f"Updating existing aura '{auraName}'")
            return aura

    # Some of Meeres' auras have trailing whitespace in the name (I think it's to avoid naming collisions)
    auraNameMeeresStyle = f'{auraName} '
    if weakAuras.auraExists(auraNameMeeresStyle):
        aura = weakAuras.getAura(auraNameMeeresStyle)
        if aura.luaTable['parent'] == parentGroupName:
            print(f"Updating existing aura '{auraName}' (Meeres style)")
            return aura

    if weakAuras.auraExists(auraType.templateAuraName()):
        print(f"Creating new aura from in-game template '{auraName}'")
        return weakAuras.cloneExistingAura(auraType.templateAuraName(), auraName)

    print(f"Creating new aura from template file '{auraName}'")
    luaTable = parseLuaTableFromFile(path.dirname(__file__), f'templates/{auraType.templateFileName()}')
    return weakAuras.cloneAuraFromLuaTable(auraName, luaTable)
