---comment
---@param tbl any
---@param fn any
---@return integer
function PortalPower.Helpers.Count(tbl, fn)
  return PortalPower.Helpers.Reduce(tbl, 0, function(agg)
    if fn == nil then return agg + 1 end
    return agg + (fn() and 1 or 0)
  end)
end
