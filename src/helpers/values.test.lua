describe('Helpers#Values', function()
  it('invokes the provided callback for each table value', function()
    local test = { a = 'one', b = 'two', c = 'three' }
    local s = spy.new(function() end)

    PortalPower.Helpers.Values(test, s)

    assert.spy(s).was.called(3)

    assert.spy(s).was.called_with('one', match.is_number())
    assert.spy(s).was.called_with('two', match.is_number())
    assert.spy(s).was.called_with('three', match.is_number())
  end)

  it('invokes the provided callback for each array value', function()
    local test = { 'a', 'b', 'c' }
    local s = spy.new(function() end)

    PortalPower.Helpers.Values(test, s)

    assert.spy(s).was.called(3)

    assert.spy(s).was.called_with('a', match.is_number())
    assert.spy(s).was.called_with('b', match.is_number())
    assert.spy(s).was.called_with('c', match.is_number())
  end)
end)
