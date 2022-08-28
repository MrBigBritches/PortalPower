local ReagentEnum = PortalPower.Enum.Options.REAGENT

---Chooses and executes the correct reagent strategy based on the supplied
---option and strategy
---@param option OptionReagentEnum
---@param destination Destination
---@param button CheckButton
---@return integer?
local function ReagentFactory(option, destination, button)
  if option == ReagentEnum.DISABLED then return end

  local runeCount = {
    portal = GetItemCount("Rune of Portals") or 0,
    teleport = GetItemCount("Rune of Teleportation") or 0,
  }

  local switch = {
    [ReagentEnum.DEFAULT] = function()
      local leftClick = button:GetAttribute("spell1")
      local rightClick = button:GetAttribute("spell2")

      local portal = destination.portal.id
      local teleport = destination.teleport.id

      local show = (portal == leftClick and 'portal')
          or (teleport == leftClick and 'teleport')
          or (portal == rightClick and 'portal')
          or (teleport == rightClick and 'teleport')
          or 'none'

      return (show == 'portal' and runeCount.portal)
          or (show == 'teleport' and runeCount.teleport)
          or 0
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
