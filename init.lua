-- ============================================================================
-- Plugin Management
-- ============================================================================
require("config.lazy")
require("config.autocmds")
require("keymaps")

-- ============================================================================
-- Core Settings
-- ============================================================================
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autoread = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.termguicolors = true

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ============================================================================
-- Autocommands
-- ============================================================================

-- Autoreload for changes to files
vim.api.nvim_create_autocmd(
  { "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" },
  { command = "if mode() != 'c' | checktime | endif", pattern = "*" }
)

-- Python-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})

-- ============================================================================
-- Plugin Configuration
-- ============================================================================

-- Neo-tree
require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = true,
      hide_gitignored = true,
    },
    follow_current_file = {
      enabled = true,
    },
  },
  window = {
    width = 30,
    mappings = {
      ["<space>"] = "none",
    },
  },
  sort_case_insensitive = false,
  enable_git_status = true,
  enable_diagnostics = true,
})

-- Telescope
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
