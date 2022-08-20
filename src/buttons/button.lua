local Button = {}
Button.__index = Button

function Button:new(destination, container)
  PortalPower.Enum.Destination:AssertValid(destination)

  local button = {}
  setmetatable(button, Button)

  button.destination = destination
  local spell = PortalPower.Spells:Get(destination)

  local name =  PortalPower.Constants.BUTTON.PREFIX .. PortalPower.Constants.DESTINATIONS[destination].NAME

  -- Set button attributes that will not change
  local frame = CreateFrame("CheckButton", name, container, "SecureActionButtonTemplate, ActionBarButtonTemplate")
  frame:SetNormalTexture(nil)
  frame:SetPoint("TOPLEFT", 0 , 0)
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
  frame.background:SetTexture(spell.teleport.icon)
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

function Button:Render()
  local frame = self.frame

  local size = PortalPower.Helpers.Scale(PortalPower.Constants.BUTTON.SIZE)
  frame:SetSize(size, size)

  local fontSize = PortalPower.Helpers.Scale(12)
  frame.Count:SetFont(UNIT_NAME_FONT, fontSize, "OUTLINED")

  local padding = -PortalPower.Helpers.Scale(3)
  frame.Count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", padding, padding)

  local spell = PortalPower.Spells:Get(self.destination)
  if spell.portal.id then frame:SetAttribute("spell1", spell.portal.id) end
  if spell.teleport.id then frame:SetAttribute("spell2", spell.teleport.id) end

  self:RenderTooltip()
  self:RenderCount()
  self:UpdateCooldown()

  frame:Show()
end

function Button:UpdateCooldown()
  local spell = PortalPower.Spells:Get(self.destination)
  local start, duration = spell:GetCooldown()

  self.frame.cd:SetCooldown(start, duration)
end

function Button:ClearCooldown()
  self.frame.cd:SetCooldown(0, 0)
end

function Button:RenderTooltip()
  local frame = self.frame
  local spell = PortalPower.Spells:Get(self.destination)
  local option = PortalPower.Settings:get('tooltip');

  frame:SetScript("OnEnter", function(f)
    PortalPower.Buttons.Button.Factories.Tooltip(option, f, spell)
  end)

   frame:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
end

function Button:RenderCount()
  local spell = PortalPower.Spells:Get(self.destination)
  local count = PortalPower.Buttons.Button.Factories.Reagent("default", spell)

  self.frame.Count:SetText(count)
end

function Button:Enable() self.frame:Enable() end
function Button:Disable() self.frame:Disable() end

PortalPower.Buttons.Button = Button