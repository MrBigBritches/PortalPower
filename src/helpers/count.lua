function PortalPower.Helpers.Count(tbl)
    return PortalPower.Helpers.Reduce(tbl, 0, function(agg)
        return agg + 1
    end)
  end