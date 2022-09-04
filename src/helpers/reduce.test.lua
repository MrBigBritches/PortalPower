describe('Helpers#Reduce', function()
  it('reduces a table to a single value', function()
    local result = PortalPower.Helpers.Reduce({ 1, 2, 3, 4, 5 }, 0, function(agg, value)
      return agg + value
    end)

    assert.equals(15, result)
  end)
end)
