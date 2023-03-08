import os
from typing import Union

from lib.common.lua import LuaTable, validateLuaCode


class Trigger:
    def __init__(self, luaTable: LuaTable):
        self._triggerLuaTable = luaTable['trigger']
        self._untriggerLuaTable = luaTable['untrigger']


class CustomTsuTrigger(Trigger):
    def __init__(self, luaTable: LuaTable):
        super(CustomTsuTrigger, self).__init__(luaTable)
        self._checkOn = self._triggerLuaTable['check']  # string enum: ['event', 'update']
        self._events = self._triggerLuaTable['events']  # list of trigger events

    @property
    def triggerFunctionAsString(self) -> str:
        return self._triggerLuaTable['custom']

    @triggerFunctionAsString.setter
    def triggerFunctionAsString(self, triggerFunctionAsString: str):
        # validateLuaCode(triggerFunctionAsString)
        self._triggerLuaTable['custom'] = triggerFunctionAsString

    def exportTriggerFunctionToFile(self, directory: str, fileName: str = 'tsu.lua'):
        filePath = os.path.join(directory, fileName)
        with open(filePath, mode='w', encoding='utf8') as file:
            file.write(self.triggerFunctionAsString)

    def importTriggerFunctionFromFile(self, directory: str, fileName: str = 'tsu.lua'):
        filePath = os.path.join(directory, fileName)
        with open(filePath, mode='r', encoding='utf8') as file:
            luaCodeAsString = file.read()
            # validateLuaCode(luaCodeAsString)
            self.triggerFunctionAsString = luaCodeAsString


class CustomEventTrigger(Trigger):
    def __init__(self, luaTable: LuaTable):
        super(CustomEventTrigger, self).__init__(luaTable)
        self._events = self._triggerLuaTable['events']  # list of trigger/untrigger events
        self._triggerFunction = self._triggerLuaTable['custom']  # custom trigger function as string
        self._customHide = self._triggerLuaTable['custom_hide']  # string enum: ['custom', 'timed']
        if self._customHide == 'custom':
            self._untriggerFunction = self._untriggerLuaTable['custom']  # custom untrigger function as string
        elif self._customHide == 'timed':
            self._dynamicDuration = self._triggerLuaTable['dynamicDuration'] == 'true'
            if self._dynamicDuration:
                raise NotImplementedError('Missing implementation for dynamic duration untrigger')
            else:
                self._duration = self._untriggerLuaTable['duration']  # integer


class SpellTrigger(Trigger):
    def __init__(self, luaTable: LuaTable):
        super().__init__(luaTable)

    def setSpellName(self, spellName: str):
        self._triggerLuaTable['spellName'] = spellName


TriggerSubType = Union[CustomTsuTrigger, CustomEventTrigger, SpellTrigger]


def createTriggerFromLuaTable(luaTable: LuaTable) -> TriggerSubType:
    triggerLuaTable = luaTable['trigger']
    triggerType = triggerLuaTable['type']
    if triggerType == 'custom':
        return _createCustomTriggerFromLuaTable(luaTable)
    elif triggerType == 'spell':
        return SpellTrigger(luaTable)
    else:
        raise NotImplementedError('Missing implementation for trigger type ' + triggerType)


def _createCustomTriggerFromLuaTable(luaTable: LuaTable) -> TriggerSubType:
    customTriggerType = luaTable['trigger']['custom_type']  # string enum: ['event', 'update']
    if customTriggerType == 'stateupdate':
        return CustomTsuTrigger(luaTable)
    elif customTriggerType == 'event':
        return CustomEventTrigger(luaTable)
    else:
        raise NotImplementedError('Missing implementation for custom trigger type ' + customTriggerType)
