return {
  "karb94/neoscroll.nvim",
  config = function()
    local t = {}
    t["<C-k>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
    t["<C-j>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
    require("neoscroll.config").set_mappings(t)
  end,
}
