vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Explorer' })

require("nvim-tree").setup({
  view = { adaptive_size = true, float = { enable = true } }
})
