local Options = {}

local function buildGetter(path)
  return function()
    return  PortalPower.Settings:get(path)
  end
end

local function buildSetter(path)
  return function(_, value)
    PortalPower.Settings:set(path, value)
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
        [PortalPower.Enum.Options.TOOLTIP.DEFAULT] = "Default",
        [PortalPower.Enum.Options.TOOLTIP.SIMPLE] = "Simple",
        [PortalPower.Enum.Options.TOOLTIP.DISABLED] = "Disabled"
      },

      get = buildGetter('tooltip'),
      set = buildSetter('tooltip'),
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
    }
  },
}

function Options:Register()
  LibStub("AceConfig-3.0"):RegisterOptionsTable("PortalPowerDisplay", displayOptions, nil)
  LibStub("AceConfig-3.0"):RegisterOptionsTable("PortalPowerPortals", portalOptions, nil)

  local parent = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PortalPower", "Portal Power")
  local display = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PortalPowerDisplay", "Display", "Portal Power")
  LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PortalPowerPortals", "Portals", "Portal Power")

  -- Automatically select the "Display" set of options when "Portal Power" entry is clicked
  parent:SetScript("OnShow", function() InterfaceOptionsFrame_OpenToCategory(display) end)
end

PortalPower.Options = Options