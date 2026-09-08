return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      width = 70,
      preset = {
        header = false, -- Disable default fastfetch header
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "󰒲 ", key = "l", desc = "Lazy Plugins", action = ":Lazy" },
          { icon = "󰈆 ", key = "q", desc = "Quit", action = ":qa" },
          { icon = " ", key = "N", desc = "Notes", action = ":e ~/notes" },
          { icon = " ", key = "p", desc = "Plugins", action = ":e ~/.config/nvim/lua/plugins/plugins.lua" },
        },
      },
      sections = {
        {
          section = "terminal",
          cmd = { "sh", "-c", "lolcrab ~/logo.txt 2>/dev/null || cat ~/logo.txt; tail -f /dev/null" },
          height = 12,
          padding = 1,
          ttl = 0,
        },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
