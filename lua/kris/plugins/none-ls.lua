return{
'nvimtools/none-ls.nvim', -- none-ls is an active community fork of null-ls
		opts = function(_, opts)
			local nls = require('null-ls')
			opts.sources = vim.list_extend(opts.sources or {}, {
				nls.builtins.code_actions.gomodifytags,
				nls.builtins.code_actions.impl,
			})
			return opts
	end,
}
