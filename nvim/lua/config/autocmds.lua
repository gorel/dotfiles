-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- don't auto comment new line
vim.cmd([[autocmd FileType * setlocal formatoptions-=cro]])

-- set up my colorscheme
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
vim.cmd([[

  silent! colorscheme tokyonight
]])

-- Linear tasks
vim.cmd([[
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
]])

-- Close vim if the last buffer is deleted
vim.cmd([[
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
]])