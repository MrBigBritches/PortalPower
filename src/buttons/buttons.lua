local iterate = PortalPower.Helpers.Iterate

local Buttons = {}
local cache = {}

local protected = {}
local container = nil

function Buttons:Initialize()
  protected.createContainer()
  protected.createButtons()
end

function Buttons:Render()
  iterate(cache, function(button) button:Render() end)
end

function Buttons:ClearCooldown()
  iterate(cache, function(button) button:ClearCooldown() end)
end

function Buttons:UpdateDisplay()
  local direction = PortalPower.Settings:get('direction')
  local isHorizontal = direction == PortalPower.Enum.Options.DISPLAY.HORIZONTAL

  local size = PortalPower.Helpers.Scale(PortalPower.Constants.BUTTON.SIZE)
  local spacing = PortalPower.Helpers.Scale(PortalPower.Settings:get('spacing'))

 -- Update Buttons
  iterate(cache, function(button, idx)
    local translation = (size * idx) + (spacing * idx)

    if isHorizontal then
      button.frame:SetPoint("TOPLEFT", translation, 0)
    else
      button.frame:SetPoint("TOPLEFT", 0, -translation)
    end
  end)

   -- Update Container
   local buttonCount = PortalPower.Helpers.Count(cache)

   local containerWidth = isHorizontal and (buttonCount * size + (buttonCount - 1) * spacing) or size
   local containerHeight = isHorizontal and size or (buttonCount * size + (buttonCount - 1) * spacing)

   container:SetSize(containerWidth, containerHeight)
end

function protected.createContainer()
  local xOffset = PortalPower.Settings:get('xOffset') or 0
  local yOffset = PortalPower.Settings:get('yOffset') or 0

  container = CreateFrame("Frame", nil, UIParent)

  container:EnableMouse(true)
  container:SetMovable(true)
  container:SetFrameStrata("LOW")
  container:SetClampedToScreen(true)
  container:RegisterForDrag("LeftButton")
  container:SetPoint("TOPLEFT", xOffset, yOffset)

  container:SetScript("OnDragStart", protected.handleOnDragStart)
  container:SetScript("OnDragStop", protected.handleOnDragStop)

  container:Show()
end

function protected.createButtons()
  iterate(PortalPower.Enum.Destination, function(destination)
    local spell = PortalPower.Spells:Get(destination)

    if spell:Available() then
      local button = Buttons.Button:new(destination, container)

      button.frame:SetScript("OnDragStart", protected.handleOnDragStart)
      button.frame:SetScript("OnDragStop", protected.handleOnDragStop)

      cache[destination] = button
    end
  end)
end

function protected.handleOnDragStart()
  if not IsShiftKeyDown() then return end
  container:StartMoving()
end

function protected.handleOnDragStop(self)
  container:StopMovingOrSizing()

  local xOffset = self:GetLeft()
  local yOffset = self:GetTop() - GetScreenHeight()

  PortalPower.Settings:set('xOffset', math.ceil(xOffset - .5))
  PortalPower.Settings:set('yOffset', math.ceil(yOffset - .5))
end

PortalPower.Buttons = Buttons