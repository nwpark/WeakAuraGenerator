from lib.weakauras.weakauras import WeakAuras

_savedAurasPath = 'C:/Program Files (x86)/World of Warcraft/_retail_/WTF/Account/YOUR_ACCOUNT_NAME/SavedVariables/WeakAuras.lua'


def run():
    weakAuras = WeakAuras(_savedAurasPath)

    shadowfuryTracker = weakAuras.cloneExistingAura('Mortal Coil Tracker', 'Shadowfury Tracker')
    shadowfuryTracker.getTriggers()[0].setSpellName('30283')

    # Print the debug string to see what fields the aura has. If the field you need to modify is not supported then
    # feel free to add an implementation and submit a pull request!
    print(shadowfuryTracker.getDebugString())

    weakAuras.saveChanges()


if __name__ == '__main__':
    run()
