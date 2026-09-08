--`` Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v" }, ";", ":", { desc = "CMD enter command mode" })

--keymap("t", "<Esc><Esc>", "<C-\\><C-n>", opts("Exit Terminal mode."))

--keymap("n", "<S-l>", ":bnext<CR>", opts("Switch to Next buffer."))
--keymap("n", "<S-h>", ":bprevious<CR>", opts("Switch to Previous buffer."))
--keymap("n", "<leader>bd", utils.bufmove, opts("Delete current buffer"))
--
