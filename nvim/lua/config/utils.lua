local M = {}

local function count_buffers()
  local count = 0

  for _, bufnr in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    local bufname = vim.fn.bufname(bufnr.bufnr)
    if bufname and bufname ~= "" then
      count = count + 1
    end
  end

  return count
end

function M.close_buffer()
  if count_buffers() <= 1 then
    vim.api.nvim_exec([[:q]], true)
  else
    vim.api.nvim_exec([[:bd]], true)
  end
end

return M
