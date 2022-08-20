local TooltipEnum = PortalPower.Enum.Options.TOOLTIP

local function BuildTooltip(fn)
  return function()
    GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
    fn()
    GameTooltip:Show()
  end
end

local function TooltipFactory(option, button, spell)
  TooltipEnum:AssertValid(option)
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
      GameTooltip:AddLine(PortalPower.Constants.DESTINATIONS[spell.destination].NAME)
    end),
  }

  return switch[option]()
end

PortalPower.Buttons.Button.Factories.Tooltip = TooltipFactory