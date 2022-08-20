local Settings = {}
Settings.__index = Settings

-- Only allow one instantiation of settings
local singleton = nil

function Settings:new()
  if singleton ~= nil then return singleton end

  singleton = {}
  setmetatable(singleton, Settings)

  singleton._db = {}
  singleton._callbacks = {}

  return singleton
end

function Settings:Initialize()
  self._db = LibStub("AceDB-3.0"):New("PortalPowerDB", self.defaults, true)
end

function Settings:get(key)
  return self._db.profile[key]
end

function Settings:set(key, val)
  self._db.profile[key] = val

  PortalPower.Helpers.Iterate(self._callbacks['*'] or {}, function(fn) fn() end)
  PortalPower.Helpers.Iterate(self._callbacks[key] or {}, function(fn) fn(val) end)
end

function Settings:Reset()
  print ('entered reset')
  self._db:ResetProfile()

  print ('starting emit')
  PortalPower.Helpers.Iterate(self._callbacks, function(path, callbacks)
    print ('path: ' .. path)
    if path == '*' then
      PortalPower.Helpers.Iterate(callbacks, function(fn) fn() end)
    else
      local value = self:get(path)
      PortalPower.Helpers.Iterate(callbacks, function(fn) fn(value) end)
    end
  end)
end

function Settings:OnChange(path, callback)
  local cb = callback or path
  path = callback and path or '*'

  local paths = type(path) == "table" and path or { [1] = path}

  PortalPower.Helpers.Iterate(paths, function(p)
    self._callbacks[p] = self._callbacks[p] or {}
    table.insert(self._callbacks[p], cb)
  end)
end

PortalPower.Settings = Settings:new()