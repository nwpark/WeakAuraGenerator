import os.path

from lib.weakauras.aura import Aura

_AURA_IMPORTER_FILE_NAME = 'AuraImporter.lua'


def appendImporterToToc(tocFilePath: str):
    with open(tocFilePath, mode='r', encoding='utf8') as tocFile:
        if _AURA_IMPORTER_FILE_NAME in tocFile.read():
            return
    with open(tocFilePath, mode='a', encoding='utf8') as tocFile:
        tocFile.write(_AURA_IMPORTER_FILE_NAME)


def generateImporter(addonCodePath: str, aura: Aura):
    importerLuaCode = _generateImporterLuaCode(aura)
    importerFilePath = f'{addonCodePath}/{_AURA_IMPORTER_FILE_NAME}'
    with open(importerFilePath, mode='w', encoding='utf8') as luaFile:
        luaFile.write(importerLuaCode)


#  TODO: modify template to skip import if aura version(?) has not changed
def _generateImporterLuaCode(aura: Aura) -> str:
    currentDir = os.path.dirname(__file__)
    luaTemplateFilePath = os.path.join(currentDir, 'aura_importer_template.lua')
    with open(luaTemplateFilePath, mode='r', encoding='utf8') as luaTemplateFile:
        templateCode = luaTemplateFile.read()
        templateCode = templateCode.replace("AURA_NAME", aura.getName())
        templateCode = templateCode.replace("AURA_SERIALIZED", aura.serialize())
        return templateCode
