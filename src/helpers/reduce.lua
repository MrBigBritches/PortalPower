---Reduces the values of a table into a single result, using the supplied
---function
---@generic K, V, T
---@param tbl table<K, V> Table to iterate through
---@param initial T Initial value
---@param fn fun(aggregator: T, value: V): T Callback
---@return T
function PortalPower.Helpers.Reduce(tbl, initial, fn)
  local result = initial

  PortalPower.Helpers.Values(tbl, function(value)
    result = fn(result, value)
  end)

  return result
end
