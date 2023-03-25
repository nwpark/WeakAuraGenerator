from pandas import DataFrame

from lib.weakauras.aura import Aura
from lib.weakauras.weakauras import WeakAuras
from scripts.aura_generators.echo.auras.get_aura import AuraType, getOrCreateAura
from scripts.aura_generators.echo.data.csv_parsers import groupCsvRecordsByColumn


class IconAuraDefinition:
    def __init__(self, auraDefinition: dict, parentGroupName):
        self.parentGroupName = parentGroupName
        self.boss = auraDefinition['Boss']
        self.name = auraDefinition['Name']
        self.spellId = auraDefinition['SpellId']
        self.text1 = auraDefinition['Text1']
        self.text2 = auraDefinition['Text2']
        self.sound = auraDefinition['Sound']


def _createAuraDefinitionsGroupedByBoss(dataFrame: DataFrame, parentGroupName: str) -> dict[str, list[IconAuraDefinition]]:
    bossesToAuraDefinitions = groupCsvRecordsByColumn(dataFrame, 'Boss')
    return {
        bossName: [IconAuraDefinition(auraDefinition, parentGroupName) for auraDefinition in auraDefinitions]
        for bossName, auraDefinitions in bossesToAuraDefinitions.items()
    }


class IconAuraGenerator:
    def __init__(self, _weakAuras: WeakAuras, parentGroupName: str, dataFrame: DataFrame):
        self._weakAuras = _weakAuras
        self._parentGroupName = parentGroupName
        self._auraDefinitions = _createAuraDefinitionsGroupedByBoss(dataFrame, parentGroupName)
        if not self._weakAuras.auraExists(self._parentGroupName):
            raise KeyError('No aura group found with name ' + self._parentGroupName)

    def generateAuras(self) -> dict[str, list[Aura]]:
        return {
            bossName: self._generateAurasForBoss(auraDefinitions)
            for bossName, auraDefinitions in self._auraDefinitions.items()
        }

    def _generateAurasForBoss(self, auraDefinitions: list[IconAuraDefinition]) -> list[Aura]:
        return [self._generateAura(auraDefinition) for auraDefinition in auraDefinitions]

    def _generateAura(self, auraDefinition: IconAuraDefinition) -> Aura:
        auraName = f'{auraDefinition.boss} - {auraDefinition.name}'
        aura = getOrCreateAura(self._weakAuras, auraName, auraDefinition.parentGroupName, AuraType.Icon)
        aura.luaTable['parent'] = self._parentGroupName
        aura.textSubRegions[0]['text_text'] = auraDefinition.text1 or ''
        aura.textSubRegions[0]['text_visible'] = auraDefinition.text1 is not None
        aura.textSubRegions[1]['text_text'] = auraDefinition.text2 or ''
        aura.textSubRegions[1]['text_visible'] = auraDefinition.text2 is not None
        aura.triggers[0].auraNames = [str(auraDefinition.spellId)]
        return aura
