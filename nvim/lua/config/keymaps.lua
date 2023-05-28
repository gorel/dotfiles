-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- This file is automatically loaded by lazyvim.config.init
local Util = require("lazyvim.util")

-- Buffer management
vim.keymap.set("n", "<C-w>", "<cmd>bdel<cr>", { desc = "Delete Buffer" })
vim.keymap.set("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })
if Util.has("bufferline.nvim") then
  vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
end

-- FileTodo
vim.keymap.set({ "n", "v" }, "<leader>t", ":FileTodo<CR>", { noremap = true, silent = true })
