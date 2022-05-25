local api = vim.api
local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

opt.termguicolors = true -- Enable colors in terminal
opt.fileformat = "unix" -- always use unix line endings
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.timeoutlen = 300 --	Time in milliseconds to wait for a mapped sequence to complete.
opt.showmode = false -- Do not need to show the mode. We use the statusline instead.
opt.scrolloff = 999 -- Lines of context
opt.joinspaces = false -- No double spaces with join after a dot

-- default formatting
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.textwidth = 120
opt.expandtab = true
opt.autoindent = true

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable nvim intro
opt.shortmess:append "sI"

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Better search
opt.path:remove "/usr/include"
opt.path:append "**"
-- vim.vim.cmd [[set path=.,,,$PWD/**]] -- Set the path directly

opt.wildignorecase = true
opt.wildignore:append "**/node_modules/*"
opt.wildignore:append "**/.git/*"

-- Treesitter based folding
vim.cmd [[
  set foldlevel=20
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
]]

-- show cursor line only in active window
vim.cmd [[
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline
]]

-- go to last loc when opening a buffer
vim.cmd [[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
]]

-- Check if we need to reload the file when it changed
cmd "au FocusGained * :checktime"

-- windows to close with "q"
vim.cmd [[autocmd FileType help,startuptime,qf,lspinfo nnoremap <buffer><silent> q :close<CR>]]
vim.cmd [[autocmd FileType man nnoremap <buffer><silent> q :quit<CR>]]

-- don't auto comment new line
vim.cmd [[autocmd FileType * setlocal formatoptions-=cro]]

-- Copilot
vim.cmd [[
  imap <silent><script><expr> <C-s> copilot#Accept("\<CR>")
  let g:copilot_no_tab_map = v:true
]]

-- set up my colorscheme
vim.cmd [[silent! colorscheme jellybeans]]

-- Close vim if the last buffer is deleted
vim.cmd [[
function! CountListedBuffers()
     let cnt = 0
     for nr in range(1,bufnr("$"))
if buflisted(nr) && ! empty(bufname(nr)) || getbufvar(nr, '&buftype') ==# 'help'
             let cnt += 1
         endif
     endfor
     return cnt
endfunction

function! QuitIfLastBuffer()
     if CountListedBuffers() == 1
         :q
     endif
 endfunction

autocmd BufDelete * :call QuitIfLastBuffer()
]]
