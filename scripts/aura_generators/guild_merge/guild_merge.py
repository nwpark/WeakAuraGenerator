import os

from lib.weakauras.weakauras import WeakAuras


_savedVariablesPath = 'C:/Program Files (x86)/World of Warcraft/_retail_/WTF/Account/NWPARK/SavedVariables/WeakAuras.lua'
_addonCodePath = 'C:/Program Files (x86)/World of Warcraft/_retail_/Interface/AddOns/WeakAuras'


def readFile(filePath):
    with open(filePath, mode='r', encoding='utf8') as file:
        return file.read()


def concatenateFileContents(filePaths):
    return '\n'.join([readFile(filePath) for filePath in filePaths])


def run():
    weakAuras = WeakAuras(_addonCodePath, _savedVariablesPath)
    aura = weakAuras.getAura('GuildMerger')

    # Init action
    # initActionCustomFunction = concatenateFileContents(['common/constants.lua', 'common/utils.lua', 'init_action/gui.lua', 'init_action/main.lua', 'test/test.lua'])
    # aura.getActions().initAction.customFunctionAsString = initActionCustomFunction

    # Trigger
    # aura.getTriggers()[0].importTriggerFunctionFromFile('', 'trigger/trigger.lua')
    # aura.getTriggers()[0].importTriggerEventsFromFile('', 'trigger/trigger_events.lua')

    print(aura.getActions().initAction.customFunctionAsString)
    # aura.printDebugString()

    # Importer
    # weakAuras.generateImporterForAura(aura, 'C:/Users/nickw/Documents/LuaProjects/AuraImporter', 'AuraImporter.lua', 'AuraImporter.toc')


if __name__ == '__main__':
    run()
