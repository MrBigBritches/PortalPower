PortalPower.Constants = {
  ---@alias BUTTON {PREFIX: string, SIZE: integer}
  BUTTON = {
    PREFIX = "PortalPower",
    SIZE = 34,
  },

  ---@alias DESTINATIONS {[LocationEnum]: {NAME: string}}
  DESTINATIONS = {
    [PortalPower.Enum.Location.STORMWIND] = {
      NAME = "Stormwind",
    },
    [PortalPower.Enum.Location.IRONFORGE] = {
      NAME = "Ironforge",
    },
    [PortalPower.Enum.Location.DARNASSUS] = {
      NAME = "Darnassus",
    },
    [PortalPower.Enum.Location.THERAMORE] = {
      NAME = "Theramore",
    },
    [PortalPower.Enum.Location.SHATTRATH] = {
      NAME = "Shattrath",
    },
    [PortalPower.Enum.Location.DALARAN] = {
      NAME = "Dalaran",
    },
  },

  ---@alias EVENTS string[]
  EVENTS = {
    "BAG_UPDATE",
    "LEARNED_SPELL_IN_TAB",
    "SPELLS_CHANGED",
    "PLAYER_ENTER_COMBAT",
    "PLAYER_LEAVE_COMBAT",
    "GROUP_LEFT",
    "GROUP_JOINED",
    "UNIT_SPELLCAST_SUCCEEDED",
    "UNIT_SPELLCAST_START",
    "UNIT_SPELLCAST_STOP",
  }
}
