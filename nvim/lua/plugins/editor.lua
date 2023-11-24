return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false, -- use HEAD
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		opts = {
			defaults = {
				results_title = false,
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
					},
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--trim",
					"--hidden",
					"--glob",
					"!**/.git/*",
				},
			},
			extensions = {
				file_browser = {
					hijack_netrw = true,
				},
			},
			pickers = {
				find_files = {
					find_command = {
						"fd",
						"--type",
						"file",
						"--strip-cwd-prefix",
						"--hidden",
						"--exclude",
						"**/.git/*",
					},
				},
			},
		},
		keys = {
			{ "<leader>?", "<cmd>Telescope oldfiles<cr>", desc = "[?] Find recently opened files" },
			{ "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "[ ] Find existing buffers" },
			{ "<leader>se", ":Telescope file_browser<CR>", desc = "[S]earch File [E]xplorer" },
			{
				"<leader>/",
				function()
					-- You can pass additional configuration to telescope to change theme, layout, etc.
					require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown())
				end,
				desc = "[/] Fuzzily search in current buffer]",
			},
			{
				"<leader>sf",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "[S]earch [F]iles",
			},
			{
				"<leader>sh",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "[S]earch [H]elp",
			},
			{
				"<leader>sw",
				function()
					require("telescope.builtin").grep_string()
				end,
				desc = "[S]earch current [W]ord",
			},
			{
				"<leader>sg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "[S]earch by [G]rep",
			},
			{
				"<leader>sd",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "[S]earch [D]iagnostics",
			},
			{
				"<leader>sc",
				function()
					require("telescope.builtin").git_status()
				end,
				desc = "[S]earch [C]hanges",
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")
		end,
	},

	{
		"windwp/nvim-spectre",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>sr", '<cmd>lua require("spectre").open()<CR>', desc = "[S]earch [R]eplace" },
		},
	},

	-- git indicators
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
		keys = {
			{ "<leader>gd", "<CMD>Gitsigns diffthis<CR>" },
			{ "<leader>gb", "<CMD>Gitsigns blame_line<CR>" },
			{ "[c", "<CMD>Gitsigns prev_hunk<CR>" },
			{ "]c", "<CMD>Gitsigns next_hunk<CR>" },
		},
	},

	-- tmux navigation
	{
		"christoomey/vim-tmux-navigator",
		event = "VeryLazy",
		config = function()
			vim.g.tmux_navigator_no_wrap = 1
		end,
	},

	-- floating terminal
	{
		"numToStr/FTerm.nvim",
		event = "VeryLazy",
		keys = {
			{ "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>' },
			{ "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = { "t" } },
		},
		opts = {
			border = "rounded",
		},
	},

	-- help :)
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			window = {
				border = "single", -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
				padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
				winblend = 0,
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register({
				["<leader>s"] = { name = "+search" },
				["<leader>l"] = { name = "+lsp" },
				["<leader>c"] = { name = "+lsp" },
				["<leader>w"] = { name = "+workspace" },
				["<leader>x"] = { name = "+trouble" },
				["<leader>g"] = { name = "+git" },
			})
		end,
	},

	-- hotlist
	{
		"cbochs/grapple.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>m",
				function()
					require("grapple").toggle()
				end,
				desc = "Grapple mark",
			},
			{
				"<leader>M",
				function()
					require("grapple").popup_tags()
				end,
				desc = "Grapple popup",
			},
			{
				"<C-f>",
				function()
					require("grapple").select({ key = 1 })
				end,
			},
			{
				"<C-s>",
				function()
					require("grapple").select({ key = 2 })
				end,
			},
			{
				"<C-e>",
				function()
					require("grapple").select({ key = 3 })
				end,
			},
			{
				"<C-y>",
				function()
					require("grapple").select({ key = 4 })
				end,
			},
		},
	},

	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
		},
	},

	-- todo comments
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "[S]earch [T]odo" },
        },
		opts = {
			highlight = {
				pattern = [[(KEYWORDS)]], -- match without the extra colon.
			},
			search = {
				pattern = [[\b(KEYWORDS)(:|\s)]], -- match without the extra colon.
			},
		},
	},

	-- system clipboard yanking
	{
		"ojroques/nvim-osc52",
		event = { "BufReadPost", "BufNewFile" },
		config = {
			silent = false,
		},
		keys = {
			{
				"<leader>y",
				function()
					require("osc52").copy_visual()
				end,
				desc = "Yank to clipboard",
				mode = { "x" },
			},
		},
	},

	-- get github links and/or open in browser directly
	{
		"linrongbin16/gitlinker.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			callbacks = {
				["github.com"] = function()
					return require("gitlinker.hosts").get_github_type_url
				end,
			},
		},
		keys = {
			{
				"<leader>gl",
				"<cmd>GitLink<cr>",
				desc = "Copy git permlink to clipboard",
				mode = { "n", "v" },
			},
			{
				"<leader>gL",
				"<cmd>GitLink!<cr>",
				desc = "Open git permlink in browser",
				mode = { "n", "v" },
			},
		},
	},
}
