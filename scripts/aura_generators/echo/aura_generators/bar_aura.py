class BarAuraDefinition:
    def __init__(self, auraDefinition: dict):
        self.name = auraDefinition['Name']
        self.spellId = auraDefinition['SpellId']
        self.text1 = auraDefinition['Text1']
        self.color = auraDefinition['Color']
        self.sound = auraDefinition['Sound']
        self.trigger = auraDefinition['Trigger']
        self.tooltip = auraDefinition['Tooltip']
        self.loadCondition = auraDefinition['LoadCondition']

# TODO
