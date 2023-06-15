local M = {}

local servers = {
  gopls = {
    gofumpt = true,
  },
  html = {},
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  pyright = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = {
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
      },
    },
  },
  vimls = {},
}

-- local lsp_signature = require "lsp_signature"
-- lsp_signature.setup {
--   bind = true,
--   handler_opts = {
--     border = "rounded",
--   },
-- }

local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  require("config.lsp.keymaps").setup(client, bufnr)

  -- Configure highlighting
  require("config.lsp.highlighter").setup(client)

  -- Configure formatting
  require("config.lsp.null-ls.formatters").setup(client, bufnr)

  -- Configure for Typescript
  if client.name == "tsserver" then
    require("config.lsp.ts-utils").setup(client)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if PLUGINS.nvim_cmp.enabled then
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- for nvim-cmp
end

local opts = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- Setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup()
  require("config.lsp.null-ls").setup(opts)

  -- Installer
  require("config.lsp.installer").setup(servers, opts)
end

return M