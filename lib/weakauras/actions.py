import os

from lib.common.lua import LuaTable


class Action:
    def __init__(self, actionLuaTable: LuaTable):
        self._actionLuaTable = actionLuaTable

    @property
    def customFunctionAsString(self) -> str:
        return self._actionLuaTable['custom']

    @customFunctionAsString.setter
    def customFunctionAsString(self, customFunctionAsString: str):
        self._actionLuaTable['custom'] = customFunctionAsString

    def exportCustomFunctionToFile(self, directory: str, fileName: str):
        filePath = os.path.join(directory, fileName)
        with open(filePath, mode='w', encoding='utf8') as file:
            file.write(self.customFunctionAsString)

    def importCustomFunctionFromFile(self, directory: str, fileName: str):
        filePath = os.path.join(directory, fileName)
        with open(filePath, mode='r', encoding='utf8') as file:
            luaCodeAsString = file.read()
            self.customFunctionAsString = luaCodeAsString


class Actions:
    def __init__(self, luaTable: LuaTable):
        self._initAction = Action(luaTable['init'])
        self._startAction = Action(luaTable['start'])
        self._finishAction = Action(luaTable['finish'])

    @property
    def initAction(self) -> Action:
        return self._initAction

    @property
    def startAction(self) -> Action:
        return self._startAction

    @property
    def finishAction(self) -> Action:
        return self._finishAction
