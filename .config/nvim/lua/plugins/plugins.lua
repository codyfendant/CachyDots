return {
  {
    "stephansama/fzf-nerdfont.nvim",
    cmd = "FzfNerdfont",
    keys = {
      { "<leader>fi", "<CMD>FzfNerdfont<CR>", desc = "Open fzf nerd font picker" },
    },
    dependencies = { "ibhagwan/fzf-lua" },
    build = ":FzfNerdfont generate",
  },
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      { "<leader>zo", "<cmd>ColorPickOklch<CR>", desc = "Oklch Color Pick" },
    },
    opts = {},
  },
  {
    "MaximilianLloyd/ascii.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown", "rmd" }, -- Add custom filetypes here if configured
    config = function()
      require("mkdnflow").setup({
        -- Your config
      })
    end,
  },
  --{
  --  "vim-scripts/DrawIt",
  --  cmd = { "DrawIt", "DIstart", "DIstop" },
  --  init = function()
  --    -- Set any global variables DrawIt needs here
  --    -- Example: Change the character used for drawing (optional)
  --    -- vim.g.drawit_line_char = "+"
  --  end,
  --  config = function()
  --    -- You can add keybindings here if you want them to be specific to DrawIt
  --    vim.keymap.set("n", "<leader>di", ":DrawIt<CR>", { desc = "Start DrawIt" })
  --    vim.keymap.set("n", "<leader>ds", ":DIstop<CR>", { desc = "Stop DrawIt" })
  --  end,
  --},
  {
    "0xferrous/ansi.nvim",
    lazy = false,
    event = "BufReadPre", -- Loads when reading a file
    config = function()
      require("ansi").setup({
        auto_enable = true, -- Automatically render for specified filetypes
        auto_enable_stdin = true, -- Automatically render when piping input (e.g. cat file.log | nvim -)
        filetypes = { "log", "ansi", "text" },
      })
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    event = "BufReadPre", -- Load the plugin before reading buffers
    opts = {
      lsp = true,
    },
    keys = {
      { "<leader>zp", "<cmd>CccPick<CR>", desc = "Pick Color" },
      { "<leader>zc", "<cmd>CccConvert<CR>", desc = "Convert Color" },
    },
  },
  -- {
  --   "MeanderingProgrammer/render-markdown.nvim",
  --   dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
  --   opts = {
  --     -- Render markdown in these modes (defaults to normal mode rendering)
  --     render_modes = { "n", "c" },

  --     heading = {
  --       -- Change heading icon style
  --       icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
  --     },

  --     code = {
  --       -- Options: 'none', 'normal', 'language', 'full'
  --       style = "full",
  --       left_pad = 2,
  --       right_pad = 2,
  --     },

  --     bullet = {
  --       -- Custom bullet point icons for lists
  --       icons = { "●", "○", "◆", "◇" },
  --     },

  --     checkbox = {
  --       enabled = true,
  --       unchecked = { icon = "󰄱 " },
  --       checked = { icon = "󰱒 " },
  --     },
  --   },
  -- },
  --{
  --  "folke/zen-mode.nvim",
  --  opts = {},
  --},
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },
  --{
  --  "stevearc/conform.nvim",
  --  opts = {
  --    formatters_by_ft = {
  --      lua = { "stylua" },
  --      python = { "isort", "black" },
  --      javascript = { "prettierd" },
  --      typescript = { "prettierd" },
  --      javascriptreact = { "prettierd" },
  --      typescriptreact = { "prettierd" },
  --      vue = { "prettierd" },
  --      html = { "prettierd" },
  --      css = { "prettierd" },
  --      scss = { "prettierd" },
  --      json = { "prettierd" },
  --      jsonc = { "prettierd" },
  --      yaml = { "prettierd" },
  --      markdown = { "prettierd" },
  --      sh = { "shfmt" },
  --      rust = { "rustfmt" },
  --      go = { "gofumpt", "goimports" },
  --      toml = { "taplo" },
  --      terraform = { "terraform_fmt" },
  --      cpp = { "clang-format" },
  --      c = { "clang-format" },
  --      ["*"] = { "trim_whitespace" },
  --    },
  --    formatters = {
  --      prettierd = {
  --        prepend_args = {
  --          "--tab-width",
  --          "2",
  --          "--single-quote",
  --          "true",
  --          "--trailing-comma",
  --          "es5",
  --          "--print-width",
  --          "100",
  --          "--semi",
  --          "true",
  --        },
  --      },
  --      shfmt = {
  --        prepend_args = { "-i", "2", "-ci", "-sr" },
  --      },
  --      rustfmt = {
  --        prepend_args = { "--edition", "2021" },
  --      },
  --      stylua = {
  --        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2", "--column-width", "120" },
  --      },
  --      black = {
  --        prepend_args = { "--line-length", "88", "--target-version", "py38" },
  --      },
  --      ["clang-format"] = {
  --        prepend_args = { "--style=Google" },
  --      },
  --    },
  --  },
  --},
  --{
  --  "DrKJeff16/wezterm-types",
  --  version = false, -- Get the latest version
  --},
  {
    "xero/evangelion.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      overrides = {
        keyword = { fg = "#00ff00", bg = "#222222", undercurl = true },
        ["@boolean"] = { link = "Special" },
      },
      --},
      --init = function()
      --  vim.cmd.colorscheme("evangelion")
      --end,
    }, --
    --{
    --  "nvim-lualine/lualine.nvim",
    --},
    {
      "voldikss/vim-floaterm",
      cmd = { "FloatermNew", "FloatermToggle", "FloatermNext", "FloatermPrev" },
      keys = {
        { "<leader>ft", "<cmd>FloatermToggle<CR>", desc = "Toggle Floaterm" },
        { "<leader>fn", "<cmd>FloatermNew<CR>", desc = "New Floaterm" },
      },
      config = function()
        vim.g.floaterm_width = 0.8
        vim.g.floaterm_height = 0.8
        vim.g.floaterm_autoclose = 1
      end,
    },
  },
}
