import os

from lib.weakauras.weakauras import WeakAuras


_savedVariablesPath = 'C:/Program Files (x86)/World of Warcraft/_retail_/WTF/Account/NWPARK/SavedVariables/WeakAuras.lua'
_addonCodePath = 'C:/Program Files (x86)/World of Warcraft/_retail_/Interface/AddOns/WeakAuras'

def run():
    weakAuras = WeakAuras(_addonCodePath, _savedVariablesPath)

    aura = weakAuras.getAura('Debug log')
    print(aura.getDebugString())
    # aura.getTriggers()[0].importTriggerFunctionFromFile(os.path.dirname(__file__))
    # weakAuras.generateImporterForAura(aura)


if __name__ == '__main__':
    run()
