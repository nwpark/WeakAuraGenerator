import random
import string
from typing import List

from lib.common.lua import getNestedLuaTables, serializeLuaTable, LuaTable, parseLuaTableFromString
from lib.weakauras.actions import Actions
from lib.weakauras.author_options import AuthorOptions
from lib.weakauras.trigger import createTriggerFromLuaTable, TriggerSubType


class Aura:
    def __init__(self, luaTable: LuaTable, auraName: str):
        self._luaTable = luaTable
        self._auraName = auraName

    def getName(self) -> str:
        return self._auraName

    @property
    def luaTable(self) -> LuaTable:
        return self._luaTable

    @property
    def name(self) -> str:
        return self._auraName

    @name.setter
    def name(self, name: str):
        self._auraName = name

    @property
    def description(self) -> str:
        return self._luaTable['desc']

    @property
    def textSubRegions(self) -> list[LuaTable]:
        subRegionLuaTables = getNestedLuaTables(self._luaTable['subRegions'])
        return [subRegion for subRegion in subRegionLuaTables if subRegion['type'] == 'subtext']

    @property
    def triggers(self) -> List[TriggerSubType]:
        triggerLuaTables = getNestedLuaTables(self._luaTable['triggers'])
        return [createTriggerFromLuaTable(luaTable) for luaTable in triggerLuaTables]

    @description.setter
    def description(self, description: str):
        self._luaTable['desc'] = description

    def getCustomTextFunction(self) -> str:
        return self._luaTable['customText']

    def getActions(self) -> Actions:
        return Actions(self._luaTable['actions'])

    def getAuthorOptions(self) -> AuthorOptions:
        return AuthorOptions(self._luaTable['authorOptions'])

    def setAuthorOptions(self, authorOptions: AuthorOptions):
        self._luaTable['authorOptions'] = authorOptions

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

    def hashCode(self) -> str:
        return str(hash(self.serialize()))

    def getDebugString(self) -> str:
        return self.serialize()

    def printDebugString(self):
        print(self.getDebugString())
