from lib.aura_import.aura_import import generateImporter
from lib.weakauras.weakauras import WeakAuras
from scripts.aura_generators.echo.aura_generators.icon_aura import IconAuraGenerator
from scripts.aura_generators.echo.data.google_sheets import fetchCsvDataFromGoogleSheet

_savedVariablesPath = 'C:/Program Files (x86)/World of Warcraft/_ptr_/WTF/Account/101371542#1/SavedVariables/WeakAuras.lua'
_addonCodePath = 'C:/Program Files (x86)/World of Warcraft/_ptr_/Interface/AddOns/WeakAuras'
_googleSheetId = '1uWe9o4qkxo34e8543ky8bgfrMGtnvWz6IxwsbA64pV0'


def run():
    weakAuras = WeakAuras(_addonCodePath, _savedVariablesPath)

    iconAuraCsvData = fetchCsvDataFromGoogleSheet(_googleSheetId, '')
    iconAuraGenerator = IconAuraGenerator(weakAuras, "Aberrus - Dynamic Icons - Meeres", iconAuraCsvData)
    iconAuras = iconAuraGenerator.generateAuras()
    for iconAura in iconAuras['(01) Kazzara']:
        generateImporter(iconAura, 'C:/Users/nickw/Documents/LuaProjects/AuraImporter')


if __name__ == '__main__':
    run()
