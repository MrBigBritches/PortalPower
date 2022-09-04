local function loadHelpers()
  for line in io.lines('./PortalPower.toc') do
    if line:match('src/helpers/') then
      require(line:gsub('.lua', ''))
    end
  end
end

_G['PortalPower'] = {}
loadHelpers()
