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
      options = {
        theme = 'tokyostorm'
      }
    }
  else
    vim.cmd("colorscheme tokyonight-day")
    require('lualine').setup {
      options = {
        theme = 'tokyoday'
      }
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

