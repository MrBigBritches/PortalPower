local ReagentEnum = PortalPower.Enum.Factories.REAGENT

local function ReagentFactory(option, spell)
  ReagentEnum:AssertValid(option)
  if option == ReagentEnum.DISABLED then return end

  local runeCount = {
    portal = GetItemCount("Rune of Portals") or 0,
    teleport = GetItemCount("Rune of Teleportation") or 0,
  }

  local switch = {
    [ReagentEnum.DEFAULT] = function()
      return spell.portal.id and runeCount.portal or runeCount.teleport or 0
    end,

    [ReagentEnum.PORTAL] = function()
      return runeCount.portal or 0
    end,

    [ReagentEnum.TELEPORT] = function()
      return runeCount.teleport or 0
    end,
  }

  return switch[option]()
end

PortalPower.Buttons.Button.Factories.Reagent = ReagentFactory