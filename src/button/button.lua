---@class Button
---@field destination Destination Destination associated with the button
---@field frame any Blizzard frame
local Button = {}
Button.__index = Button

---Button constructor
---@param destination Destination
---@param container any
---@return Button
function Button:new(destination, container)
  local button = {}
  setmetatable(button, Button)

  button.destination = destination

  local location = destination.location
  local name = PortalPower.Constants.BUTTON.PREFIX .. PortalPower.Constants.DESTINATIONS[location].NAME

  local frame = CreateFrame("CheckButton", name, container, "SecureActionButtonTemplate, ActionBarButtonTemplate")
  frame:SetNormalTexture(nil)
  frame:SetPoint("TOPLEFT", 0, 0)
  frame:SetFrameStrata("MEDIUM")
  frame:RegisterForDrag("LeftButton")

  frame.icon:Hide()

  local backDrop = CreateFrame("Frame", nil, frame, "GwActionButtonBackdropTmpl")
  local backDropSize = 1

  backDrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -backDropSize, backDropSize)
  backDrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", backDropSize, -backDropSize)
  backDrop:SetFrameStrata("BACKGROUND")

  frame.backdrop = backDrop

  frame.background = frame:CreateTexture()
  frame.background:SetAllPoints(frame)

  frame.cd = CreateFrame("Cooldown", nil, frame)
  frame.cd:SetAllPoints(frame)
  frame.cd:SetSwipeTexture(0)
  frame.cd:SetSwipeColor(0, 0, 0, 0.75)

  frame.Count:ClearAllPoints()
  frame.Count:SetJustifyH("RIGHT")
  frame.Count:SetTextColor(1, 1, 0.6)

  frame:SetHighlightTexture("Interface/AddOns/GW2_UI/textures/UI-Quickslot-Depress")
  frame:SetPushedTexture("Interface/AddOns/GW2_UI/textures/actionbutton-pressed")

  frame:SetAttribute("type", "spell")
  frame:SetAttribute("action", 135)

  button.frame = frame

  button:Render()

  return button
end

---Fully re-renders the button
function Button:Render()
  local frame = self.frame
  local location = self.destination.location

  local size = PortalPower.Helpers.Scale(PortalPower.Constants.BUTTON.SIZE)
  frame:SetSize(size, size)

  local fontSize = PortalPower.Helpers.Scale(12)
  frame.Count:SetFont(UNIT_NAME_FONT, fontSize, "OUTLINED")

  local padding = -PortalPower.Helpers.Scale(3)
  frame.Count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", padding, padding)

  self:RenderBindings()
  self:RenderIcon()
  self:RenderTooltip()
  self:RenderCount()
  self:UpdateCooldown()

  local settingPath = 'destinations.' .. location .. '.enabled'

  local isBound = frame:GetAttribute("spell1") or frame:GetAttribute("spell2")
  local isEnabled = PortalPower.Settings:Get(settingPath)

  if isBound and isEnabled then frame:Show() end
end

function Button:RenderIcon()
  local frame = self.frame
  local option = PortalPower.Settings:Get('icon');

  local icon = PortalPower.Buttons.Button.Factories.Icon(option, self.destination, frame)

  frame.background:SetTexture(icon)
  frame.background:SetTexCoord(0.075, 0.925, 0.075, 0.925)
end

---Updates the button's cooldown based on the backing spell's information
function Button:UpdateCooldown()
  local start, duration = self.destination:GetCooldown()

  self.frame.cd:SetCooldown(start, duration)
end

---Clears the button's cooldown
function Button:ClearCooldown()
  self.frame.cd:SetCooldown(0, 0)
end

---Re-render the tooltip's reagent count
function Button:RenderBindings()
  local frame = self.frame
  local option = PortalPower.Settings:Get('behavior');

  PortalPower.Buttons.Button.Factories.Behavior(option, self.destination, frame)
end

---Re-render the tooltip information
function Button:RenderTooltip()
  local frame = self.frame
  local option = PortalPower.Settings:Get('tooltip');

  frame:SetScript("OnEnter", function(f)
    PortalPower.Buttons.Button.Factories.Tooltip(option, f, self.destination)
  end)

  frame:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
end

---Re-render the tooltip's reagent count
function Button:RenderCount()
  local frame = self.frame

  local count = PortalPower.Buttons.Button.Factories.Reagent("default", self.destination, frame)
  frame.Count:SetText(count)
end

---Enable the button
function Button:Enable() self.frame:Enable() end

---Disable the button
function Button:Disable() self.frame:Disable() end

PortalPower.Buttons.Button = Button
