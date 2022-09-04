---Executes the given callback for each key, value pair in a given table
---@generic K, V
---@param tbl table<K, V> Table to iterate through
---@param fn fun(key: K, value: V, index: number) Callback
function PortalPower.Helpers.Iterate(tbl, fn)
  local i = 1
  for key, value in pairs(tbl) do
    fn(key, value, i)
    i = i + 1
  end
end
