return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        version = false, -- use HEAD
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = 'delete_buffer',
                    },
                },
            },
            extensions = {
                file_browser = {
                    hijack_netrw = true
                },
            },
        },
        keys = {
            { '<leader>?', '<cmd>Telescope oldfiles<cr>', desc = '[?] Find recently opened files' },
            { '<leader><space>', '<cmd>Telescope buffers<cr>', desc = '[ ] Find existing buffers' },
            { '<leader>se', ':Telescope file_browser<CR>', desc = '[S]earch File [E]xplorer' },
            {
                '<leader>/',
                function()
                    -- You can pass additional configuration to telescope to change theme, layout, etc.
                    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown())
                end,
                desc = '[/] Fuzzily search in current buffer]'
            },
            {
                '<leader>sf',
                function()
                    require('telescope.builtin').find_files()
                end,
                desc = '[S]earch [F]iles'
            },
            {
                '<leader>sh',
                function()
                    require('telescope.builtin').help_tags()
                end,
                desc = '[S]earch [H]elp'
            },
            {
                '<leader>sw',
                function()
                    require('telescope.builtin').grep_string()
                end,
                desc = '[S]earch current [W]ord'
            },
            {
                '<leader>sg',
                function()
                    require('telescope.builtin').live_grep()
                end,
                desc = '[S]earch by [G]rep'
            },
            {
                '<leader>sd',
                function()
                    require('telescope.builtin').diagnostics()
                end,
                desc = '[S]earch [D]iagnostics'
            },
        },
        config = function(_, opts)
            local telescope = require('telescope')
            telescope.setup(opts)
            telescope.load_extension('fzf')
            telescope.load_extension('file_browser')
        end,
    },

    {
        'windwp/nvim-spectre',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { '<leader>sr', '<cmd>lua require("spectre").open()<CR>' },
        },
    },

    -- git indicators
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPre',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
        keys = {
            { '<leader>gd', '<CMD>Gitsigns diffthis<CR>' },
            { '<leader>gb', '<CMD>Gitsigns blame_line<CR>' },
            { '[c',         '<CMD>Gitsigns prev_hunk<CR>' },
            { ']c',         '<CMD>Gitsigns next_hunk<CR>' },
        }
    },

    -- git management
    {
        'kdheepak/lazygit.nvim',
        event = 'VeryLazy',
        keys = {
            { '<leader>gg', '<CMD>LazyGit<CR>' },
        }
    },

    -- floating terminal
    {
        'numToStr/FTerm.nvim',
        event = 'VeryLazy',
        keys = {
            { '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>' },
            { '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = { 't' } }
        }
    },

    -- help :)
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            window = {
                border = 'single', -- none, single, double, shadow
                position = 'bottom', -- bottom, top
                margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
                padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
                winblend = 0,
            },
            layout = {
                height = { min = 4, max = 25 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
                spacing = 3, -- spacing between columns
                align = 'left', -- align columns left, center or right
            },
        },
        config = function(_, opts)
            local wk = require('which-key')
            wk.setup(opts)
            wk.register({
                ['<leader>s'] = { name = '+search' },
                ['<leader>l'] = { name = '+lsp' },
                ['<leader>c'] = { name = '+lsp' },
                ['<leader>w'] = { name = '+workspace' },
                ['<leader>x'] = { name = '+trouble' },
                ['<leader>g'] = { name = '+git' },
            })
        end
    },

    -- easily jump to any location and enhanced f/t motions for Leap
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } } },
        config = function(_, opts)
            local leap = require('leap')
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings(true)
        end,
    },

    -- better diagnostics list and others
    {
        "folke/trouble.nvim",
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
        event = "BufReadPost",
        config = true,
        -- stylua: ignore
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "[S]earch [T]odo" },
        },
    },

    -- system clipboard yanking
    {
        'ojroques/nvim-osc52',
        event = 'BufReadPost',
        config = {
            silent = false,
        },
        keys = {
            { '<leader>y', function() require('osc52').copy_visual() end, desc = 'Yank to clipboard', mode = { 'x' } },
        },
    },
}
