require("config.lazy")

vim.keymap.set("i", "jj", "<ESC>")

vim.opt.colorcolumn = "80"

vim.opt.number = true

vim.cmd([[colorscheme tokyonight]])

vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]])
vim.opt.termguicolors = true

