return {
	-- tools
	-- {
	-- 	"williamboman/mason.nvim",
	-- 	opts = function(_, opts)
	-- 		vim.list_extend(opts.ensure_installed, {
	-- 			"stylua",
	-- 			"selene",
	-- 			"luacheck",
	-- 			"shellcheck",
	-- 			"shfmt",
	-- 			"tailwindcss-language-server",
	-- 			"typescript-language-server",
	-- 			"css-lsp",
    --             "pyright"
	-- 		})
	-- 	end,
	-- },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            -- import mason
            local mason = require("mason")

            -- import mason-lspconfig
            local mason_lspconfig = require("mason-lspconfig")

            local mason_tool_installer = require("mason-tool-installer")

            -- enable mason and configure icons
            mason.setup({
            ui = {
                icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
                },
            },
            })

            mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "bashls",
                "svelte",
                "lua_ls",
                "graphql",
                "pyright",
                "shellcheck"
            },
            })

            mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                "isort", -- python formatter
                "black", -- python formatter
                "pylint",
                "eslint_d",
            },
            })
        end,
    },

	-- lsp servers
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
			---@type lspconfig.options
			servers = {

				lua_ls = {
					-- enabled = false,
					single_file_support = true,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									-- "--log-level=trace",
								},
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = {
								privateName = { "^_" },
							},
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								-- enable = false,
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},
                pyright = {
                    settings = {
                        python = {
                            pythonPath = "C:/Users/Shivam/.virtualenvs/nvim-venv/Scripts/python.exe",
                                analysis = {
                                typeCheckingMode = "basic",  -- Can be "off", "basic", or "strict"
                                autoSearchPaths = true,  -- Automatically search for Python environments
                                useLibraryCodeForTypes = true,  -- Use the Python library for type checkingtypeCheckingMode = "basic",  -- Use "basic" or "off" for less strict checking
                                autoSearchPaths = true,  -- Automatically search for Python environments
                                useLibraryCodeForTypes = true,  -- Use the Python library code for type checking
                                diagnosticMode = "workspace",  -- Check the entire workspace, not just open files
                                reportMissingTypeStubs = false,  -- Disable missing type stub reports for popular libraries like pandas, numpy
                                reportUnusedImport = "none",  -- You might want to ignore unused imports, which is common in notebooks
                                reportUnusedFunction = "none",  -- Similarly, you may want to avoid warnings about unused functions in exploratory code
                            },
                            completion = {
                                addBrackets = true,
                            },
                            formatting = {
                                provider = "black"
                            },
                              },
                    },
                },
			},
			setup = {},
		},
	},

}
