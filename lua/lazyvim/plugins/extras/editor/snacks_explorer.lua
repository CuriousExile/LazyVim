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
      desc = "[F]ile [E]xplorer (root)",
    },
    {
      "<leader>fE",
      function()
        Snacks.explorer()
      end,
      desc = "[F]ile [E]xplorer (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "[F]ile [E]xplorer (root)", remap = true },
    { "<leader>E", "<leader>fE", desc = "[F]ile [E]xplorer (cwd)", remap = true },
  },
}
