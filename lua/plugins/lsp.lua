return {
  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Setup Mason
      require("mason").setup()

      -- Setup Mason LSPConfig
      require("mason-lspconfig").setup({
        ensure_installed = {
          "basedpyright",
          "ltex", -- grammar/spell checker
        },
      })

      -- Modern Neovim 0.11+ LSP setup
      vim.lsp.config("basedpyright", {})

      -- Optional: LaTeX / Markdown grammar checker (uncomment if needed)
      -- vim.lsp.config("ltex", {
      --   settings = {
      --     ltex = {
      --       language = "en-US",
      --       enabled = { "latex", "tex", "markdown" },
      --     },
      --   },
      --   filetypes = { "tex", "latex", "markdown", "bib" },
      -- })
    end,
  },

  -- Autocompletion Engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}

