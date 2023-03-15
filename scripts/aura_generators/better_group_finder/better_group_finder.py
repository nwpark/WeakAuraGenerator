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
    aura = weakAuras.getAura('Better Premade Group Finder 2')

    # Init action
    initActionCustomFunction = concatenateFileContents([
        'common/constants.lua',
        'common/debug_utils.lua',
        'common/lua_utils.lua',
        'common/rio_utils.lua',
        'common/wow_api_utils.lua',
        'common/search_result_utils.lua',
        'common/skins.lua',
        'common/ace_gui_utils.lua',
        'init_action/options/model/model.lua',
        'init_action/options/controller/controller.lua',
        'init_action/options/view/options_frame.lua',
        'init_action/options/view/standard_options.lua',
        'init_action/options/view/tabs/tab_group.lua',
        'init_action/options/view/tabs/dungeon_tab.lua',
        'init_action/options/view/tabs/member_tab.lua',
        'init_action/application_states.lua',
        'init_action/search_entries/on_search_entry_update.lua',
        'init_action/search_entries/role_icons/role_icon_frame.lua',
        'init_action/search_entries/role_icons/update_role_icons.lua',
        'init_action/search_results/on_sort_search_results.lua',
        'init_action/search_results/filter_search_results.lua',
        'init_action/search_results/sort_search_results.lua',
        'init_action/main.lua',
        'test/test.lua',
    ])
    aura.getActions().initAction.customFunctionAsString = initActionCustomFunction
    aura.getActions().initAction.exportCustomFunctionToFile('../exports', 'init_action.lua')

    # Trigger
    aura.getTriggers()[0].importTriggerFunctionFromFile('', 'trigger/trigger.lua')
    aura.getTriggers()[0].importTriggerEventsFromFile('', 'trigger/trigger_events.lua')

    aura.printDebugString()

    # Importer
    weakAuras.generateImporterForAura(aura, 'C:/Users/nickw/Documents/LuaProjects/AuraImporter', 'AuraImporter.lua', 'AuraImporter.toc')


if __name__ == '__main__':
    run()
