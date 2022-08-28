local BehaviorEnum = PortalPower.Enum.Options.BEHAVIOR

---Binds to supplied spell position if spell exists and increments the position
---@param button any
---@param spell string
---@param tracker {pos: number}
---@return integer
local function smartBind(button, spell, tracker)
  local position = tracker.pos
  if spell then
    button:SetAttribute("spell" .. position, spell)
    tracker.pos = position + 1
  end

  return tracker.pos
end

---Binds to Spell1 if isBound is false
---@param button any
---@param spell string
---@param tracker {isBound: boolean}
---@return boolean
local function exclusiveBind(button, spell, tracker)
  if not tracker.isBound and spell then
    button:SetAttribute("spell1", spell)
    tracker.isBound = true
  end

  return tracker.isBound
end

---Chooses and binds the correct button spells based on the supplied
---option and destination
---@param option OptionBehaviorEnum
---@param destination Destination
---@param button CheckButton
local function BehaviorFactory(option, destination, button)
  local tracker = { pos = 1, isBound = false }

  button:SetAttribute("spell1", nil)
  button:SetAttribute("spell2", nil)

  local portalId = destination.portal.id
  local teleportId = destination.teleport.id

  local switch = {
    [BehaviorEnum.SIMPLE] = function()
      local inGroup = IsInGroup()

      if inGroup then
        exclusiveBind(button, portalId, tracker)
        exclusiveBind(button, teleportId, tracker)
      else
        exclusiveBind(button, teleportId, tracker)
        exclusiveBind(button, portalId, tracker)
      end
    end,

    [BehaviorEnum.PORTAL_PRIMARY] = function()
      smartBind(button, portalId, tracker)
      smartBind(button, teleportId, tracker)
    end,

    [BehaviorEnum.PORTAL_ONLY] = function()
      smartBind(button, portalId, tracker)
    end,

    [BehaviorEnum.TELEPORT_PRIMARY] = function()
      smartBind(button, teleportId, tracker)
      smartBind(button, portalId, tracker)
    end,

    [BehaviorEnum.TELEPORT_ONLY] = function()
      smartBind(button, teleportId, tracker)
    end,
  }

  return switch[option]()
end

PortalPower.Buttons.Button.Factories.Behavior = BehaviorFactory
