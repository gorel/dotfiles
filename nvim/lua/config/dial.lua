local M = {}

function M.setup()
  local keymap = vim.api.nvim_set_keymap
  require("dial").augends:register_group {
    default = {
      augend.integer.alias.decimal_int, -- include negative numbers
      augend.integer.alias.hex,
      augend.date.alias["%Y/%m/%d"],
      augend.date.alias["%Y-%m-%d"],
      augend.date.alias["%m/%d"],
      augend.constant.alias.alpha, -- lowercase letter
      augend.constant.alias.Alpha, -- uppercase letter
      augend.constant.alias.bool, -- true, false
      augend.semver.alias.semver,
      augend.constant.new {
        elements = { "True", "False" },
        word = true,
        cyclic = true,
      },
      augend.constant.new {
        elements = { "and", "or" },
        word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
        cyclic = true, -- "or" is incremented into "and".
      },
      augend.constant.new {
        elements = { "&&", "||" },
        word = false,
        cyclic = true,
      },
    },
  }
end

return M
