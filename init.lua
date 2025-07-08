require("config.lazy")

vim.keymap.set("i", "jj", "<ESC>")

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- Override for python files only
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.expandtab = true     -- spaces, no tabs
    vim.bo.shiftwidth = 4       -- 4 spaces for indent
    vim.bo.tabstop = 4          -- tab = 4 spaces wide
  end,
})

vim.opt.colorcolumn = "80"

vim.opt.number = true

-- Simple toggle between day and night
function ToggleTokyonightLightDark()
  local current = vim.g.colors_name

  if current == "tokyonight-day" then
    vim.cmd("colorscheme tokyonight-night")
  else
    vim.cmd("colorscheme tokyonight-day")
  end
end

-- Keybinding: <leader>td toggles light/dark
vim.keymap.set("n", "<leader>td", ToggleTokyonightLightDark, { desc = "Toggle TokyoNight Light/Dark" })


vim.opt.termguicolors = true

