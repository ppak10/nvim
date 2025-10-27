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

require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      visible = true,         -- show hidden files by default
      hide_dotfiles = true,   -- or false, depending on your preference
      hide_gitignored = true,
    },
    follow_current_file = {
      enabled = true,         -- auto-focus file in tree
    },
  },
  window = {
    width = 30,
    mappings = {
      ["<space>"] = "none",  -- override default space action
    },
  },
  sort_case_insensitive = false,
  enable_git_status = true,
  enable_diagnostics = true,
})

require('telescope').setup({
  defaults = {
    hidden = true,
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
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
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
vim.opt.relativenumber = true

vim.opt.termguicolors = true

