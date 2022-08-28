local Destinations = {}

---@type {[LocationEnum]: Destination}
local cache = {}

---Returns the cached version of the spell or loads it from the API
---@param location LocationEnum
---@return Destination
function Destinations.Get(location)
  return cache[location] or Destinations.Load(location)
end

---Loads a spell from the API and updates the cache. Prefer using :Get instead.
---@param location LocationEnum
---@return Destination
function Destinations.Load(location)
  cache[location] = Destinations.Destination:new(location)
  return cache[location]
end

---Reloads all spells from the API and updates the cache.
function Destinations.Refresh()
  PortalPower.Helpers.Values(cache, function(destination)
    destination:Load()
  end)
end

PortalPower.Destinations = Destinations
