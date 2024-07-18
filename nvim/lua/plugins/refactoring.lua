return {
  { "folke/which-key.nvim", opts = { spec = { ["<leader>r"] = { name = "+refactor" } } } },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup({
        prompt_func_return_type = {
          go = true,
        },
        prompt_func_param_type = {
          go = true,
        },
      })
    end,
    keys = {
      { "<leader>re", "<cmd>Refactor extract<cr>", desc = "Extract function" },
      { "<leader>rf", "<cmd>Refactor extract_to_file<cr>", desc = "Extract function to file" },
      { "<leader>rv", "<cmd>Refactor extract_var<cr>", desc = "Extract variable" },
      { "<leader>rI", "<cmd>Refactor inline_func<cr>", desc = "Inline function" },
      { "<leader>ri", "<cmd>Refactor inline_var<cr>", desc = "Inline variable" },
      { "<leader>rb", "<cmd>Refactor extract_block<cr>", desc = "Extract block" },
      { "<leader>rbf", "<cmd>Refactor extract_block_to_file<cr>", desc = "Extract block to file" },
    },
  },
  {
    "mizlan/iswap.nvim",
    keys = {
      { "<leader>rs", ":ISwapNodeWithRight<CR>", desc = "Swap with next" },
      { "<leader>rS", ":ISwapNodeWithLeft<CR>", desc = "Swap with previous" },
    },
  },
}
