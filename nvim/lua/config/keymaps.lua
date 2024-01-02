-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable defaults that I don't like
vim.keymap.del("n", "<leader>ww")
vim.keymap.del("n", "<leader>wd")
vim.keymap.del("n", "<leader>w-")
vim.keymap.del("n", "<leader>w|")

-- Buffer and tab management
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save buffer", remap = true, silent = true })
vim.keymap.set("n", "<leader>q", function()
  require("config.utils").close_buffer()
end, { desc = "Close buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader><Tab>n", "<cmd>tabnext<cr>", { desc = "Next tab" })

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

-- Dial (increment / decrement)
local has_dialmap, dialmap = pcall(require, "dial.map")
if has_dialmap then
  vim.keymap.set("n", "<C-a>", function()
    dialmap.manipulate("increment", "normal")
  end)
  vim.keymap.set("n", "<C-x>", function()
    dialmap.manipulate("decrement", "normal")
  end)
  vim.keymap.set("n", "g<C-a>", function()
    dialmap.manipulate("increment", "gnormal")
  end)
  vim.keymap.set("n", "g<C-x>", function()
    dialmap.manipulate("decrement", "gnormal")
  end)
  vim.keymap.set("v", "<C-a>", function()
    dialmap.manipulate("increment", "visual")
  end)
  vim.keymap.set("v", "<C-x>", function()
    dialmap.manipulate("decrement", "visual")
  end)
  vim.keymap.set("v", "g<C-a>", function()
    dialmap.manipulate("increment", "gvisual")
  end)
  vim.keymap.set("v", "g<C-x>", function()
    dialmap.manipulate("decrement", "gvisual")
  end)
end

-- FileTodo
vim.keymap.set({ "n", "v" }, "<leader>ct", ":FileTodo<CR>", { desc = "File Linear ticket" })

-- ToggleTerm
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
