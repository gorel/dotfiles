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

-- Dial (increment/decrement)
local hasdial, dial = pcall(require, "dial.map")
if hasdial then
  keymap("n", "<C-a>", dial.inc_normal(), default_opts)
  keymap("n", "<C-x>", dial.dec_normal(), default_opts)
  keymap("v", "<C-a>", dial.inc_visual(), default_opts)
  keymap("v", "<C-x>", dial.dec_visual(), default_opts)
  keymap("v", "g<C-a>", dial.inc_gvisual(), default_opts)
  keymap("v", "g<C-x>", dial.dec_gvisual(), default_opts)
end

-- Navigate buffers with tab/shift-tab
keymap("n", "<TAB>", ":bnext<CR>", default_opts)
keymap("n", "<S-TAB>", ":bprevious<CR>", default_opts)

-- Folding
--  Increase with zm, decrease with zr, fold all with zM, unfold all with zR
--  Toggle fold with za, open fold with zo, close fold with zc
--  If foldmethod is changed to manual, zf to fold (use as text object, e.g. zfaw, or in visual mode)
-- Toggle fold
vim.keymap.set({ "n", "v" }, "<LEADER><space>", "za", default_opts)

-- Copy names
keymap("n", ";cc", ':let @+=expand("%")<CR>', default_opts)
keymap("n", ";cl", ':let @+=join([expand("%"), line(".")], ":")<CR>', default_opts)
keymap("n", ";cp", ':let @+=expand("%:p")<CR>', default_opts)
