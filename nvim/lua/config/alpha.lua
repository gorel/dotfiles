local M = {}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require "alpha.themes.dashboard"
  local function header()
    return {
      [[                                           iiii                           ]],
      [[                                          i::::i                          ]],
      [[                                           iiii                           ]],
      [[                                                                          ]],
      [[ nnnn  nnnnnnnn vvvvvvv           vvvvvvviiiiiii    mmmmmmm    mmmmmmm    ]],
      [[ n:::nn::::::::nnv:::::v         v:::::v i:::::i  mm:::::::m  m:::::::mm  ]],
      [[ n::::::::::::::nnv:::::v       v:::::v   i::::i m::::::::::mm::::::::::m ]],
      [[ nn:::::::::::::::nv:::::v     v:::::v    i::::i m::::::::::::::::::::::m ]],
      [[   n:::::nnnn:::::n v:::::v   v:::::v     i::::i m:::::mmm::::::mmm:::::m ]],
      [[   n::::n    n::::n  v:::::v v:::::v      i::::i m::::m   m::::m   m::::m ]],
      [[   n::::n    n::::n   v:::::v:::::v       i::::i m::::m   m::::m   m::::m ]],
      [[   n::::n    n::::n    v:::::::::v        i::::i m::::m   m::::m   m::::m ]],
      [[   n::::n    n::::n     v:::::::v        i::::::im::::m   m::::m   m::::m ]],
      [[   n::::n    n::::n      v:::::v         i::::::im::::m   m::::m   m::::m ]],
      [[   n::::n    n::::n       v:::v          i::::::im::::m   m::::m   m::::m ]],
      [[   nnnnnn    nnnnnn        vvv           iiiiiiiimmmmmm   mmmmmm   mmmmmm ]],
    }
  end

  dashboard.section.header.val = header()

  dashboard.section.buttons.val = {
    dashboard.button("o", "📁 Open file", "<Cmd>Telescope find_files<CR>"),
    dashboard.button("g", "🔍 Grep file", "<Cmd>Telescope live_grep<CR>"),
    dashboard.button("r", "♻  Recent files", "<Cmd>Telescope oldfiles<CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  local function footer()
    -- Number of plugins
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date "%d-%m-%Y %H:%M:%S"
    local plugins_text = 
      "   "
      .. total_plugins
      .. " plugins"
      .. "   v"
      .. vim.version().major
      .. "."
      .. vim.version().minor
      .. "."
      .. vim.version().patch
      .. "   "
      .. datetime

    return plugins_text
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Constant"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Function"
  dashboard.section.buttons.opts.hl_shortcut = "Type"
  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.opts)
end

return M
