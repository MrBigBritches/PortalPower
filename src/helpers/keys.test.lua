describe('Helpers#Keys', function()
  it('invokes the provided callback for each table key', function()
    local test = { a = 1, b = 2, c = 3 }
    local s = spy.new(function() end)

    PortalPower.Helpers.Keys(test, s)

    assert.spy(s).was.called(3)

    assert.spy(s).was.called_with('a', match.is_number())
    assert.spy(s).was.called_with('b', match.is_number())
    assert.spy(s).was.called_with('c', match.is_number())
  end)

  it('invokes the provided callback for each array index', function()
    local test = { 'a', 'b', 'c' }
    local s = spy.new(function() end)

    PortalPower.Helpers.Keys(test, s)

    assert.spy(s).was.called(3)

    assert.spy(s).was.called_with(1, match.is_number())
    assert.spy(s).was.called_with(2, match.is_number())
    assert.spy(s).was.called_with(3, match.is_number())
  end)
end)
