# PortalPower
World of Warcraft addon to manage mage portals.

## Options
### Behavior
Changes which spell will be cast when an action button is clicked

* Simple
  * Prioritize the `Teleport` spell when solo or `Portal` when grouped with other players.
* Portal/Teleport - Primary
  * Use the selected primary spell when left-clicking the action button
* Portal/Teleport - Only
  * Will only bind the selected spell to the action button and will hide the button if the spell is not known.

### Display
Settings that affect how the action buttons are displayed in game

**Direction**
* Horizontal
* Vertical

**Spacing**  
Changes the amount of space between each button based on the selected slider value

**Scale**  
Sets the size of the buttons based on the selected slider value

**Icon**
* Default 
  * Shows the icon of the primary/left action
* Prefer Portal
  * Always shows the corresponding portal icon unless the spell is unknown
* Prefer Teleport
  * Always shows the corresponding teleport icon unless the spell is unknown

**Tooltip**
* Verbose
  * Shows spell bindings, titles, and details on hover
* Basic
  * Only displays the destination name of the spell on hover
* Disabled
  * No tooltip is displayed when hovering over the action buttons

## Debugging
Debugging is made much easier by enabling console errors
* `/console scriptErrors 1`

You can disable this feature with 
* `/console scriptErrors 0`

## IDE
Recommend using Visual Studio Code as there are a number of plugins that can help with development
* [Lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)
* [WoW API](https://marketplace.visualstudio.com/items?itemName=ketho.wow-api)
