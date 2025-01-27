-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = " "
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.directory = ".,/tmp//"
vim.opt.number = true
vim.opt.linespace = 15 -- Increases the line spacing
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = "fish"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "cursor"
vim.opt.mouse = ""
--vim.opt.shell = "powershell"
vim.opt.shell = '"C:/Program Files/Git/bin/bash.exe"'
vim.opt.termguicolors = true
vim.g.python3_host_prog = "C:\\Users\\Shivam\\.virtualenvs\\nvim-venv\\Scripts\\python.exe"
vim.g.pcode_transparent_model = 0
vim.g.pcode_progress = 0
-- Set Gruvbox background to dark (or light)
vim.opt.background = "dark"  -- or "light" for a lighter background

-- Customize Gruvbox palette (optional)
vim.g.gruvbox_contrast_dark = "hard"  -- You can use "medium", "soft", or "hard"
vim.g.gruvbox_invert_selection = 0   -- To make selection more visible

-- You can also customize other Gruvbox options:
vim.g.gruvbox_italic = 1  -- Enable italic text in comments and strings
vim.g.gruvbox_sign_column = "bg0"  -- Custom color for the sign column
-- options.lua
-- Enable markdown syntax concealment
vim.opt.conceallevel = 2  -- or 3 for more aggressive hiding

-- Optional: Customize concealed characters
vim.opt.concealcursor = "niv"  -- Conceal in normal/visual/insert modes
vim.cmd([[highlight pythonKeyword guifg=#fe8019]])
vim.cmd([[highlight pythonFunction guifg=#83a598]])
vim.cmd([[highlight pythonIdentifier guifg=#ebdbb2]])
vim.cmd([[highlight pythonString guifg=#b8bb26]])
vim.cmd([[highlight pythonNumber guifg=#d79921]])
vim.cmd([[highlight pythonOperator guifg=#fb4934]])
vim.cmd([[highlight pythonComment guifg=#7c6f64]])
vim.cmd([[highlight pythonDocstring guifg=#a89984]])
vim.g.mkdp_port = '9000' -- Change if port 8080 is busy
vim.g.mkdp_browser = 'chrome'


vim.keymap.set("n", "<leader>nn", function()
  local topic = vim.fn.input("Topic (e.g., programming): ")
  local note = vim.fn.input("Note name: ")
  vim.cmd("ObsidianNew " .. "topics/" .. topic .. "/" .. note)
end, { desc = "New Topic Note" })

-- Create a new note
vim.keymap.set("n", "<leader>nn", "<cmd>ObsidianNew<cr>", { desc = "New Note" })

-- Search notes
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "Search Notes" })

-- Follow wikilinks
vim.keymap.set("n", "<leader>fl", "<cmd>ObsidianFollowLink<cr>", { desc = "Follow Link" })

-- Daily notes
vim.keymap.set("n", "<leader>nt", "<cmd>ObsidianToday<cr>", { desc = "Daily Note" })

vim.keymap.set("n", "<leader>nl", "<cmd>ObsidianBacklinks<cr>", { desc = "Show Backlinks" })

-- Insert  a template  into  the current  note
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<cr>", { desc = "Show Backlinks" })


-- Rename the current note and update all backlinks
vim.keymap.set("n", "<leader>orn", "<cmd>ObsidianRename<cr>", { desc = "Show Backlinks" })

-- Add this to your LazyVim config (e.g., lua/config/keymaps.lua)
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Markdown Preview" })
vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", { desc = "Stop Preview" })
vim.keymap.set("n", "<leader>mt", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Preview" })

vim.g.dbs = {
  production = 'mysql://root:Shivam123%40@127.0.0.1/coffe_shop_sales',
}

vim.keymap.set(
	"n",
	"<leader>h",
	':silent !wt.exe action moveFocus direction="left"<CR>',
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<leader>j",
	':silent !wt.exe action moveFocus direction="down"<CR>',
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<leader>k",
	':silent !wt.exe action moveFocus direction="up"<CR>',
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<leader>l",
	':silent !wt.exe action moveFocus direction="right"<CR>',
	{ noremap = true, silent = true }
)

vim.keymap.set(
	"n",
	"<leader>-",
	':echo "Splitting horizontally"<CR>:silent !wt.exe action splitPane split="horizontal"<CR>',
	{ noremap = true, silent = false }
)

vim.keymap.set(
	"n",
	"<leader>v",
	':echo "Splitting vertically"<CR>:silent !wt.exe action splitPane split="vertical"<CR>',
	{ noremap = true, silent = false }
)

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
-- Horizontal split
vim.keymap.set("n", "<leader>sp", ":split<CR>", { noremap = true, silent = true, desc = "Horizontal split" })

-- Vertical split
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { noremap = true, silent = true, desc = "Vertical split" })

-- Equalize window sizes
vim.keymap.set("n", "<leader>se", ":wincmd =<CR>", { noremap = true, silent = true, desc = "Equalize splits" })

-- Close the current window
vim.keymap.set("n", "<leader>cw", ":close<CR>", { noremap = true, silent = true, desc = "Close current window" })

-- Quit Neovim entirely (if it's the last window)
vim.keymap.set("n", "<leader>qq", ":q<CR>", { noremap = true, silent = true, desc = "Quit Neovim" })

-- Close all windows except the current one
vim.keymap.set("n", "<leader>co", ":only<CR>", { noremap = true, silent = true, desc = "Close all other windows" })


-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

if vim.fn.has("nvim-0.8") == 1 then
	vim.opt.cmdheight = 0
end
