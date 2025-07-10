require("config.lazy")
require("config.autocmds")
require("keymaps")

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- Override for python files only
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.expandtab = true     -- spaces, no tabs
    vim.bo.shiftwidth = 4       -- 4 spaces for indent
    vim.bo.tabstop = 4          -- tab = 4 spaces wide
  end,
})

-- column bar at 80
vim.opt.colorcolumn = "80"

-- linenumber
vim.opt.number = true


vim.opt.termguicolors = true

