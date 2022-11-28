from lib.common.lua import serializeLuaTable, parseLuaTableFromString
from lib.weakauras.weakaura import WeakAura


class WeakAuras:
    def __init__(self, savedAurasPath: str):
        self._savedAurasPath = savedAurasPath
        with open(savedAurasPath, mode='r', encoding='utf8') as file:
            self._luaTable = parseLuaTableFromString('{' + file.read() + '}')['WeakAurasSaved']
        self._allAurasLuaTable = self._luaTable['displays']

    def getAura(self, auraName: str) -> WeakAura:
        return WeakAura(self._allAurasLuaTable, auraName)

    def cloneExistingAura(self, auraName: str, newAuraName: str) -> WeakAura:
        if self._allAurasLuaTable[newAuraName]:
            raise KeyError('An aura already exists with name ' + newAuraName)
        newAuraLuaTable = self.getAura(auraName).cloneLuaTable(newAuraName)
        self._allAurasLuaTable[newAuraName] = newAuraLuaTable
        return self.getAura(newAuraName)

    def saveChanges(self):
        serializedLua = 'WeakAurasSaved = ' + serializeLuaTable(self._luaTable)
        with open(self._savedAurasPath, mode='w', encoding='utf8') as file:
            file.write(serializedLua)

    def getDebugString(self) -> str:
        return serializeLuaTable(self._allAurasLuaTable)
