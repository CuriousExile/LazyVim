if lazyvim_docs then
  -- In case you don't want to use `:LazyExtras`,
  -- then you need to set the option below.
  vim.g.lazyvim_picker = "snacks"
end

---@module 'snacks'

---@type LazyPicker
local picker = {
  name = "snacks",
  commands = {
    files = "files",
    live_grep = "grep",
    oldfiles = "recent",
  },

  ---@param source string
  ---@param opts? snacks.picker.Config
  open = function(source, opts)
    return Snacks.picker.pick(source, opts)
  end,
}
if not LazyVim.pick.register(picker) then
  return {}
end

return {
  desc = "Fast and modern file picker",
  recommended = true,
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<a-c>"] = {
                "toggle_cwd",
                mode = { "n", "i" },
              },
            },
          },
        },
        actions = {
          ---@param p snacks.Picker
          toggle_cwd = function(p)
            local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
            local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
            local current = p:cwd()
            p:set_cwd(current == root and cwd or root)
            p:find()
          end,
        },
      },
    },
    -- stylua: ignore
    keys = {
      -- { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      -- { "<leader>/", LazyVim.pick("grep"), desc = "Grep (Root Dir)" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "[:] Command History" },
      { "<leader><space>", LazyVim.pick("files"), desc = "[ ] Find Files (Root Dir)" },
      -- { "<leader>n", function() Snacks.picker.notifications() end, desc = "[N]otification History" },
      -- find
      { "<leader>sb", function() Snacks.picker.buffers() end, desc = "[S]earch [B]uffers" },
      -- { "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers (all)" },
      -- { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
      -- { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      -- { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>sG", function() Snacks.picker.git_files() end, desc = "[S]earch [G]it Files" },
      -- { "<leader>fr", LazyVim.pick("oldfiles"), desc = "Recent" },
      -- { "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "Recent (cwd)" },
      { "<leader>sp", function() Snacks.picker.projects() end, desc = "[S]earch [P]rojects" },
      -- git
      { "<leader>gH", function() Snacks.picker.git_diff() end, desc = "[G]it Diff Picker ([H]unks)" },
      { "<leader>sH", function() Snacks.picker.git_diff() end, desc = "[S]earch Diff Picker ([H]unks)" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "[G]it [S]tatus" },
      { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "[G]it [S]tash" },
      -- Grep
      -- { "<leader>sb", function() Snacks.picker.lines() end, desc = "[S]earch [B]uffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "[S]earch Grep [B]uffers (Open)" },
      { "<leader>sg", LazyVim.pick("live_grep"), desc = "[S]earch [G]rep (Root Dir)" },
      { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "[S]earch [G]rep (cwd)" },
      -- { "<leader>sp", function() Snacks.picker.lazy() end, desc = "[S]earch [P]lugin Specs" },
      { "<leader>sw", LazyVim.pick("grep_word"), desc = "[S]earch · [W]ord (Root Dir)", mode = { "n", "x" } },
      { "<leader>sW", LazyVim.pick("grep_word", { root = false }), desc = "[S]earch [W]ord (cwd)", mode = { "n", "x" } },
      { "<leader>s\"", function() Snacks.picker.registers() end, desc = "[S]earch [\"] Registers" },
      { "<leader>s/", function() Snacks.picker.search_history() end, desc = "[S]earch [/] History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "[S]earch [A]utocmds" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "[S]earch [C]ommand History" },
      -- { "<leader>sC", function() Snacks.picker.commands() end, desc = "[S]earch [C]ommands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[S]earch [D]iagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "[S]earch Buffer [D]iagnostics" },
      -- { "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp Pages" },
      -- { "<leader>sH", function() Snacks.picker.highlights() end, desc = "[S]earch [H]ighlights" },
      -- { "<leader>si", function() Snacks.picker.icons() end, desc = "[S]earch [I]cons" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "[S]earch [J]umps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
      -- { "<leader>sl", function() Snacks.picker.loclist() end, desc = "[S]earch [L]ocation List" },
      -- { "<leader>sM", function() Snacks.picker.man() end, desc = "[S]earch [M]an Pages" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "[S]earch [M]arks" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "[S]earch [R]esume" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "[S]earch [Q]uickfix List" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "[S]earch [U]ndotree" },
      -- ui
      { "<leader>sC", function() Snacks.picker.colorschemes() end, desc = "[S]earch [C]olorschema" },
    },
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      if LazyVim.has("trouble.nvim") then
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = {
              trouble_open = function(...)
                return require("trouble.sources.snacks").actions.trouble_open.action(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-t>"] = {
                    "trouble_open",
                    mode = { "n", "i" },
                  },
                },
              },
            },
          },
        })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "[G]oto [D]efinition", has = "definition" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "[G]oto [R]eferences" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "[G]oto [I]mplementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "[S]earch [L]]SP Symbols", has = "documentSymbol" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "[S]earch [L]SP Workspace Symbols", has = "workspace/symbols" },
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "[S]earch [T]odo and other" },
      { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "[S]earch [T]odo/Fix/Fixme" },
    },
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      table.insert(opts.dashboard.preset.keys, 3, {
        icon = " ",
        key = "p",
        desc = "Projects",
        action = ":lua Snacks.picker.projects()",
      })
    end,
  },
  {
    "goolord/alpha-nvim",
    optional = true,
    opts = function(_, dashboard)
      local button = dashboard.button("p", " " .. " Projects", [[<cmd> lua Snacks.picker.projects() <cr>]])
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
      table.insert(dashboard.section.buttons.val, 4, button)
    end,
  },
  {
    "echasnovski/mini.starter",
    optional = true,
    opts = function(_, opts)
      local items = {
        {
          name = "Projects",
          action = [[lua Snacks.picker.projects()]],
          section = string.rep(" ", 22) .. "Telescope",
        },
      }
      vim.list_extend(opts.items, items)
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    optional = true,
    opts = function(_, opts)
      if not vim.tbl_get(opts, "config", "center") then
        return
      end
      local projects = {
        action = "lua Snacks.picker.projects()",
        desc = " Projects",
        icon = " ",
        key = "p",
      }

      projects.desc = projects.desc .. string.rep(" ", 43 - #projects.desc)
      projects.key_format = "  %s"

      table.insert(opts.config.center, 3, projects)
    end,
  },
  {
    "folke/flash.nvim",
    optional = true,
    specs = {
      {
        "folke/snacks.nvim",
        opts = {
          picker = {
            win = {
              input = {
                keys = {
                  ["<a-s>"] = { "flash", mode = { "n", "i" } },
                  ["s"] = { "flash" },
                },
              },
            },
            actions = {
              flash = function(picker)
                require("flash").jump({
                  pattern = "^",
                  label = { after = { 0, 0 } },
                  search = {
                    mode = "search",
                    exclude = {
                      function(win)
                        return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                      end,
                    },
                  },
                  action = function(match)
                    local idx = picker.list:row2idx(match.pos[1])
                    picker.list:_move(idx, true, true)
                  end,
                })
              end,
            },
          },
        },
      },
    },
  },
}
