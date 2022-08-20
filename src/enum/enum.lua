local Enum = {}
Enum.__index = Enum

local function shallowCopy(values, destination)
  for k, v in pairs(values) do
    destination[k] = v
  end

  return destination
end

function Enum:new(values)  
  local enum = {}
  setmetatable(enum, Enum)

  shallowCopy(values, enum)
  enum._values = shallowCopy(values, {})

  return enum
end

function Enum:AssertValid(value)
  for _, entry in pairs(self._values) do
    if entry == value then return true end
  end

  -- Built error message with valid values
  local values = PortalPower.Helpers.Reduce(self._values, "", function(m, enum)
    return m .. enum .. ", "
  end)

  local message = "\"" .. value .. "\" is not a valid enum (" .. values:gsub(', $', '') .. ")"

  print(message)
  assert(false, message)
end

PortalPower.Enum = Enum

-- PortalPower.Enum.SpellType:AssertValid('test')