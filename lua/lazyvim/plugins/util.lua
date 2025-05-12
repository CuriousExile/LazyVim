-- Terminal Mappings
local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

return {

  -- Snacks utils
  {
    "snacks.nvim",
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      terminal = {
        win = {
          keys = {
            nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
            nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
            nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
            nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>..",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>.s",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>.p", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },
    },
  },

  -- Session management. This saves your session in the background,
  -- keeping track of open buffers, window arrangement, and more.
  -- You can restore sessions when returning through the dashboard.
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>ps", function() require("persistence").load() end, desc = "[P]ersistence Restore [S]ession" },
      { "<leader>pS", function() require("persistence").select() end,desc = "[P]ersistence Select [S]ession" },
      { "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "[P]ersistence restore [L]ast session" },
      { "<leader>pd", function() require("persistence").stop() end, desc = "[P]ersistence [D]elete current session" },
    },
  },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },
}
