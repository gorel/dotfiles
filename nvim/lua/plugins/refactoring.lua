return {
  { "folke/which-key.nvim", opts = { defaults = { ["<leader>r"] = { name = "+refactor" } } } },
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
      { "<leader>re", ":Refactor extract", desc = "Extract function" },
      { "<leader>rf", ":Refactor extract_to_file", desc = "Extract function to file" },
      { "<leader>rv", ":Refactor extract_var", desc = "Extract variable" },
      { "<leader>rI", ":Refactor inline_func", desc = "Inline function" },
      { "<leader>ri", ":Refactor inline_var", desc = "Inline variable" },
      { "<leader>rb", ":Refactor extract_block", desc = "Extract block" },
      { "<leader>rbf", ":Refactor extract_block_to_file", desc = "Extract block to file" },
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
