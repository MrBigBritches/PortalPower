---Executes the given callback for each value in a given table
---@generic K, V
---@param tbl table<K, V> Table to iterate through
---@param fn fun(value: V, index: number) Callback
function PortalPower.Helpers.Values(tbl, fn)
  PortalPower.Helpers.Iterate(tbl, function(_, value, i)
    fn(value, i)
  end)
end
