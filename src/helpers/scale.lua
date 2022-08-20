---Scales a supplied value by a user specified factor
---@param value number value to scale
---@return number number scaled value
function PortalPower.Helpers.Scale(value)
  return value * PortalPower.Settings:Get('scale')
end
