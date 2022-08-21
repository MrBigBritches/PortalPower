local ReagentEnum = PortalPower.Enum.Options.REAGENT

---Chooses and executes the correct reagent strategy based on the supplied
---option and strategy
---@param option OptionReagentEnum
---@param destination Destination
local function ReagentFactory(option, destination)
  if option == ReagentEnum.DISABLED then return end

  local runeCount = {
    portal = GetItemCount("Rune of Portals") or 0,
    teleport = GetItemCount("Rune of Teleportation") or 0,
  }

  local switch = {
    [ReagentEnum.DEFAULT] = function()
      return destination.portal.id and runeCount.portal or runeCount.teleport or 0
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
