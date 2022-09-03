local IconEnum = PortalPower.Enum.Options.ICON

---Chooses and executes the correct icon strategy based on the supplied
---option and strategy
---@param option OptionIconEnum
---@param destination Destination
---@param button CheckButton
---@return string|number?
local function IconFactory(option, destination, button)
  local primarySpell = button:GetAttribute("spell1")
  local secondarySpell = button:GetAttribute("spell2")

  if not primarySpell and not secondarySpell then return nil end

  local _, _, primaryIcon = GetSpellInfo(primarySpell)
  local _, _, secondaryIcon = GetSpellInfo(secondarySpell)

  local switch = {
    [IconEnum.DEFAULT] = function()
      return primaryIcon
    end,

    [IconEnum.PORTAL] = function()
      return destination.portal.icon
    end,

    [IconEnum.TELEPORT] = function()
      return destination.teleport.icon
    end,
  }

  return switch[option]() or primaryIcon or secondaryIcon
end

PortalPower.Buttons.Button.Factories.Icon = IconFactory
