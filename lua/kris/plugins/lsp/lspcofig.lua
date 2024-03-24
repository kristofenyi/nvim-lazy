return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")

    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local opts = { noremap=true, silent=true }
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
      cmd = { "solargraph", "stdio" }
      filetypes = { "ruby" }
	init_options = {
  formatting = true
}
root_dir = function(startpath)
    return M.search_ancestors(startpath, matcher)
  end
      settings = {
        solargraph = {
          diagnostics = true
        }
      },
      on_attach = on_attach
    }

    -- C# language server (omnisharp)
    local pid = vim.fn.getpid()
    lspconfig.omnisharp.setup{
      cmd = { "/usr/local/bin/omnisharp/omnisharp", "--languageserver", "--hostPID", tostring(pid) },
      filetypes = { "cs", "csx", "cshtml", "razor" },
    }

    -- You can add more language servers as needed
  end,
}

