return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = true,
        hide_gitignored = true,
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root(), position = "left" })
      end,
      desc = "Explorer NeoTree (Root Dir)",
      remap = true,
    },
    {
      "<leader>E",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd(), position = "left" })
      end,
      desc = "Explorer NeoTree (cwd)",
      remap = true,
    },
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root(), position = "float" })
      end,
      desc = "Explorer NeoTree (Root Dir)",
      remap = true,
    },
    {
      "<leader>fE",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd(), position = "float" })
      end,
      desc = "Explorer NeoTree (cwd)",
      remap = true,
    },
  },
}
