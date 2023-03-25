from lib.aura_import.aura_import import generateImporter
from lib.common.lua import serializeLuaTable, parseLuaTableFromString, LuaTable
from lib.weakauras.aura import Aura


class WeakAuras:
    def __init__(self, addonCodePath: str, savedVariablesPath: str):
        self._addonCodePath = addonCodePath
        self._savedVariablesPath = savedVariablesPath
        with open(savedVariablesPath, mode='r', encoding='utf8') as file:
            self._luaTable = parseLuaTableFromString('{' + file.read() + '}')['WeakAurasSaved']
        self._allAurasLuaTable = self._luaTable['displays']

    def auraExists(self, auraName: str) -> Aura:
        return self._allAurasLuaTable[auraName] is not None

    def getAura(self, auraName: str) -> Aura:
        if not self._allAurasLuaTable[auraName]:
            raise KeyError('No aura found with name ' + auraName)
        return Aura(self._allAurasLuaTable[auraName], auraName)

    def cloneExistingAura(self, auraName: str, newAuraName: str) -> Aura:
        if self._allAurasLuaTable[newAuraName]:
            raise KeyError('An aura already exists with name ' + newAuraName)
        newAuraLuaTable = self.getAura(auraName).cloneLuaTable(newAuraName)
        self._allAurasLuaTable[newAuraName] = newAuraLuaTable
        return self.getAura(newAuraName)

    def cloneAuraFromLuaTable(self, newAuraName: str, newAuraLuaTable: LuaTable) -> Aura:
        if self._allAurasLuaTable[newAuraName]:
            raise KeyError('An aura already exists with name ' + newAuraName)
        self._allAurasLuaTable[newAuraName] = newAuraLuaTable
        return self.getAura(newAuraName)

    def generateImporterForAura(self, aura: Aura, importerAddonDirectory: str):
        generateImporter(aura, importerAddonDirectory)

    def printDebugString(self):
        print(serializeLuaTable(self._allAurasLuaTable))
