local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
-- 	vim.fn.system({
-- 		"git",
-- 		"clone",
-- 		"--filter=blob:none",
-- 		"https://github.com/folke/lazy.nvim.git",
-- 		"--branch=stable", -- latest stable release
-- 		lazypath,
-- 	})
-- end
-- vim.opt.rtp:prepend(lazypath)

-- require("lazy").setup({
-- 	spec = {
-- 		-- add LazyVim and import its plugins
-- 		{
-- 			"LazyVim/LazyVim",
-- 			import = "lazyvim.plugins",
-- 			opts = {
-- 				colorscheme = "gruvbox",
-- 				news = {
-- 					lazyvim = true,
-- 					neovim = true,
-- 				},
-- 			},
-- 		},
-- 		-- import any extras modules here
-- 		{ import = "lazyvim.plugins.extras.linting.eslint" },
-- 		{ import = "lazyvim.plugins.extras.formatting.prettier" },
-- 		{ import = "lazyvim.plugins.extras.lang.typescript" },
-- 		{ import = "lazyvim.plugins.extras.lang.json" },
-- 		-- { import = "lazyvim.plugins.extras.lang.markdown" },
-- 		{ import = "lazyvim.plugins.extras.lang.rust" },
-- 		{ import = "lazyvim.plugins.extras.lang.tailwind" },
-- 		-- { import = "lazyvim.plugins.extras.dap.core" },
-- 		-- { import = "lazyvim.plugins.extras.vscode" },
-- 		{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
-- 		-- { import = "lazyvim.plugins.extras.test.core" },
-- 		-- { import = "lazyvim.plugins.extras.coding.yanky" },
-- 		-- { import = "lazyvim.plugins.extras.editor.mini-files" },
-- 		-- { import = "lazyvim.plugins.extras.util.project" },
-- 		{ import = "plugins" },
-- 	},
-- 	defaults = {
-- 		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
-- 		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
-- 		lazy = false,
-- 		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
-- 		-- have outdated releases, which may break your Neovim install.
-- 		version = false, -- always use the latest git commit
-- 		-- version = "*", -- try installing the latest stable version for plugins that support semver
-- 	},
-- 	dev = {
-- 		path = "~/.ghq/github.com",
-- 	},
-- 	checker = { enabled = true }, -- automatically check for plugin updates
-- 	performance = {
-- 		cache = {
-- 			enabled = true,
-- 			-- disable_events = {},
-- 		},
-- 		rtp = {
-- 			-- disable some rtp plugins
-- 			disabled_plugins = {
-- 				"gzip",
-- 				-- "matchit",
-- 				-- "matchparen",
-- 				"netrwPlugin",
-- 				"rplugin",
-- 				"tarPlugin",
-- 				"tohtml",
-- 				"tutor",
-- 				"zipPlugin",
-- 			},
-- 		},
-- 	},
-- 	ui = {
-- 		custom_keys = {
-- 			["<localleader>d"] = function(plugin)
-- 				dd(plugin)
-- 			end,
-- 		},
-- 	},
-- 	debug = false,
-- })
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- add LazyVim and import its plugins
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
			opts = {
				colorscheme = "gruvbox",
				news = {
					lazyvim = true,
					neovim = true,
				},
			},
		},

		{
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				local null_ls = require("null-ls")
				null_ls.setup({
					sources = {
						null_ls.builtins.formatting.black,
						null_ls.builtins.diagnostics.flake8,
					},
				})
			end,
		},
    {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",     -- Buffer completions
      "hrsh7th/cmp-path",       -- Path completions
      "hrsh7th/cmp-nvim-lsp",   -- LSP completions
      "L3MON4D3/LuaSnip",       -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- Snippet completions
      "rafamadriz/friendly-snippets", -- Snippet collection
       "epwalsh/cmp-obsidian",

    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "obsidian" ,
            option = {
                vaults = { "~/Documents/Obsidian" }, -- Path to your vault
            }
          },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        })
      })
    end
  },
		-- Add nvim-cmp for auto-completion
		-- {
		-- 	"hrsh7th/nvim-cmp",
        --     lazy=false,
        --     enabled = true,
        --     dependencies = {
        --         "hrsh7th/cmp-nvim-lsp",
        --         "hrsh7th/cmp-buffer",
        --         "hrsh7th/cmp-path",
        --         "hrsh7th/cmp-cmdline",
        --         "kristijanhusak/vim-dadbod-completion",
        --         "epwalsh/cmp-obsidian",
        --     },
        --     config = function()
        --     local cmp = require "cmp"
        --     cmp.setup {
        --     sources = {
        --             { name = "nvim_lsp" },
        --             { name = "obsidian" },
        --             { name = "vim-dadbod-completion" },
        --             { name = "path" },
        --             { name = "buffer" },
        --         },
        --     }
        --     end,
		-- },

		-- import any extras modules here
		{ import = "lazyvim.plugins.extras.linting.eslint" },
		{ import = "lazyvim.plugins.extras.formatting.prettier" },
		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		-- { import = "lazyvim.plugins.extras.lang.markdown" },
		{ import = "lazyvim.plugins.extras.lang.rust" },
		{ import = "lazyvim.plugins.extras.lang.tailwind" },
		-- { import = "lazyvim.plugins.extras.dap.core" },
		-- { import = "lazyvim.plugins.extras.vscode" },
		{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
		-- { import = "lazyvim.plugins.extras.test.core" },
		-- { import = "lazyvim.plugins.extras.coding.yanky" },
		-- { import = "lazyvim.plugins.extras.editor.mini-files" },
		-- { import = "lazyvim.plugins.extras.util.project" },
		{ import = "plugins" },
	},
    {
    "tpope/vim-dadbod",
    lazy = false,
    enabled = true,
    },
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	dev = {
		path = "~/.ghq/github.com",
	},
	checker = { enabled = true }, -- automatically check for plugin updates
	performance = {
		cache = {
			enabled = true,
			-- disable_events = {},
		},
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	ui = {
		custom_keys = {
			["<localleader>d"] = function(plugin)
				dd(plugin)
			end,
		},
	},
	debug = false,
})
