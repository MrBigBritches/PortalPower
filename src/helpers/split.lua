---comment
---@param str string String to separate
---@param sep string Separator used to split the supplied string
---@return table<number, string>
function PortalPower.Helpers.Split(str, sep)
  local separator = sep or ","
  local fields = {}

  for match in str:gmatch("([^" .. separator .. "]+)") do table.insert(fields, match) end

  return fields
end
