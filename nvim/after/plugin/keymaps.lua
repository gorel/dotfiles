local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)
keymap("t", "jk", "<C-\\><C-n>", default_opts)
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", default_opts)
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", default_opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", default_opts)
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Telescope
keymap("n", "<leader>fo", ":lua require'telescope.builtin'.find_files()<CR>", default_opts)
keymap("n", "<leader>fr", ":lua require'telescope.builtin'.oldfiles()<CR>", default_opts)
keymap("n", "<leader>fg", ":lua require'telescope.builtin'.live_grep()<CR>", default_opts)
keymap("n", "<leader>fh", ":lua require'telescope.builtin'.help_tags()<CR>", default_opts)
keymap("n", "<leader>fb", ":lua require'telescope.builtin'.buffers()<CR>", default_opts)

-- Buffer management
keymap("n", "<leader>bn", ":bnext<CR>", default_opts)
keymap("n", "<leader>bp", ":bprevious<CR>", default_opts)
keymap("n", "<leader>b1", "<Cmd>BufferLineGoToBuffer 1<CR>", default_opts)
keymap("n", "<leader>b2", "<Cmd>BufferLineGoToBuffer 2<CR>", default_opts)
keymap("n", "<leader>b3", "<Cmd>BufferLineGoToBuffer 3<CR>", default_opts)
keymap("n", "<leader>b4", "<Cmd>BufferLineGoToBuffer 4<CR>", default_opts)
keymap("n", "<leader>b5", "<Cmd>BufferLineGoToBuffer 5<CR>", default_opts)
keymap("n", "<leader>b6", "<Cmd>BufferLineGoToBuffer 6<CR>", default_opts)
keymap("n", "<leader>b7", "<Cmd>BufferLineGoToBuffer 7<CR>", default_opts)
keymap("n", "<leader>b8", "<Cmd>BufferLineGoToBuffer 8<CR>", default_opts)
keymap("n", "<leader>b9", "<Cmd>BufferLineGoToBuffer 9<CR>", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

-- Insert blank line
keymap("n", "]<Space>", "o<Esc>", default_opts)
keymap("n", "[<Space>", "O<Esc>", default_opts)
