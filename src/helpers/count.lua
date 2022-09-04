---comment
---@generic K, V
---@param tbl table<K, V> Table to count
---@param fn? fun(value: V):boolean
---@return integer
function PortalPower.Helpers.Count(tbl, fn)
  return PortalPower.Helpers.Reduce(tbl, 0, function(agg, value)
    if fn == nil then return agg + 1 end
    return agg + (fn(value) and 1 or 0)
  end)
end
