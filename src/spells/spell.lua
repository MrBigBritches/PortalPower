local Spell = {}
Spell.__index = Spell

function Spell:new(destination)
  PortalPower.Enum.Destination:AssertValid(destination)

  local spell = {}
  setmetatable(spell, Spell)

  spell.destination = destination
  spell:Load()

  return spell
end

function Spell:Load()
  self.portal = self:GetInfo(PortalPower.Enum.SpellType.PORTAL)
  self.teleport = self:GetInfo(PortalPower.Enum.SpellType.TELEPORT)
end

function Spell:GetInfo(spellType)
  PortalPower.Enum.SpellType:AssertValid(spellType)

  local name, _, icon, _, _, _, id = GetSpellInfo(self:FullName(spellType))
  return {name = name, icon = icon, id = id}
end

function Spell:FullName(spellType)
  PortalPower.Enum.SpellType:AssertValid(spellType)
  return spellType .. ": " ..self.destination
end

function Spell:IsKnown(spellType)
  PortalPower.Enum.SpellType:AssertValid(spellType)

  local _, spellId = GetSpellBookItemInfo(self:FullName(spellType))
  return not not spellId
end

function Spell:Available()
  return not not (self.portal.id or self.teleport.id)
end

function Spell:GetCooldown()
  local startP, durationP = GetSpellCooldown(self:FullName(PortalPower.Enum.SpellType.PORTAL))
  local startT, durationT = GetSpellCooldown(self:FullName(PortalPower.Enum.SpellType.TELEPORT))

  return startP or startT, durationP or durationT
end

PortalPower.Spells.Spell = Spell