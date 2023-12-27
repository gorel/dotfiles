return {
  { "nvim-neotest/neotest-plenary" },
  { "nvim-neotest/neotest-go" },
  { "nvim-neotest/neotest-python" },
  {
    "nvim-neotest/neotest",
    opts = { adapters = { "neotest-plenary", "neotest-go", "neotest-python" } },
  },
}
