local wezterm = require("wezterm") ---@type wezterm
local config = wezterm.config_builder() ---@class config
config.color_scheme = "rebecca"
config.colors = {
  background = "#000000", -- Replace with your preferred Hex color
}
config.font =
  wezterm.font("JetBrainsMonoNL Nerd Font Propo", { weight = "Medium", stretch = "Normal", style = "Normal" })
config.font_size = 12.0
config.initial_cols = 120
config.initial_rows = 28
config.window_background_opacity = 0.8
config.leader = { key = "Space", mods = "ALT", timeout_milliseconds = 1000 }
config.keys = require("keybindings")
config.tab_bar_at_bottom = false

config.front_end = "WebGpu"
config.webgpu_preferred_adapter = {
  backend = "Vulkan",
  device = 38993,
  device_type = "IntegratedGpu",
  driver = "radv",
  driver_info = "Mesa 26.1.6-arch3.1",
  name = "AMD Radeon R5 Graphics (RADV KABINI)",
  vendor = 4098,
}
config.max_fps = 30
config.animation_fps = 1
config.cursor_blink_rate = 0
--tabline: setup FIRST, then apply
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
  options = {
    icons_enabled = true,
    theme = config.color_scheme,
    tabs_enabled = true,
    theme_overrides = {},
    section_separators = {
      left = wezterm.nerdfonts.ple_upper_left_triangle,
      right = wezterm.nerdfonts.ple_lower_right_triangle,
    },
    component_separators = {
      left = wezterm.nerdfonts.ple_forwardslash_separator_redundant,
      right = wezterm.nerdfonts.ple_forwardslash_separator_redundant,
    },
    tab_separators = {
      left = wezterm.nerdfonts.ple_upper_left_triangle,
      right = wezterm.nerdfonts.ple_lower_right_triangle,
    },
  },
  sections = {
    tabline_a = { "mode" },
    tabline_b = { "hostname", " " },
    tabline_c = { " " },
    tab_active = {
      --      "[",
      --      { "index", padding = 0 },
      --      "]",
      { "parent", padding = 1 },
      "/",
      { "cwd", padding = { left = 1, right = 1 } },
      --      { "zoomed", padding = 0 },
    },
    tab_inactive = {
      "[",
      { "index", padding = 0 },
      "]",
      { "process", padding = { left = 1, right = 1 } },
    },
    tabline_x = { " " },
    tabline_y = { " ", "cpu" },
    tabline_z = { "domain" },
  },
  extensions = {},
})
tabline.apply_to_config(config)

-- cmdpicker: register existing keys, then apply LAST
local cmdpicker = wezterm.plugin.require("https://github.com/abidibo/wezterm-cmdpicker")
cmdpicker.add_keys(config.keys)
cmdpicker.apply_to_config(config, {
  title = "Command Palette",
  key = "p",
  mods = "LEADER",
})
local toggle_terminal = wezterm.plugin.require("https://github.com/zsh-sage/toggle_terminal.wez")
toggle_terminal.apply_to_config(config, {
  key = ";", -- Key for the toggle action
  mods = "CTRL", -- Modifier keys for the toggle action
  direction = "Up", -- Direction to split the pane
  size = { Percent = 20 }, -- Size of the split pane
  change_invoker_id_everytime = false, -- Change invoker pane on every toggle
  zoom = {
    auto_zoom_toggle_terminal = false, -- Automatically zoom toggle terminal pane
    auto_zoom_invoker_pane = true, -- Automatically zoom invoker pane
    remember_zoomed = true,
  },
})

--local sys = wezterm.plugin.require("https://github.com/usrivastava92/widgets.wez")
--
--sys.apply_to_config(config, {
--  right = {
--    sys.cpu.utilization.widget(),
--    sys.ram.utilization.widget(),
--    sys.network.download.widget(),
--  },
--  separator = { text = "|", color = "#747d9f" },
--})
return config
