return {
	-- better vim.ui
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	{
		'xiyaowong/nvim-transparent',
	},

	-- show indentation guides
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},

	-- lualine
	{
		'nvim-lualine/lualine.nvim',
		event = 'VeryLazy',
		opts = {
			options = {
				icons_enabled = false,
				theme = 'auto',
				component_separators = '|',
				section_separators = '',
				disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
			},
			sections = {
				lualine_b = {
					{
						'diff',
						diff_color = {
							modified = { fg = "#E49B5D" },
						},
						symbols = {
							modified = ' ',
							added = ' ',
							removed = ' '
						},
					},
					'diagnostics',
				},
				lualine_c = {
					{
						'filename',
						path = 1,
					},
					{
						function()
							local key = require("grapple").key()
							return "[" .. key .. "]"
						end,
						cond = require("grapple").exists
					}
				},
				lualine_x = {},
			},
			inactive_sections = {
				lualine_b = {
					{
						'filename',
						path = 1,
					},
					{
						function()
							local key = require("grapple").key()
							return "[" .. key .. "]"
						end,
						cond = require("grapple").exists
					}
				},
				lualine_c = {},
				lualine_x = {},
			},
		},
	},

	-- display lsp status in statusline
	{
		'j-hui/fidget.nvim',
		event = 'LspAttach',
		config = function()
			require('fidget').setup({})
		end,
	},

	-- dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("s", "勒" .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
				dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			vim.b.miniindentscope_disable = true

			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					local msg = "Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					local handle = io.popen(string.format("cowsay '%s'", msg))
					if handle ~= nil then
						dashboard.section.header.val = handle:read("*a")
						handle:close()
					else
						dashboard.section.header.val = msg
					end
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
}
