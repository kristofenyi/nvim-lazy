return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "bashls",      -- Bash language server
        "yamlls",      -- YAML language server
        "omnisharp",   -- C# language server
        "solargraph",  -- Ruby language server
        "tsserver",    -- TypeScript language server (kept from your original config)
        "html",        -- HTML language server (kept from your original config)
        "cssls",       -- CSS language server (kept from your original config)
        "lua_ls",      -- Lua language server (kept from your original config)
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "eslint",      -- JavaScript linter
        "prettier",    -- Prettier formatter (kept from your original config)
        "stylua",      -- Lua formatter (kept from your original config)
        "eslint_d",    -- JS linter (kept from your original config)
      },
    })
  end,
}
