return{
"nvim-tree/nvim-tree.lua",
dependencies = {
"nvim-tree/nvim-web-devicons"
},
config = function()
local nvimtree = require("nvim-tree")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
vim.g.nvim_tree_hide_dotfiles = 0
nvimtree.setup({
  sort_by = "case_sensitive",
  view = {
    width = 20,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})
-- set keymaps
--
end
}
