return {
  {
    "karb94/neoscroll.nvim",
    opts = function(_, opts)
      local t = {}
      t["<C-k>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
      t["<C-j>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
      require("neoscroll.config").set_mappings(t)
    end,
  },
}
