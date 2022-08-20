local Spells = {}
local cache = {}

-- Returns the cached version of the spell or loads it from the API
function Spells:Get(destination)
  PortalPower.Enum.Destination:AssertValid(destination)
  return cache[destination] or Spells:Load(destination)
end

-- Loads a spell from the API and updates the cache. Prefer using :Get instead.
function Spells:Load(destination)
  PortalPower.Enum.Destination:AssertValid(destination)

  cache[destination] = Spells.Spell:new(destination)
  return cache[destination]
end

PortalPower.Spells = Spells