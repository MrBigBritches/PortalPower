function PortalPower.Helpers.Iterate(tbl, fn)
  -- Special workaround for ENUMs
  local values = getmetatable(tbl) == PortalPower.Enum and tbl._values or tbl

  local i = 0
  for _, value in pairs(values) do
    fn(value, i)
    i = i + 1
  end
end