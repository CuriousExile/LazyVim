return {
  desc = "Snacks File Explorer",
  recommended = true,
  "folke/snacks.nvim",
  opts = { explorer = {} },
  keys = {
    {
      "<leader>fe",
      function()
        Snacks.explorer({ cwd = LazyVim.root() })
      end,
      desc = "[E]xplorer Snacks (root dir)",
    },
    {
      "<leader>fE",
      function()
        Snacks.explorer()
      end,
      desc = "[E]xplorer Snacks (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "[E]xplorer Snacks (root dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "[E]xplorer Snacks (cwd)", remap = true },
  },
}
