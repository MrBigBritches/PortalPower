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

  -- Set button attributes that will not change
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
  frame.background:SetTexture(destination.teleport.icon)
  frame.background:SetTexCoord(0.075, 0.925, 0.075, 0.925)

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
  local destination = self.destination

  local size = PortalPower.Helpers.Scale(PortalPower.Constants.BUTTON.SIZE)
  frame:SetSize(size, size)

  local fontSize = PortalPower.Helpers.Scale(12)
  frame.Count:SetFont(UNIT_NAME_FONT, fontSize, "OUTLINED")

  local padding = -PortalPower.Helpers.Scale(3)
  frame.Count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", padding, padding)

  local portalId = destination.portal.id
  if portalId then frame:SetAttribute("spell1", portalId) end

  local teleportId = destination.teleport.id
  if teleportId then frame:SetAttribute("spell2", teleportId) end

  self:RenderTooltip()
  self:RenderCount()
  self:UpdateCooldown()

  frame:Show()
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
  local count = PortalPower.Buttons.Button.Factories.Reagent("default", self.destination)

  self.frame.Count:SetText(count)
end

---Enable the button
function Button:Enable() self.frame:Enable() end

---Disable the button
function Button:Disable() self.frame:Disable() end

PortalPower.Buttons.Button = Button
