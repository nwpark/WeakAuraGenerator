import random
import string
from typing import List

from lib.common.lua import getNestedLuaTables, serializeLuaTable, LuaTable, parseLuaTableFromString
from lib.weakauras.actions import Actions
from lib.weakauras.trigger import createTriggerFromLuaTable, TriggerSubType


class Aura:
    def __init__(self, allAurasLuaTable: LuaTable, auraName: str):
        self._luaTable = allAurasLuaTable[auraName]
        self._auraName = auraName
        if not self._luaTable:
            raise KeyError('No aura found with name ' + auraName)

    def getName(self) -> str:
        return self._auraName

    def getCustomTextFunction(self) -> str:
        return self._luaTable['customText']

    def getTriggers(self) -> List[TriggerSubType]:
        triggerLuaTables = getNestedLuaTables(self._luaTable['triggers'])
        return [createTriggerFromLuaTable(luaTable) for luaTable in triggerLuaTables]

    def getActions(self) -> Actions:
        return Actions(self._luaTable['actions'])

    def getConfig(self) -> LuaTable:
        return self._luaTable['config']

    def cloneLuaTable(self, newAuraName: str) -> LuaTable:
        deepCopy = parseLuaTableFromString(self.serialize())
        uid = ''.join(random.choice(string.ascii_letters) for _ in range(11))
        deepCopy['id'] = newAuraName
        deepCopy['uid'] = uid
        return deepCopy

    def serialize(self) -> str:
        return serializeLuaTable(self._luaTable)

    def getDebugString(self) -> str:
        return self.serialize()
