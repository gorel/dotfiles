return {
  "monaqa/dial.nvim",
  keys = {
    {
      "n",
      "<C-a>",
      function()
        require("dial").inc_normal()
      end,
      desc = "Increment",
    },
    {
      "n",
      "<C-x>",
      function()
        require("dial").dec_normal()
      end,
      desc = "Decrement",
    },
    {
      "v",
      "<C-a>",
      function()
        require("dial").inc_visual()
      end,
      desc = "Increment",
    },
    {
      "v",
      "<C-x>",
      function()
        require("dial").dec_visual()
      end,
      desc = "Decrement",
    },
    {
      "v",
      "g<C-a>",
      function()
        require("dial").inc_gvisual()
      end,
      desc = "Increment",
    },
    {
      "v",
      "g<C-x>",
      function()
        require("dial").dec_gvisual()
      end,
      desc = "Decrement",
    },
  },
}
