function ApplyPureBlack()
  local groups = {
    "Normal", "NormalNC", "NormalFloat",
    "SignColumn", "EndOfBuffer",
    "LineNr", "CursorLineNr",
    "StatusLine", "StatusLineNC",
  }
  for _, group in ipairs(groups) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    local fg = (ok and hl.fg) or nil
    vim.api.nvim_set_hl(0, group, { fg = fg, bg = 0x000000 })
  end
end

return {
  -- Pure black dark theme (IBM Carbon inspired)
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.cmd.colorscheme("oxocarbon")
      ApplyPureBlack()
    end,
  },
  -- Pure white light theme
  {
    "mcchrish/zenbones.nvim",
    lazy = false,
    priority = 999,
    dependencies = { "rktjmp/lush.nvim" },
  },
}
