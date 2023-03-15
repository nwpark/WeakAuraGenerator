import os.path

from lib.weakauras.aura import Aura

_AURA_IMPORTER_FILE_NAME = 'AuraImporter.lua'


def appendImporterToToc(directory: str, tocFileName: str, luaFileName: str):
    tocFilePath = os.path.join(directory, tocFileName)
    with open(tocFilePath, mode='r', encoding='utf8') as tocFile:
        if luaFileName in tocFile.read():
            return
    with open(tocFilePath, mode='a', encoding='utf8') as tocFile:
        tocFile.write(luaFileName)


def generateImporter(aura: Aura, directory: str, luaFileName):
    importerLuaCode = _generateImporterLuaCode(aura)
    importerFilePath = os.path.join(directory, luaFileName)
    # importerFilePath = f'{directory}/{_AURA_IMPORTER_FILE_NAME}'
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
        templateCode = templateCode.replace("AURA_HASH", str(hash(aura.serialize())))
        return templateCode
