describe('Helpers#Split', function()
  it('splits the provided string', function()
    local str = 'a,b,c'
    local result = PortalPower.Helpers.Split(str)

    assert.are.same({ 'a', 'b', 'c' }, result)
  end)

  it('splits the provided string by the supplied separator', function()
    local str = 'a,1.b.c'
    local result = PortalPower.Helpers.Split(str, '.')

    assert.are.same({ 'a,1', 'b', 'c' }, result)
  end)
end)
