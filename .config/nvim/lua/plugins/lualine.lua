return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options = opts.options or {}
    opts.options.theme = "molokai"
    opts.options.section_separators = { left = "", right = "" }
    opts.options.component_separators = { left = "", right = "" }

    opts.sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          "buffers",
          show_filename_only = true,
          hide_filename_extension = true,
          show_modified_status = false,
          mode = 0,
          filetype_names = {
            TelescopePrompt = "Telescope",
            dashboard = "dashboard",
            fzf = "FZF",
            alpha = "Alpha",
            snacks = "Snacks",
          },
        },
      },
      lualine_c = {
        {
          "filename",
          path = 0,
          symbols = {
            modified = " ",
            readonly = " ",
            unnamed = "[No Name]",
            newfile = "[New]",
          },
        },
      },
      lualine_x = {
        { "filetype", colored = true, icon_only = false },
        "fileformat",
        { "encoding", show_bomb = false },
      },
      lualine_y = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
        },
      },
      lualine_z = {
        function()
          return os.date("%H:%M")
        end,
      },
    }

    opts.extensions = { "fzf", "toggleterm", "trouble", "nvim-tree" }
  end,
}
