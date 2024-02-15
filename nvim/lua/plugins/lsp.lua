-- Enable the following language servers
local servers = {
	bashls = {},
	gopls = {},
	pyright = {},
	tsserver = {},
	eslint = {},
	cssls = {},
	html = {},
	vuels = {}, -- Vue 2 (volar for vue3)
	jsonls = {},
	dockerls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

return {
	-- lsp servers
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"folke/neoconf.nvim",
				cmd = "Neoconf",
				config = true,
			},
			{
				"folke/neodev.nvim",
				opts = { experimental = { pathStrict = true } },
			},
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"ray-x/lsp_signature.nvim",
		},
		config = function()
			-- Ensure the servers above are installed
			local mason = require("mason")
			mason.setup()

			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- LSP settings.
			--  This function gets run when an LSP connects to a particular buffer.
			local on_attach = function(_, bufnr)
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end

					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				require("lsp_signature").on_attach({}, bufnr)
				nmap("<leader>cr", vim.lsp.buf.rename, "[R]ename")
				nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				nmap("<leader>cs", require("telescope.builtin").lsp_document_symbols, "Document [S]ymbols")

				nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				nmap("gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

				-- Diagnostic keymaps
				nmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
				nmap("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
				nmap("]e", function()
					vim.diagnostic.goto_next({ severity = "ERROR" })
				end, "Next Error")
				nmap("[e", function()
					vim.diagnostic.goto_prev({ severity = "ERROR" })
				end, "Prev Error")
				nmap("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
				nmap("<leader>cq", vim.diagnostic.setloclist, "Set Loc List")

				-- See `:help K` for why this keymap
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("L", vim.lsp.buf.signature_help, "Signature Documentation")

				-- Lesser used LSP functionality
				nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace Symbols")
				nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				nmap("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")

				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					require("conform").format({ bufnr = bufnr })
				end, { desc = "Format current buffer with LSP" })
			end

			vim.keymap.set("n", "<leader>f", require("conform").format, { desc = "[F]ormat" })
			-- setup neovim/nvim-lspconfig
			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
					})
				end,
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				json = { {"prettierd", "prettier" } },
				markdown = { "mdformat" },
				go = { "goimports" },
				sh = { "shfmt" },
				sql = { "sql_formatter" },
			},
		},
	},
}
