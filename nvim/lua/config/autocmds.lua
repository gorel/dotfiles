-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- don't auto comment new line
vim.cmd([[autocmd FileType * setlocal formatoptions-=cro]])

-- Linear tasks
vim.cmd([[
  function FileTodo(...)
      let l:team_key = input("Team shortname (eg BACK or TECH): ")
      if l:team_key == ''
        return
      endif
      let l:task_text = input("Task text: ")
      if l:task_text == ''
        return
      endif
      let l:linear_cmd = 'create-linear-issue.sh ' . shellescape(l:team_key) . ' ' . shellescape(l:task_text)
      let l:ticket_id_raw = system(l:linear_cmd)
      let l:ticket_id = substitute(l:ticket_id_raw, '[\r\n]*$', '', '')
      let l:comment = substitute(&l:commentstring, '%s', l:ticket_id . ': ' . l:task_text, '')
      execute 'normal O'.l:comment 
  endfunction
  command! -range -nargs=? FileTodo call FileTodo(<line1>, <line2>, <f-args>)
]])

-- close some (more) filetypes with <q>
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "?",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
