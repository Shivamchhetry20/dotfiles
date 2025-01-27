return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    event = "VeryLazy",
    version = "*", -- Use the latest version
    lazy = true,
    ft = "markdown", -- Load for markdown files
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for some features
      "hrsh7th/nvim-cmp", -- Completion engine
    },
    opts = {
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {
          topic = function()
            return "programming" -- Auto-set based on folder
          end,
        },
      },
      workspaces = {
        {
          name = "personal", -- Your vault name
          path = "~/Documents/Obsidian", -- Path to your Obsidian vault
          Override = {
            notes_subdir = "topics",
          },
        },
      },
      note_id_func = function(title)
        -- Use the note's title as the filename (lowercase, hyphens for spaces)
        if title ~= nil then
          return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          return tostring(os.time()) -- Fallback to timestamp if no title
        end
      end,
      -- Disable prepending UUIDs
      prepend_note_id = false,
      -- Optional: Customize keymaps, templates, etc.
      completion = {
        nvim_cmp = false, -- MUST BE ENABLED
      },
    },
  },

  {
    "MeanderingProgrammer/markdown.nvim",
    main = "render-markdown",
    opts = {},
    name = "render-markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  --   {
  --     "iamcco/markdown-preview.nvim",
  --     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --     ft = { "markdown" },
  --     build = function() vim.fn["mkdp#util#install"]() end,
  --   },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn.system({ "cmd.exe", "/C", "cd app && npm install" })
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        auto_restore = false,
        suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
      })

      -- Key mappings for session commands
      vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
      vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto-session root dir" })
    end,
  },

  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
    keys = {},
  },

  -- buffer line
  --   {
  --     "akinsho/bufferline.nvim",
  --     dependencies = { "nvim-tree/nvim-web-devicons" },
  --     config = function()
  --         require("bufferline").setup({
  --             highlights = {
  --                 fill = {
  --                     bg = "#1e222a", -- Background of the bufferline
  --                 },
  --                 background = {
  --                     fg = "#6c7086",
  --                     bg = "#1e222a",
  --                 },
  --                 buffer_selected = {
  --                     fg = "#ffffff", -- Selected buffer foreground
  --                     bg = "#3c3836", -- Selected buffer background
  --                     bold = true,
  --                 },
  --                 separator = {
  --                     fg = "#282c34",
  --                     bg = "#1e222a",
  --                 },
  --                 separator_selected = {
  --                     fg = "#3c3836",
  --                     bg = "#1e222a",
  --                 },
  --                 separator_visible = {
  --                     fg = "#282c34",
  --                     bg = "#1e222a",
  --                 },
  --             },
  --         })
  --     end,
  --   },

  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        highlights = {
          -- Background color of the bufferline (dark background)
          fill = {
            bg = "#282828", -- Gruvbox dark background color
          },
          -- Normal state buffer background and foreground
          background = {
            fg = "#282828", -- Gruvbox light gray text
            bg = "#282828", -- Gruvbox dark background color
          },
          -- Selected buffer highlight
          buffer_selected = {
            fg = "#d79921", -- Gruvbox yellow for selected buffer text
            bg = "#3c3836", -- Gruvbox dark gray background for selected buffer
            bold = true, -- Bold selected buffer text
          },
          -- Separator between buffers
          separator = {
            fg = "#3c3836", -- Gruvbox dark gray separator color
            bg = "#282828", -- Gruvbox dark background color
          },
          separator_selected = {
            fg = "#d79921", -- Gruvbox yellow separator when buffer is selected
            bg = "#3c3836", -- Gruvbox dark gray background when selected
          },
          separator_visible = {
            fg = "#3c3836", -- Gruvbox dark gray separator when buffer is visible
            bg = "#282828", -- Gruvbox dark background color
          },
        },
      })
    end,
  },
  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
  {
    "tpope/vim-dadbod",
    lazy = true, -- Load only when required
    cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = {
      "kristijanhusak/vim-dadbod-ui", -- UI for Dadbod
      "kristijanhusak/vim-dadbod-completion", -- Completion support
    },
    config = function()
      -- Optional: Customize the settings for the UI or mappings
      vim.g.db_ui_save_location = "~/.config/nvim/db_ui" -- Where to save DB UI connections
    end,
  },

  -- Automatically load Dadbod completion in SQL files
  {
    "kristijanhusak/vim-dadbod-completion",
    lazy = true,
    ft = { "sql", "mysql", "plsql" }, -- Load completion for SQL-related files
    config = function()
      -- Enable completion using nvim-cmp
      local cmp = require("cmp")
      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = cmp.config.sources({
          { name = "vim-dadbod-completion" },
          { name = "obsidian" },
        }),
      })
    end,
  },

  -- statusline
  -- {
  -- 	"nvim-lualine/lualine.nvim",
  -- 	opts = function(_, opts)
  -- 		local LazyVim = require("lazyvim.util")
  -- 		opts.sections.lualine_c[4] = {
  -- 			LazyVim.lualine.pretty_path({
  -- 				length = 0,
  -- 				relative = "cwd",
  -- 				modified_hl = "MatchParen",
  -- 				directory_hl = "",
  -- 				filename_hl = "Bold",
  -- 				modified_sign = "✎",
  -- 				readonly_icon = " 󰌾 ",

  -- 				padding = { left = 5, right = 5 },
  -- 			}),
  -- 		}
  -- 		opts.options = {
  -- 			theme = "horizon",
  --             section_separators = "|",
  --             component_separators = { left = "", right = "" },

  -- 			globalstatus = true,
  -- 		}
  -- 		-- Add padding here
  -- 		opts.sections = vim.tbl_deep_extend("force", opts.sections, {
  -- 			lualine_a = { {
  --                 "mode",

  --                 bold = true, padding = { left = 3, right = 3 }, separator = {left = "", right = ""},gui = "bold"}},
  --                 lualine_b = { { "branch", bold=true, padding = { left = 3, right = 3 } , gui = "bold" }},
  --                 lualine_c = { { "filename", bold = true, padding = { left = 3, right = 3 }, gui = "bold" }},
  -- 		})
  -- 		opts.sections.lualine_c = {
  -- 			{
  -- 				"filename",
  -- 				icon = "🗃️",
  -- 				color = { bg = "#87A2FF",fg="#000000" },
  --                 padding = {left=3, right=3},
  --                 bold=true,

  --                 separator = { left = "", right = ""  },
  --                 gui = "bold"
  -- 			},
  -- 		}
  -- 		opts.sections.lualine_b = {
  -- 			{
  -- 				"branch",
  -- 				color = { bg = "#504945", fg = "#ebdbb2" },
  -- 				padding = {left = 3, right=3},
  --                 separator = { left = "", right = "" },
  --                 gui = "bold"
  -- 			}, -- Custom background
  -- 		}

  --     end,
  -- },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require("lualine")
      local lazy_status = require("lazy.status") -- to configure lazy pending updates count

      local colors = {
        blue = "#65D1FF",
        green = "#3EFFDC",
        violet = "#FF61EF",
        yellow = "#FFDA7B",
        red = "#FF4A4A",
        fg = "#c3ccdc",
        bg = "#0a0611",
        inactive_bg = "#2c3043",
      }

      local my_lualine_theme = {
        normal = {
          a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        insert = {
          a = { bg = colors.green, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        visual = {
          a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        command = {
          a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        replace = {
          a = { bg = colors.red, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        inactive = {
          a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
          b = { bg = colors.inactive_bg, fg = colors.semilightgray },
          c = { bg = colors.inactive_bg, fg = colors.semilightgray },
        },
      }
      -- configure lualine with modified theme
      lualine.setup({
        options = {
          theme = my_lualine_theme,
        },
        sections = {
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
            },
            { "encoding" },
            { "fileformat" },
            { "filetype" },
          },
        },
      })
    end,
  },
  {
    "github/copilot.vim",
  },

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   config = function()
  --     local lualine = require("lualine")
  --     local lazy_status = require("lazy.status")
  --
  --     -- Gruvbox Color Palette (adjusted to match standard Gruvbox)
  --     local colors = {
  --       black = "#282828", -- Default background
  --       gray = "#3c3836", -- Slightly lighter
  --       white = "#ffffed", -- Foreground
  --       yellow = "#d79921",
  --       blue = "#83a598",
  --       green = "#8ec07c",
  --       orange = "#fe8019",
  --       red = "#fb4934",
  --       violet = "#d3869b",
  --       inactive_bg = "#504945", -- For inactive windows
  --     }
  --
  --     local my_lualine_theme = {
  --       normal = {
  --         a = { bg = colors.blue, fg = colors.black, gui = "bold" },
  --         b = { bg = colors.gray, fg = colors.white },
  --         c = { bg = colors.black, fg = colors.white }, -- Matches editor bg
  --       },
  --       insert = {
  --         a = { bg = colors.green, fg = colors.black, gui = "bold" },
  --         b = { bg = colors.gray, fg = colors.white },
  --         c = { bg = colors.black, fg = colors.white },
  --       },
  --       visual = {
  --         a = { bg = colors.violet, fg = colors.black, gui = "bold" },
  --         b = { bg = colors.gray, fg = colors.white },
  --         c = { bg = colors.black, fg = colors.white },
  --       },
  --       command = {
  --         a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
  --         b = { bg = colors.gray, fg = colors.white },
  --         c = { bg = colors.black, fg = colors.white },
  --       },
  --       replace = {
  --         a = { bg = colors.red, fg = colors.black, gui = "bold" },
  --         b = { bg = colors.gray, fg = colors.white },
  --         c = { bg = colors.black, fg = colors.white },
  --       },
  --       inactive = {
  --         a = { bg = colors.inactive_bg, fg = colors.gray, gui = "bold" },
  --         b = { bg = colors.inactive_bg, fg = colors.gray },
  --         c = { bg = colors.inactive_bg, fg = colors.gray },
  --       },
  --     }
  --
  --     lualine.setup({
  --       options = {
  --         theme = my_lualine_theme,
  --         component_separators = { left = "│", right = "│" }, -- Add subtle separators
  --         section_separators = { left = "", right = "" },
  --       },
  --       sections = {
  --         lualine_x = {
  --           {
  --             function()
  --               return string.gsub(lazy_status.updates(), "%%", "%%%%")
  --             end,
  --             cond = lazy_status.has_updates,
  --             color = { fg = colors.orange },
  --           },
  --           { "encoding" },
  --           { "fileformat" },
  --           { "filetype" },
  --         },
  --       },
  --     })
  --   end,
  -- },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "pylint", "flake8", "mypy" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    "christoomey/vim-tmux-navigator", -- Plugin for maximizing and minimizing splits
    lazy = false,
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/Minimize a split" },
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "Navigate Left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "Navigate Down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "Navigate Up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate Right" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["a="] = {
                query = "@assignment.outer",
                desc = "Select outer part of an assignment",
              },
              ["i="] = {
                query = "@assignment.inner",
                desc = "Select inner part of an assignment",
              },
              ["l="] = {
                query = "@assignment.lhs",
                desc = "Select left hand side of an assignment",
              },
              ["r="] = {
                query = "@assignment.rhs",
                desc = "Select right hand side of an assignment",
              },

              -- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
              ["a:"] = {
                query = "@property.outer",
                desc = "Select outer part of an object property",
              },
              ["i:"] = {
                query = "@property.inner",
                desc = "Select inner part of an object property",
              },
              ["l:"] = {
                query = "@property.lhs",
                desc = "Select left part of an object property",
              },
              ["r:"] = {
                query = "@property.rhs",
                desc = "Select right part of an object property",
              },

              ["aa"] = {
                query = "@parameter.outer",
                desc = "Select outer part of a parameter/argument",
              },
              ["ia"] = {
                query = "@parameter.inner",
                desc = "Select inner part of a parameter/argument",
              },

              ["ai"] = {
                query = "@conditional.outer",
                desc = "Select outer part of a conditional",
              },
              ["ii"] = {
                query = "@conditional.inner",
                desc = "Select inner part of a conditional",
              },

              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

              ["af"] = {
                query = "@call.outer",
                desc = "Select outer part of a function call",
              },
              ["if"] = {
                query = "@call.inner",
                desc = "Select inner part of a function call",
              },

              ["am"] = {
                query = "@function.outer",
                desc = "Select outer part of a method/function definition",
              },
              ["im"] = {
                query = "@function.inner",
                desc = "Select inner part of a method/function definition",
              },

              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
              ["<leader>n:"] = "@property.outer", -- swap object property with next
              ["<leader>nm"] = "@function.outer", -- swap function with next
            },
            swap_previous = {
              ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
              ["<leader>p:"] = "@property.outer", -- swap object property with prev
              ["<leader>pm"] = "@function.outer", -- swap function with previous
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = { query = "@call.outer", desc = "Next function call start" },
              ["]m"] = {
                query = "@function.outer",
                desc = "Next method/function def start",
              },
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
              ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

              -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]F"] = { query = "@call.outer", desc = "Next function call end" },
              ["]M"] = {
                query = "@function.outer",
                desc = "Next method/function def end",
              },
              ["]C"] = { query = "@class.outer", desc = "Next class end" },
              ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
              ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
              ["[m"] = {
                query = "@function.outer",
                desc = "Prev method/function def start",
              },
              ["[c"] = { query = "@class.outer", desc = "Prev class start" },
              ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
              ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
              ["[M"] = {
                query = "@function.outer",
                desc = "Prev method/function def end",
              },
              ["[C"] = { query = "@class.outer", desc = "Prev class end" },
              ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
              ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
            },
          },
        },
      })

      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

      -- vim way: ; goes to the direction you were moving.
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
      -- Custom Keymaps
      vim.keymap.set(
        "n",
        "<leader>/",
        "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
        { noremap = true, silent = true }
      )
      vim.keymap.set(
        "v",
        "<leader>/",
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
    },
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        preset = {
          header = [[
  
                  ███████╗██╗  ██╗██╗██╗   ██╗ █████╗ ███╗   ███╗
                  ██╔════╝██║  ██║██║██║   ██║██╔══██╗████╗ ████║
                  ███████╗███████║██║██║   ██║███████║██╔████╔██║
                  ╚════██║██╔══██║██║╚██╗ ██╔╝██╔══██║██║╚██╔╝██║
                  ███████║██║  ██║██║ ╚████╔╝ ██║  ██║██║ ╚═╝ ██║
                  ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═╝  ╚═╝╚═╝     ╚═╝
  
                  ]],
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        },
      },
    },
    keys = {
      {
        "<leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>Z",
        function()
          Snacks.zen.zoom()
        end,
        desc = "Toggle Zoom",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
      {
        "<leader>n",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>bc",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>cR",
        function()
          Snacks.rename.rename_file()
        end,
        desc = "Rename File",
      },
      {
        "<leader>gB",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git Browse",
        mode = { "n", "v" },
      },
      {
        "<leader>gb",
        function()
          Snacks.git.blame_line()
        end,
        desc = "Git Blame Line",
      },
      {
        "<leader>gf",
        function()
          Snacks.lazygit.log_file()
        end,
        desc = "Lazygit Current File History",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>gl",
        function()
          Snacks.lazygit.log()
        end,
        desc = "Lazygit Log (cwd)",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<c-/>",
        function()
          Snacks.terminal()
        end,
        desc = "Toggle Terminal",
      },
      {
        "<c-_>",
        function()
          Snacks.terminal()
        end,
        desc = "which_key_ignore",
      },
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
        mode = { "n", "t" },
      },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {}, -- You can customize options here if needed
    config = function()
      local flash = require("flash")

      -- Example keymaps
      vim.keymap.set("n", "f", flash.jump, { desc = "Flash Jump" })
      vim.keymap.set("x", "f", flash.jump, { desc = "Flash Jump (visual mode)" })
      vim.keymap.set("o", "f", flash.jump, { desc = "Flash Jump (operator mode)" })

      -- Additional commands for treesitter and remote flashes
      vim.keymap.set("n", "S", flash.treesitter, { desc = "Flash Treesitter" })
      vim.keymap.set("n", "r", flash.remote, { desc = "Flash Remote" })
    end,
  },
}
