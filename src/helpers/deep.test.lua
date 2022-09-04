describe('Helpers#DeepSet', function()
  describe('empty object', function()
    it('sets a top level property', function()
      local result = PortalPower.Helpers.DeepSet({}, 'lvl1', 'success')
      assert.equals('success', result.lvl1)
    end)

    it('sets a nested property', function()
      local result = PortalPower.Helpers.DeepSet({}, 'lvl1.lvl2.lvl3', 'success')
      assert.equals('success', result.lvl1.lvl2.lvl3)
    end)
  end)

  describe('existing object', function()
    it('sets a top level property', function()
      local testTbl = { lvl1 = 'fail' }
      local result = PortalPower.Helpers.DeepSet(testTbl, 'lvl1', 'success')
      assert.equals('success', result.lvl1)
    end)

    it('sets a nested level property', function()
      local testTbl = { lvl1 = { lvl2 = { lvl3 = 'fail' } } }
      local result = PortalPower.Helpers.DeepSet(testTbl, 'lvl1.lvl2.lvl3', 'success')
      assert.equals('success', result.lvl1.lvl2.lvl3)
    end)

    it('overrides a nested level property', function()
      local testTbl = { lvl1 = { lvl2 = 'fail' } }
      local result = PortalPower.Helpers.DeepSet(testTbl, 'lvl1.lvl2.lvl3', 'success')
      assert.equals('success', result.lvl1.lvl2.lvl3)
    end)

    it('does not change out of scope properties', function()
      local testTbl = { lvl1 = { lvl2 = { lvl3 = 'fail', test = 'pass' } } }
      local result = PortalPower.Helpers.DeepSet(testTbl, 'lvl1.lvl2.lvl3', 'success')

      assert.equals('pass', result.lvl1.lvl2.test)
      assert.equals('success', result.lvl1.lvl2.lvl3)
    end)
  end)
end)

describe('Helpers#DeepGet', function()
  it('gets a top level property', function()
    local testTbl = { lvl1 = 'success' }
    local result = PortalPower.Helpers.DeepGet(testTbl, 'lvl1')

    assert.equals('success', result)
  end)

  it('gets a nested property', function()
    local testTbl = { lvl1 = { lvl2 = { lvl3 = 'success' } } }
    local result = PortalPower.Helpers.DeepGet(testTbl, 'lvl1.lvl2.lvl3')

    assert.equals('success', result)
  end)
end)
