---Encapsulates the information for a given mage teleport/portal location
---@class Destination
---@field location LocationEnum
local Destination = {}
Destination.__index = Destination

---@alias DestinationInformation {name: string, icon: string, id: string}

---Constructor
---@param location LocationEnum
---@return Destination
function Destination:new(location)
  local this = {}
  setmetatable(this, Destination)

  this.location = location
  this:Load()

  return this
end

function Destination:Load()
  self.portal = self:GetInfo(PortalPower.Enum.TravelMethod.PORTAL)
  self.teleport = self:GetInfo(PortalPower.Enum.TravelMethod.TELEPORT)
end

---Attempts to retrieve the full name, icon, and spell id for a location +
---travel method
---@param travelMethod TravelMethodEnum
---@return DestinationInformation?
function Destination:GetInfo(travelMethod)
  local name, _, icon, _, _, _, id = GetSpellInfo(self:SpellName(travelMethod))
  return { name = name, icon = icon, id = id }
end

---Returns the corresponding spell name for API lookup
---@param travelMethod TravelMethodEnum
---@return string
function Destination:SpellName(travelMethod)
  return travelMethod .. ": " .. self.location
end

---Checks if the spell for the given travel method is known
---@param travelMethod TravelMethodEnum
---@return boolean
function Destination:IsKnown(travelMethod)
  local _, spellId = GetSpellBookItemInfo(self:SpellName(travelMethod))
  return not not spellId
end

---Checks if either travel method is availabe for the destination
---@return boolean
function Destination:Available()
  return not not (self.portal.id or self.teleport.id)
end

---Retrieves the cooldown for the portal or teleport spell
---@return number number Cooldown start time
---@return number number Cooldown duration
function Destination:GetCooldown()
  local startP, durationP = GetSpellCooldown(self:SpellName(PortalPower.Enum.TravelMethod.PORTAL))
  local startT, durationT = GetSpellCooldown(self:SpellName(PortalPower.Enum.TravelMethod.TELEPORT))

  return startP or startT, durationP or durationT
end

PortalPower.Destinations.Destination = Destination
