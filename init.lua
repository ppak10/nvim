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
-- vim.opt.termguicolors = true

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

require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      "node_modules/.*",
      "__pycache__/.*",
      "%.py[cod]",
      "%.venv/.*",
      "venv/.*",
      "%.git/.*",
      "%.DS_Store",
      "%.vscode/.*",
      "%.idea/.*",
      "build/.*",
      "dist/.*",
      "target/.*",
      "%.log",
      "logs/.*",
      "tmp/.*",
      "%.tmp",
      "vendor/.*",
      "%.coverage",
      "%.pytest_cache/.*",
      "%.mypy_cache/.*",
      "%.tox/.*",
      "*%.swp",
      "*%.swo",
      "*~"
    }
  }
})

-- require("lualine").setup({
--     -- ... other config
--     options = {
--         theme = "auto", -- "auto" will set the theme dynamically based on the colorscheme
--     },
--     -- ... other config
-- })

require("cyberdream").setup({
    -- Set light or dark variant
    variant = "auto", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`

    -- Enable transparent background
    transparent = true,

    -- Reduce the overall saturation of colours for a more muted look
    saturation = 1, -- accepts a value between 0 and 1. 0 will be fully desaturated (greyscale) and 1 will be the full color (default)

    -- Enable italics comments
    italic_comments = false,

    -- Replace all fillchars with ' ' for the ultimate clean look
    hide_fillchars = false,

    -- Apply a modern borderless look to pickers like Telescope, Snacks Picker & Fzf-Lua
    borderless_pickers = false,

    -- Set terminal colors used in `:terminal`
    terminal_colors = true,
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

