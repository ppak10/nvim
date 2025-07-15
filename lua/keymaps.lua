-- Keybinding: <leader>td toggles light/dark

-- vim.cmd.colorscheme("cyberdream")
-- vim.api.nvim_set_keymap("n", "<leader>tt", ":CyberdreamToggleMode<CR>", { noremap = true, silent = true })

-- Simple toggle between day and night
vim.cmd[[colorscheme tokyonight-day]]

function ToggleTokyonightLightDark()
  local current = vim.g.colors_name

  if current == "tokyonight-day" then
    vim.cmd("colorscheme tokyonight-storm")
    require('lualine').setup {
      options = { theme = 'tokyonight-storm' }
    }
  else
    vim.cmd("colorscheme tokyonight-day")
    require('lualine').setup {
      options = { theme = 'tokyonight-day' }
    }
  end
end

vim.keymap.set("n", "<leader>tt", ToggleTokyonightLightDark, { desc = "Toggle Light/Dark" })

vim.keymap.set("i", "jj", "<ESC>")

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

--nvim-lspconfig
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

-- Reload Configs
vim.keymap.set("n", "<leader>rr", function()
  vim.cmd("luafile $MYVIMRC")
  print("✅ Reloaded init.lua")
end, { desc = "Reload Neovim config" })

