return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")

-- General LSP settings (from the second configuration)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
		local flags = {
      debounce_text_changes = 150,
    }

    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local opts = { noremap=true, silent=true, virtual_text = false,
        signs = false }
      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      -- Add more mappings as needed
    end

    -- Bash language server
    lspconfig.bashls.setup{}

    -- YAML language server (based on your previous config)
    lspconfig.yamlls.setup{}

    -- HTML language server
    lspconfig.html.setup {
      cmd = { "vscode-html-language-server", "--stdio" },
      filetypes = { "html", "htm" },
      init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = { css = true, javascript = true }
      }
    }

    -- Ruby language server (solargraph)
    lspconfig.solargraph.setup{
      cmd = { "solargraph", "stdio" },
      filetypes = { "ruby" },
	init_options = {
  formatting = true
},
settings = {
    solargraph = {
      diagnostics = true
    }
  },
  on_attach = function(client, bufnr)
    -- Disable diagnostics for this client
    client.server_capabilities.diagnosticProvider = false
    
    -- Call your original on_attach function if it exists
    if on_attach then
      on_attach(client, bufnr)
    end
  end
}
	-- Rust 
lspconfig.rust_analyzer.setup{
      settings = {
        ["rust-analyzer"] = {
          procMacro = { enable = true },
          cargo = { allFeatures = true },
          checkOnSave = {
            command = "clippy",
            extraArgs = { "--no-deps" },
          },
        },
      },
      capabilities = capabilities,
      flags = flags,
      on_attach = on_attach,
    }

    lspconfig.gopls.setup{
      settings = {
        gopls = {
          gofumpt = true,
          -- Include other gopls specific settings here
        },
      },
      capabilities = capabilities,
      flags = flags,
      on_attach = on_attach,
    }

		local pid = vim.fn.getpid()
lspconfig.omnisharp.setup{
  cmd = { "/usr/local/bin/omnisharp/omnisharp", "--languageserver", "--hostPID", tostring(pid) },
  filetypes = { "cs", "csx", "cshtml", "razor" },
  -- Assuming root_dir and a correct settings block are needed; adjust as necessary
  --root_dir = function(startpath)
      -- Ensure the implementation for `search_ancestors` is defined and available
--      return M.search_ancestors(startpath, matcher) 
  --end,
  -- Adjust the settings to what's appropriate for Omnisharp, if needed
  settings = {
    -- Example settings; replace with actual needed settings for Omnisharp
  },
  on_attach = on_attach,
  -- Other configurations as needed
}

    -- You can add more language servers as needed
  end,
}

