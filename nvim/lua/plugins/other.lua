return {
  { "folke/which-key.nvim", opts = { spec = { ["<leader>o"] = { name = "+other" } } } },
  {
    "rgroli/other.nvim",
    opts = {
      mappings = {
        "golang",
      },
    },
    config = function(opts)
      require("other-nvim").setup(opts)
    end,
    keys = {
      { "<leader>oo", "<cmd>Other<cr>", desc = "Other picker" },
      { "<leader>ot", "<cmd>Other test<cr>", desc = "Go to test file" },
      { "<leader>oT", "<cmd>Other implementation<cr>", desc = "Go to implementation file" },
    },
  },
}
