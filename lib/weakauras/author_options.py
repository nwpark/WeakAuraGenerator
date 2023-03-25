import os

from lib.common.lua import LuaTable, getNestedLuaTables


class AuthorOption:
    def __init__(self, luaTable: LuaTable):
        self._luaTable = luaTable

    @property
    def key(self) -> str:
        return self._luaTable['key']

    @key.setter
    def key(self, key: str):
        self._luaTable['key'] = key

    @property
    def name(self) -> str:
        return self._luaTable['name']

    @name.setter
    def name(self, name: str):
        self._luaTable['name'] = name

    @property
    def default(self):
        return self._luaTable['default']

    @default.setter
    def default(self, default):
        self._luaTable['default'] = default


class AuthorOptionNumber(AuthorOption):
    def __init__(self, luaTable: LuaTable):
        super().__init__(luaTable)

    @property
    def min(self) -> int:
        return self._luaTable['min']

    @min.setter
    def min(self, min: int):
        self._luaTable['min'] = min

    @property
    def max(self) -> int:
        return self._luaTable['max']

    @max.setter
    def max(self, max: int):
        self._luaTable['max'] = max

    @property
    def step(self) -> int:
        return self._luaTable['step']

    @step.setter
    def step(self, step: int):
        self._luaTable['step'] = step


def createAuthorOptionFromLuaTable(luaTable):
    if luaTable["type"] == "toggle":
        return AuthorOption(luaTable)
    if luaTable["type"] == "number":
        return AuthorOptionNumber(luaTable)


class AuthorOptions:
    def __init__(self, luaTable: LuaTable):
        self._luaTable = luaTable

    @property
    def luaTable(self):
        return self._luaTable

    @property
    def options(self):
        return [createAuthorOptionFromLuaTable(luaTable) for luaTable in self._luaTable]
