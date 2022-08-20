local iterate = PortalPower.Helpers.Values

---@type table<string,function>
local Buttons = {}
---@type table<string,function>
local protected = {}

---@type table<LocationEnum, Button>
local cache = {}

local container = nil

---Initializes the button manager
function Buttons:Initialize()
  protected.createContainer()
  protected.createButtons()
end

---Re-render the active buttons
function Buttons:Render()
  iterate(cache, function(button) button:Render() end)
end

---Clears the cooldowns of all buttons
function Buttons:ClearCooldown()
  iterate(cache, function(button) button:ClearCooldown() end)
end

---Updates the layout of visible buttons and the button container
function Buttons:UpdateDisplay()
  local direction = PortalPower.Settings:Get('direction')
  local isHorizontal = direction == PortalPower.Enum.Options.DISPLAY.HORIZONTAL

  local size = PortalPower.Helpers.Scale(PortalPower.Constants.BUTTON.SIZE)
  local spacing = PortalPower.Helpers.Scale(PortalPower.Settings:Get('spacing'))

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
  local buttonCount = #cache

  local containerWidth = isHorizontal and (buttonCount * size + (buttonCount - 1) * spacing) or size
  local containerHeight = isHorizontal and size or (buttonCount * size + (buttonCount - 1) * spacing)

  container:SetSize(containerWidth, containerHeight)
end

---Createsa a frame to wrapp the PortalPower buttons
function protected.createContainer()
  local xOffset = PortalPower.Settings:Get('xOffset') or 0
  local yOffset = PortalPower.Settings:Get('yOffset') or 0

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

---Iterates through all available locations and creates buttons for those that
---are eligible for display.
function protected.createButtons()
  local Button = PortalPower.Buttons.Button
  iterate(PortalPower.Enum.Location, function(location)
    local destination = PortalPower.Destinations.Get(location)

    if destination:Available() then
      local button = Button:new(destination, container)

      button.frame:SetScript("OnDragStart", protected.handleOnDragStart)
      button.frame:SetScript("OnDragStop", protected.handleOnDragStop)

      cache[location] = button
    end
  end)
end

---OnDragStart event handler
function protected.handleOnDragStart()
  if not IsShiftKeyDown() then return end
  container:StartMoving()
end

---OnDragStop event handler
---@param self any Button frame
function protected.handleOnDragStop(self)
  container:StopMovingOrSizing()

  local xOffset = self:GetLeft()
  local yOffset = self:GetTop() - GetScreenHeight()

  PortalPower.Settings:Set('xOffset', math.ceil(xOffset - .5))
  PortalPower.Settings:Set('yOffset', math.ceil(yOffset - .5))
end

PortalPower.Buttons = Buttons
