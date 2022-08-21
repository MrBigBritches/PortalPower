local TooltipEnum = PortalPower.Enum.Options.TOOLTIP

---Wraps a tooltip strategy with common functionality
---@param fn function
---@return function
local function BuildTooltip(fn)
  return function()
    GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
    fn()
    GameTooltip:Show()
  end
end

---comment
---@param option OptionTooltipEnum
---@param button any
---@param destination Destination
---@return nil
local function TooltipFactory(option, button, destination)
  if option == TooltipEnum.DISABLED then return end

  local switch = {
    [TooltipEnum.DEFAULT] = BuildTooltip(function()
      local leftClick = button:GetAttribute("spell1")
      local rightClick = button:GetAttribute("spell2")

      if leftClick then
        GameTooltip:AddLine("Left Click:")
        GameTooltip:AddSpellByID(leftClick)
      end

      if leftClick and rightClick then
        GameTooltip:AddLine("\n")
      end

      if rightClick then
        GameTooltip:AddLine("Right Click:")
        GameTooltip:AddSpellByID(rightClick)
      end
    end),

    [TooltipEnum.SIMPLE] = BuildTooltip(function()
      GameTooltip:AddLine(PortalPower.Constants.DESTINATIONS[destination.location].NAME)
    end),
  }

  switch[option]()
end

PortalPower.Buttons.Button.Factories.Tooltip = TooltipFactory
