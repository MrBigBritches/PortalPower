function PortalPower.Helpers.Reduce(tbl, initial, fn)
  local result = initial

  PortalPower.Helpers.Iterate(tbl, function(value)
    result = fn(result, value)
  end)

  return result
end