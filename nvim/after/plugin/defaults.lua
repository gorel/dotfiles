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
opt.timeoutlen = 300 -- Time in milliseconds to wait for a mapped sequence to complete.
opt.showmode = false -- Do not need to show the mode. We use the statusline instead.
opt.scrolloff = 999 -- Lines of context
opt.joinspaces = false -- No double spaces with join after a dot

-- Better folds
opt.foldmethod = "indent" -- Lines with equal indent form a fold. (default: manual)
opt.foldnestmax = 10 -- deepest fold is 10 levels (default: 20)
opt.foldlevelstart = 10 -- set initial fold level to max (which prevents immediately nesting everything upon first fold) (default: -1)

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

-- Use Lua filetype
vim.cmd [[
  let g:do_filetype_lua = 1
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
g.tokyonight_style = "storm"
g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
vim.cmd [[

  silent! colorscheme tokyonight
]]

-- Linear tasks
vim.cmd [[
  function FileTodo(...)
      let l:team_key = input("Team shortname (eg BACK or TECH): ")
      let l:task_text = input("Task text: ")
      let l:linear_cmd = 'create-linear-issue.sh ' . shellescape(l:team_key) . ' ' . shellescape(l:task_text)
      let l:ticket_id_raw = system(l:linear_cmd)
      let l:ticket_id = substitute(l:ticket_id_raw, '[\r\n]*$', '', '')
      let l:comment = substitute(&l:commentstring, '%s', l:ticket_id . ': ' . l:task_text, '')
      execute 'normal O'.l:comment 
  endfunction
  command! -range -nargs=? FileTodo call FileTodo(<line1>, <line2>, <f-args>)
]]
vim.keymap.set({ "n", "v" }, "<leader>ft", ":FileTodo<CR>", { noremap = true, silent = true })

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
