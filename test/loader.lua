local function loadHelpers()
  for line in io.lines('./PortalPower.toc') do
    if line:match('src/helpers/') then
      require(line:gsub('.lua', ''))
    end
  end
end

if not _G.unpack then _G.unpack = table.unpack end

_G['PortalPower'] = { Addon = {} }


loadHelpers()
