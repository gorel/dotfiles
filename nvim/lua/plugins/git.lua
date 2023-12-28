return {
  {
    "f-person/git-blame.nvim",
    opts = {
      enabled = false,
    },
    keys = {
      -- under "+git" group
      { "<leader>gb", "<cmd>GitBlameToggle<cr>", "Toggle blame" },
      -- under "+ui" group
      { "<leader>ub", "<cmd>GitBlameToggle<cr>", "Toggle blame" },
    },
  },
}
