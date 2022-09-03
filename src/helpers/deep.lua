---Gets a nested value at the provided path from the supplied table
---@param tbl table
---@param path string
---@return any
function PortalPower.Helpers.DeepGet(tbl, path)
  local parts = PortalPower.Helpers.Split(path, '.')

  return PortalPower.Helpers.Reduce(parts, tbl, function(nested, part)
    return nested[part]
  end)
end

---Sets a nested value at the provided path in the supplied table
---@param tbl table
---@param path string
---@param value any
---@return table
function PortalPower.Helpers.DeepSet(tbl, path, value)
  local parts = PortalPower.Helpers.Split(path, '.')

  local nestedParts = { unpack(parts, 1, #parts - 1) }
  local nestedTbl = tbl

  PortalPower.Helpers.Values(nestedParts, function(part)
    if not nestedTbl[part] then nestedTbl[part] = {} end

    nestedTbl = nestedTbl[part]
  end)

  local finalPart = parts[#parts]
  nestedTbl[finalPart] = value

  return tbl
end
