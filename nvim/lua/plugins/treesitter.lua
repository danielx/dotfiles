return {
	-- display context when its out of view (above scroll)
	{
		'nvim-treesitter/nvim-treesitter-context',
		event = { 'BufReadPre', 'BufNewFile' },
		config = true,
	},

	-- [[ Configure Treesitter ]]
	-- See `:help nvim-treesitter`
	{
		'nvim-treesitter/nvim-treesitter', -- Add languages to be installed here that you want installed for treesitter
		version = false,             -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { 'BufReadPost', 'BufNewFile' },
		opts = {
			ensure_installed = {
				'go',
				'lua',
				'luap',
				'python',
				'javascript',
				'typescript',
				'tsx',
				'help',
				'markdown',
				'markdown_inline',
				'query',
				'regex',
				'vim',
				'html',
				'css',
				'json',
				'yaml',
				'dockerfile',
				'bash',
			},
			highlight = { enable = true },
			indent = { enable = true, disable = { 'python' } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<c-space>',
					node_incremental = '<c-space>',
					scope_incremental = '<c-s>',
					node_decremental = '<c-backspace>',
				},
			},
			textobjects = {
				select = {
					enable = false,
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
							[']m'] = '@function.outer',
							[']]'] = '@class.outer',
					},
					goto_next_end = {
							[']M'] = '@function.outer',
							[']['] = '@class.outer',
					},
					goto_previous_start = {
							['[m'] = '@function.outer',
							['[['] = '@class.outer',
					},
					goto_previous_end = {
							['[M'] = '@function.outer',
							['[]'] = '@class.outer',
					},
				},
				swap = {
					enable = true,
					swap_next = {
							['<leader>a'] = '@parameter.inner',
					},
					swap_previous = {
							['<leader>A'] = '@parameter.inner',
					},
				},
			},
		},
		config = function(_, opts)
			require('nvim-treesitter.configs').setup(opts)
		end,
	},
}
