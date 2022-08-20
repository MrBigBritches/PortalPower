---Executes the given callback for each key in a given table
---@generic K, V
---@param tbl table<K, V> Table to iterate through
---@param fn fun(key: K, index: number) Callback
function PortalPower.Helpers.Keys(tbl, fn)
  PortalPower.Helpers.Iterate(tbl, function(key, _, i)
    fn(key, i)
  end)
end
