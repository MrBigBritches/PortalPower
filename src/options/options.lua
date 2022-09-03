local Options = {}

local function buildGetter(path)
  return function()
    return PortalPower.Settings:Get(path)
  end
end

local function buildSetter(path)
  return function(_, value)
    PortalPower.Settings:Set(path, value)
  end
end

local displayOptions = {
  name = "Display",
  type = "group",

  args = {
    description = {
      type = "description",
      name = "Configure how the portal buttons are displayed",
    },

    direction = {
      type = "select",
      style = "dropdown",

      name = "Direction",
      desc = "Changes the direction of the portal buttons",

      values = {
        [PortalPower.Enum.Options.DISPLAY.HORIZONTAL] = "Horizontal",
        [PortalPower.Enum.Options.DISPLAY.VERTICAL] = "Vertical"
      },

      get = buildGetter('direction'),
      set = buildSetter('direction'),
    },

    spacing = {
      type = "range",

      name = "Spacing",
      desc = "Changes the spacing between the buttons",

      width = "full",

      min = 0,
      max = 10,
      step = 1,

      get = buildGetter('spacing'),
      set = buildSetter('spacing'),
    },

    scale = {
      type = "range",

      name = "Scale",
      desc = "Scales portal buttons to be larger or smaller",

      width = "full",

      min = 0.5,
      max = 1.5,
      step = 0.01,

      get = buildGetter('scale'),
      set = buildSetter('scale'),
    },

    toolip = {
      type = "select",
      style = "dropdown",

      name = "Tooltip",
      desc = "Changes the amount information tooltips display",

      values = {
        [PortalPower.Enum.Options.TOOLTIP.VERBOSE] = "Verbose",
        [PortalPower.Enum.Options.TOOLTIP.BASIC] = "Basic",
        [PortalPower.Enum.Options.TOOLTIP.DISABLED] = "Disabled"
      },

      get = buildGetter('tooltip'),
      set = buildSetter('tooltip'),
    },
  },
}

local behaviorOptions = {
  name = "Behavior",
  type = "group",
  args = {
    description = {
      type = "description",
      name = "Configure how the action buttons work",
    },

    behavior = {
      type = "select",
      style = "dropdown",

      name = "Behavior",
      desc = "Changes how the action buttons function when clicked",

      values = {
        [PortalPower.Enum.Options.BEHAVIOR.SIMPLE] = "Simple",
        [PortalPower.Enum.Options.BEHAVIOR.PORTAL_PRIMARY] = "Portal - Primary",
        [PortalPower.Enum.Options.BEHAVIOR.PORTAL_ONLY] = "Portal - Only",
        [PortalPower.Enum.Options.BEHAVIOR.TELEPORT_PRIMARY] = "Teleport - Primary",
        [PortalPower.Enum.Options.BEHAVIOR.TELEPORT_ONLY] = "Teleport - Only",
      },

      get = buildGetter('behavior'),
      set = buildSetter('behavior'),
    },
  },
}

local portalOptions = {
  name = "Portals",
  type = "group",
  args = {
    description = {
      type = "description",
      name = "Configure which portals are displayed",
    },
  },
}

function Options:Register()
  LibStub("AceConfig-3.0"):RegisterOptionsTable("PortalPowerDisplay", displayOptions, nil)
  LibStub("AceConfig-3.0"):RegisterOptionsTable("PortalPowerBehavior", behaviorOptions, nil)
  LibStub("AceConfig-3.0"):RegisterOptionsTable("PortalPowerPortals", portalOptions, nil)

  local parent = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PortalPower", "Portal Power")
  local display = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PortalPowerDisplay", "Display", "Portal Power")
  LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PortalPowerBehavior", "Behavior", "Portal Power")
  LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PortalPowerPortals", "Portals", "Portal Power")

  -- Automatically select the "Display" set of options when "Portal Power" entry is clicked
  parent:SetScript("OnShow", function() InterfaceOptionsFrame_OpenToCategory(display) end)
end

PortalPower.Options = Options
