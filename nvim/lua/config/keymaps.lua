-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- This file is automatically loaded by lazyvim.config.init
local Util = require("lazyvim.util")

if Util.has("bufferline.nvim") then
  vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
end

-- Buffers
vim.keymap.set("n", "<leader>w", "<cmd>update!<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>Q", "<cmd>qall<cr>", { desc = "Quit" })

-- FileTodo
vim.keymap.set({ "n", "v" }, "<leader>t", ":FileTodo<CR>", { noremap = true, silent = true })
