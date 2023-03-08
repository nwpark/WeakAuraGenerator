from lib.common.lua import serializeLuaTable, parseLuaTableFromString
import lib.aura_import.aura_import as aura_import
from lib.weakauras.aura import Aura


class WeakAuras:
    def __init__(self, addonCodePath: str, savedVariablesPath: str):
        self._addonCodePath = addonCodePath
        self._savedVariablesPath = savedVariablesPath
        with open(savedVariablesPath, mode='r', encoding='utf8') as file:
            self._luaTable = parseLuaTableFromString('{' + file.read() + '}')['WeakAurasSaved']
        self._allAurasLuaTable = self._luaTable['displays']

    def getAura(self, auraName: str) -> Aura:
        return Aura(self._allAurasLuaTable, auraName)

    def cloneExistingAura(self, auraName: str, newAuraName: str) -> Aura:
        if self._allAurasLuaTable[newAuraName]:
            raise KeyError('An aura already exists with name ' + newAuraName)
        newAuraLuaTable = self.getAura(auraName).cloneLuaTable(newAuraName)
        self._allAurasLuaTable[newAuraName] = newAuraLuaTable
        return self.getAura(newAuraName)

    def generateImporterForAura(self, aura: Aura):
        aura_import.appendImporterToToc(self._addonCodePath + '/WeakAuras.toc')
        aura_import.generateImporter(self._addonCodePath, aura)

    def getDebugString(self) -> str:
        return serializeLuaTable(self._allAurasLuaTable)
