-- keybindings.lua
local wezterm = require("wezterm")
local act = wezterm.action
local theme_switcher = require("theme_switcher")
local keys = {
  {
    key = "h",
    mods = "LEADER",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    desc = "Split horizontal",
  },
  { key = "v", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }), desc = "Split vertical" },
  { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) }, -- desc is optional
  { key = "c", mods = "LEADER", action = wezterm.action_callback(theme_switcher.theme_switcher) },
}
return keys
