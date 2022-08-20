local Destinations = {}

---@type {[LocationEnum]: Destination}
local cache = {}

---Returns the cached version of the spell or loads it from the API
---@param location LocationEnum
---@return Destination
function Destinations.Get(location)
  PortalPower.Enum.Location:AssertValid(location)
  return cache[location] or Destinations.Load(location)
end

---Loads a spell from the API and updates the cache. Prefer using :Get instead.
---@param location LocationEnum
---@return Destination
function Destinations.Load(location)
  PortalPower.Enum.Location:AssertValid(location)

  cache[location] = Destinations.Destination:new(location)
  return cache[location]
end

PortalPower.Destinations = Destinations
