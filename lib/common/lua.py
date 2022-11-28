from typing import List, Dict

import lupa

# LuaTable is not actually equivalent to Dict, but it's useful for strong typing and I cba writing a type class (:
LuaTable = Dict

_luaRuntime = lupa.LuaRuntime()


def parseLuaTableFromString(luaTableStr: str) -> LuaTable:
    return _luaRuntime.eval(luaTableStr)


def getNestedLuaTables(luaTable: LuaTable) -> List[LuaTable]:
    return [luaTable[key] for key in luaTable if lupa.lua_type(luaTable[key]) == 'table']


def serializeLuaTable(luaTable: LuaTable, indentationLevel: int = 0) -> str:
    result = '{\n'
    for key in luaTable:
        result += '\t' * (indentationLevel + 1)
        if isinstance(key, str):
            result += '["' + _createEscapedString(key) + '"] = '

        if lupa.lua_type(luaTable[key]) == 'table':
            result += serializeLuaTable(luaTable[key], indentationLevel + 1)
        elif type(luaTable[key]) in (int, float):
            result += str(luaTable[key])
        elif isinstance(luaTable[key], bool):
            result += str(luaTable[key]).lower()
        elif isinstance(luaTable[key], str):
            result += '"' + _createEscapedString(luaTable[key]) + '"'
        result += ',\n'
    result += '\t' * indentationLevel + '}'
    return result


def _createEscapedString(givenString: str) -> str:
    return givenString.replace('\\', '\\\\').replace('\n', '\\n').replace('"', '\\"')
