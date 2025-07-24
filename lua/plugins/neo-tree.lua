return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  opts = {
    filesystem = {
      components = {
        size = function(config, node, _)
          local stats = vim.loop.fs_stat(node.path)
          if not stats or stats.type ~= "file" then return "" end
          local size = math.ceil(stats.size / 1024)
          return string.format("%d KB", size)
        end,
      },
      renderers = {
        file = {
          { "icon" },
          { "name", use_git_status_colors = true },
          { "size", right_padding = 1 },
        },
        directory = {
          { "icon" },
          { "name" },
        },
      },
    },
  },
}

