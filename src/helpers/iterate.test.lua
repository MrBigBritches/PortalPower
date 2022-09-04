describe('Helpers#Iterate', function()
  it('invokes the provided callback', function()
    local test = { 'success' }
    local s = spy.new(function() end)

    PortalPower.Helpers.Iterate(test, s)

    assert.spy(s).was.called()
  end)

  it('invokes the provided callback per entry', function()
    local test = { 1, 2, 3 }
    local s = spy.new(function() end)

    PortalPower.Helpers.Iterate(test, s)

    assert.spy(s).was.called(3)
  end)

  describe('array', function()
    it('invokes the provided callback with the expected arguments', function()
      local test = { 1, '2', 3 }
      local s = spy.new(function() end)

      PortalPower.Helpers.Iterate(test, s)

      assert.spy(s).was.called_with(1, 1, 1)
      assert.spy(s).was.called_with(2, '2', 2)
      assert.spy(s).was.called_with(3, 3, 3)
    end)
  end)

  describe('object', function()
    it('invokes the provided callback with the expected arguments', function()
      local test = { x = 1, y = 2, z = '3' }
      local s = spy.new(function() end)

      PortalPower.Helpers.Iterate(test, s)

      assert.spy(s).was.called_with('x', 1, match.is_number())
      assert.spy(s).was.called_with('y', 2, match.is_number())
      assert.spy(s).was.called_with('z', '3', match.is_number())
    end)
  end)
end)
