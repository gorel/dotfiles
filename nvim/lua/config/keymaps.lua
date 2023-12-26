-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable defaults that I don't like
vim.keymap.del("n", "<leader>ww")
vim.keymap.del("n", "<leader>wd")
vim.keymap.del("n", "<leader>w-")
vim.keymap.del("n", "<leader>w|")

-- Buffer management
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>bdel<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Rearrange lines
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "Shift visual selection down" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "Shift visual selection up" })

-- Better scrolling
local has_neoscroll, neoscroll = pcall(require, "neoscroll.config")
if has_neoscroll then
  neoscroll.set_mappings({
    ["<C-k>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } },
    ["<C-j>"] = { "scroll", { "vim.wo.scroll", "true", "250" } },
  })
end

-- FileTodo
vim.keymap.set({ "n", "v" }, "<leader>t", ":FileTodo<CR>", { noremap = true, silent = true })
