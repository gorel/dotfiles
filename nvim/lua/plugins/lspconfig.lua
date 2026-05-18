return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                fieldalignment = false,
                ST1000 = false,
              },
              goimportsLocalPrefixes = "github.com/twilio-internal,stytch-domain,ciam",
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        gh_actions_ls = {},
      },
    },
  },
}
