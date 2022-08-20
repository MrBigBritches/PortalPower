function PortalPower.Addon:OnInitialize()
  PortalPower.Settings:Initialize()
  self.settings = PortalPower.Settings


  -- Register slash commands
  self:RegisterChatCommand("pp", "SlashCommand")
  self:RegisterChatCommand("portalpower", "SlashCommand")

  -- Register Options
  PortalPower.Options:Register()

  self:Debug("Debugging Enabled")
end

function PortalPower.Addon:OnEnable()
  local _, class = UnitClass("player")
  if class ~= "MAGE" then return end
  

  -- Create & render portal buttons 
  PortalPower.Buttons:Initialize()
  PortalPower.Buttons:Render()
  PortalPower.Buttons:UpdateDisplay()

  -- Setup listener for changes to settings
  self.settings:OnChange(function()
    PortalPower.Buttons:Render()
  end)

  self.settings:OnChange({'direction', 'scale', 'spacing'}, function()
    PortalPower.Buttons:UpdateDisplay()
  end)

  -- Setup listener for relevant events
  PortalPower.Helpers.Iterate(PortalPower.Constants.EVENTS, function(event)
    self:RegisterEvent(event, "EventHandler")
  end)

  -- PortalPower.Helpers.Iterate(PortalPower.Constants.EVENTS_COOLDOWN, function(event)
  --   self:RegisterEvent(event, "EventHandler")
  -- end)

  -- self.eventListener:SetScript("OnEvent", function(self, event)
  --   -- print(event)
  --   PortalPower.Buttons:Render()
  -- end)

  -- PortalPower.Helpers.Iterate(PortalPower.Enum.Destination, function(destination)
  --   local spell = PortalPower.Spells:Get(destination)

  --   local portal = spell:IsKnown(PortalPower.Enum.SpellType.PORTAL)    
  --   local teleport = spell:IsKnown(PortalPower.Enum.SpellType.TELEPORT)

  --   local message = destination .. ": Teleport("..(teleport and "known" or "unknown").."), Portal("..(portal and "known" or "unknown")..")"
  --   self:Debug(message)
  -- end)
end

function PortalPower.Addon:SlashCommand(command)
  local switch = {
    debugger = function()
      local debugEnabled = not self.settings:get('debugEnabled')
      self.settings:set('debugEnabled', debugEnabled)

      local result = debugEnabled and "enabled" or "disabled"
      self:Print("Debugging has been " .. result)
    end,
    options = function()
      self:Print("Opening options pane")
    end,
    reset = function()
      self:Print("Resetting PortalPower")
      PortalPower.Settings:Reset()
    end,
  }

  local callback = switch[command]
  if callback then callback() else self:Print("Unknown command \"" .. command .. "\"") end
end

function PortalPower.Addon:EventHandler(event)
  PortalPower.Buttons:Render()

  if event == "UNIT_SPELLCAST_STOP" then PortalPower.Buttons:ClearCooldown() end
end