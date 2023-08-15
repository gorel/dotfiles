local M = {}

local keymap = vim.api.nvim_set_keymap
local expr_opts = { expr = true, noremap = true, silent = true }

function M.setup()
  keymap("i", "<C-g>", "copilot#Accept('<CR>')", expr_opts)
  keymap("i", "<C-n>", "copilot#Next()", expr_opts)
  keymap("i", "<C-p>", "copilot#Previous()", expr_opts)
  keymap("i", "<C-s>", "copilot#Suggest()", expr_opts)
end

return M
