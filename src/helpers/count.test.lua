describe('Helpers#Count', function()
  local testTbl = { 1, 2, 3, 4, 5 }

  it('returns the count if no function is provided', function()
    local result = PortalPower.Helpers.Count(testTbl)
    assert.equals(5, result)
  end)

  it('uses the provided function to count items', function()
    local result = PortalPower.Helpers.Count(testTbl, function(item)
      return item % 2 == 0
    end)

    assert.equals(2, result)
  end)
end)
