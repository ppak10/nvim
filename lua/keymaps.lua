-- Keybinding: <leader>tt toggles between oxocarbon (black) and zenbones (white)

function ToggleLightDark()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.cmd.colorscheme("zenbones")
  else
    vim.o.background = "dark"
    vim.cmd.colorscheme("oxocarbon")
    ApplyPureBlack()
  end
end

vim.keymap.set("n", "<leader>tt", ToggleLightDark, { desc = "Toggle Light/Dark" })

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

vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

--neo-tree 
vim.keymap.set('n', '<C-n>', '<cmd>Neotree toggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ft', '<cmd>Neotree focus filesystem left<CR>', { noremap = true, silent = true })

-- Require ToggleTerm and set keybinding
local Terminal = require("toggleterm.terminal").Terminal
local float_term = Terminal:new({ direction = "float", hidden = true })

vim.keymap.set("n", "<leader>tf", function()
  float_term:toggle()
end, { desc = "Toggle floating terminal" })

local generative_ai_term = Terminal:new({ direction = "float", hidden = true, float_opts = {border = "double"} })
vim.keymap.set("n", "<leader>tg", function()
  generative_ai_term:toggle()
end, { desc = "Toggle generative ai terminal (you still need to run it)"})

-- Horizontal terminal
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Horizontal terminal" })

-- Vertical terminal
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Vertical terminal" })

vim.keymap.set('t', 'jj', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Reload Configs
vim.keymap.set("n", "<leader>rr", function()
  for name,_ in pairs(package.loaded) do
    if name:match("^keymaps") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.fn.stdpath("config") .. "/init.lua")
  print("✅ Reloaded all configs")
end, { desc = "Reload everything" })

