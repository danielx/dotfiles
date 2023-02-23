return {
	-- snippets
	{
		'L3MON4D3/LuaSnip',
		opts = {
			history = true,
			delete_check_events = 'TextChanged',
		},
		-- stylua: ignore
		keys = {
			{
				'<tab>',
				function()
					return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
				end,
				expr = true, silent = true, mode = 'i',
			},
			{ '<tab>', function() require('luasnip').jump(1) end, mode = 's' },
			{ '<s-tab>', function() require('luasnip').jump(-1) end, mode = { 'i', 's' } },
		},
	},

	-- auto completion
	{
		'hrsh7th/nvim-cmp',
		version = false, -- last release is way too old
		event = 'InsertEnter',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'saadparwaiz1/cmp_luasnip',
		},
		opts = function()
			local cmp = require('cmp')
			local luasnip = require('luasnip')
			return {
				completion = {
					completeopt = 'menu,menuone,noinsert',
				},
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'buffer' },
					{ name = 'path' },
				}),
				experimental = {
					ghost_text = {
						hl_group = 'LspCodeLens',
					},
				},
			}
		end,
	},

	-- auto pairs
	{
		'echasnovski/mini.pairs',
		event = 'VeryLazy',
		config = function(_, opts)
			require('mini.pairs').setup(opts)
		end,
	},

	-- surround
	{
		'echasnovski/mini.surround',
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local mappings = {
				{ 'gza', desc = 'Add surrounding', mode = { 'v' } },
				{ 'gzd', desc = 'Delete surrounding' },
				{ 'gzf', desc = 'Find right surrounding' },
				{ 'gzF', desc = 'Find left surrounding' },
				{ 'gzH', desc = 'Highlight surrounding' },
				{ 'gzr', desc = 'Replace surrounding' },
				{ 'gzn', desc = 'Update `MiniSurround.config.n_lines`' },
			}
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = 'gza', -- Add surrounding in Normal and Visual modes
				delete = 'gzd', -- Delete surrounding
				find = 'gzf', -- Find surrounding (to the right)
				find_left = 'gzF', -- Find surrounding (to the left)
				highlight = 'gzh', -- Highlight surrounding
				replace = 'gzr', -- Replace surrounding
				update_n_lines = 'gzn', -- Update `n_lines`
			},
		},
		config = function(_, opts)
			-- use gz mappings instead of s to prevent conflict with leap
			require('mini.surround').setup(opts)
		end,
	},

	-- comments
	{ 'JoosepAlviste/nvim-ts-context-commentstring', lazy = true },
	{
		'echasnovski/mini.comment',
		event = 'VeryLazy',
		opts = {
			hooks = {
				pre = function()
					require('ts_context_commentstring.internal').update_commentstring({})
				end,
			},
		},
		config = function(_, opts)
			require('mini.comment').setup(opts)
		end,
	},

	-- better text-objects
	{
		'echasnovski/mini.ai',
		keys = {
			{ 'a', mode = { 'x', 'o' } },
			{ 'i', mode = { 'x', 'o' } },
		},
		dependencies = {
			{ 'nvim-treesitter/nvim-treesitter-textobjects' },
		},
		opts = function()
			local ai = require('mini.ai')
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { '@block.outer', '@conditional.outer', '@loop.outer' },
						i = { '@block.inner', '@conditional.inner', '@loop.inner' },
					}, {}),
					f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
					c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
				},
			}
		end,
		config = function(_, opts)
			local ai = require('mini.ai')
			ai.setup(opts)
		end,
	},

	-- indentation (editorconfig etc)
	{ 'tpope/vim-sleuth' },
}
