-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

map({ "n" }, "===", function()
  LazyVim.format({ force = true })
end, { desc = "general format file" })

map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
