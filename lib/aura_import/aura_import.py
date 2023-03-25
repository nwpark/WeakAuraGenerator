from os import path

from lib.weakauras.aura import Aura


def _appendImporterToToc(importerAddonDirectory: str, importerFileName: str):
    tocFilePath = path.join(importerAddonDirectory, 'AuraImporter.toc')
    with open(tocFilePath, mode='r', encoding='utf8') as tocFile:
        for line in tocFile:
            if importerFileName in line:
                return
    with open(tocFilePath, mode='a', encoding='utf8') as tocFile:
        tocFile.write(importerFileName + '\n')


def _generateImporterLuaCode(aura: Aura) -> str:
    currentDir = path.dirname(__file__)
    luaTemplateFilePath = path.join(currentDir, 'aura_importer_template.lua')
    with open(luaTemplateFilePath, mode='r', encoding='utf8') as luaTemplateFile:
        templateCode = luaTemplateFile.read()
        templateCode = templateCode.replace("AURA_NAME", aura.getName())
        templateCode = templateCode.replace("AURA_SERIALIZED", aura.serialize())
        templateCode = templateCode.replace("AURA_HASH", str(hash(aura.serialize())))
        return templateCode


def generateImporter(aura: Aura, importerAddonDirectory: str):
    importerFileName = f'{aura.name}.lua'
    _appendImporterToToc(importerAddonDirectory, importerFileName)
    importerLuaCode = _generateImporterLuaCode(aura)
    importerFilePath = path.join(importerAddonDirectory, importerFileName)
    with open(importerFilePath, mode='w', encoding='utf8') as luaFile:
        luaFile.write(importerLuaCode)
