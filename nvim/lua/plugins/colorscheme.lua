return {
  {
    "hardhackerlabs/theme-vim",
    name = "hardhacker",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.hardhacker_darker = 0
      vim.g.hardhacker_hide_tilde = 1
      vim.g.hardhacker_keyword_italic = 1
    end,
    config = function()
      vim.cmd("colorscheme hardhacker")
    end,
    enabled = false,
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme nightfly")
    end,
    enabled = false,
  },
  {
    "sainnhe/sonokai",
    name = "sonokai",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.sonokai_style = "default"
      -- vim.g.sonokai_style = "atlantis"
      -- vim.g.sonokai_style = "andromeda"
      -- vim.g.sonokai_style = "shusia"
      -- vim.g.sonokai_style = "maia"
      -- vim.g.sonokai_style = "espresso"
      -- vim.g.sonokai_better_performance = 1
    end,
    config = function()
      vim.cmd("colorscheme sonokai")
    end,
  },
}
