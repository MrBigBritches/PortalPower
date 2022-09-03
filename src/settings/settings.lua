---Light wrapper around the AceDB provider for persisting user options. Settings
---is a singleton that can be accessed from anywhere in the addon.
---@class Settings
---@field _db AceDBObject-3.0
---@field _callbacks {[string]: function[]}
---@field defaults {profile: {[string]: any}}
local Settings = {}
Settings.__index = Settings

-- Only allow one instantiation of settings
---@type Settings?
local singleton = nil

---@return Settings
function Settings:new()
  if singleton ~= nil then return singleton end

  singleton = {}
  setmetatable(singleton, Settings)

  singleton._callbacks = {}
  singleton._db = {}

  return singleton
end

---Initialize and load the settings database
function Settings:Initialize()
  self._db = LibStub("AceDB-3.0"):New("PortalPowerDB", self.defaults, true)
end

---Returns the value for the provided key
---@param key string
---@return any
function Settings:Get(key)
  return PortalPower.Helpers.DeepGet(self._db.profile, key)
end

---Sets the value for the provided key
---@param key string
---@param val any
function Settings:Set(key, val)
  PortalPower.Helpers.DeepSet(self._db.profile, key, val)

  PortalPower.Helpers.Values(self._callbacks['*'] or {}, function(fn) fn() end)

  PortalPower.Helpers.Keys(self._callbacks, function(k)
    local pattern = "^" .. k:gsub('%.', '%%.'):gsub('%*', '.*')
    if not key:find(pattern) then return end

    PortalPower.Helpers.Values(self._callbacks[k] or {}, function(fn) fn(val) end)
  end)
end

---Resets AceDB to the defined defaults
function Settings:Reset()
  ---@diagnostic disable-next-line: missing-parameter
  self._db:ResetProfile()

  PortalPower.Helpers.Iterate(self._callbacks, function(path, callbacks)
    if path == '*' then
      PortalPower.Helpers.Values(callbacks, function(fn) fn() end)
    else
      local value = self:Get(path)
      PortalPower.Helpers.Values(callbacks, function(fn) fn(value) end)
    end
  end)
end

---@alias OnChangePath string|<string>[]|callback fun(value: any)

---Register a callback when a setting is changed. if no path is provided,
---all settings changes will trigger the callback
---@param path OnChangePath [Optional] Scopes callback to specific settings changes
---@param callback? fun(value: any) Callback to trigger
function Settings:OnChange(path, callback)
  local cb = callback or path
  local target = callback and path or '*'

  local paths = type(target) == "table" and target or { [1] = target }

  PortalPower.Helpers.Values(paths, function(p)
    self._callbacks[p] = self._callbacks[p] or {}
    table.insert(self._callbacks[p], cb)
  end)
end

PortalPower.Settings = Settings:new()
