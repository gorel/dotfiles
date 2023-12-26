local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = { "lua", "vim" },

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
      -- `false` will disable the whole extension
      enable = true,
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },

    -- indent = { enable = true },

    -- vim-matchup
    matchup = {
      enable = true,
    },

    -- nvim-treesitter-textobjects
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },

      swap = {
        enable = true,
        swap_next = {
          ["<leader>cx"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>cX"] = "@parameter.inner",
        },
      },

      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
            ["<leader>nf"] = "@function.outer",
            ["<leader>nc"] = "@class.outer",
            ["<leader>ni"] = "@conditional.outer",
            ["<leader>nl"] = "@loop.outer",
         },
         goto_next_end = {
            ["<leader>nF"] = "@function.outer",
            ["<leader>nC"] = "@class.outer",
            ["<leader>nI"] = "@conditional.outer",
            ["<leader>nL"] = "@loop.outer",
         },
         goto_previous_start = {
            ["<leader>pf"] = "@function.outer",
            ["<leader>pc"] = "@class.outer",
            ["<leader>pi"] = "@conditional.outer",
            ["<leader>pl"] = "@loop.outer",
         },
         goto_previous_end = {
            ["<leader>pF"] = "@function.outer",
            ["<leader>pC"] = "@class.outer",
            ["<leader>pI"] = "@conditional.outer",
            ["<leader>pL"] = "@loop.outer",
         },
      },

      lsp_interop = {
        enable = true,
        border = "none",
        peek_definition_code = {
          ["<leader>cf"] = "@function.outer",
          ["<leader>cF"] = "@class.outer",
        },
      },

    },

    -- endwise
    endwise = {
      enable = true,
    },

    -- autotag
    autotag = {
      enable = true,
    },
  }

  local has_commentstring, commentstring = pcall(require, "ts_context_commentstring")
  if has_commentstring then
    commentstring.setup {}
    vim.g.skip_ts_context_commentstring_module = true
  end
end

return M
