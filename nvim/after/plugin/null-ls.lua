local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    -- Python
    formatting.black,
    formatting.isort,
    diagnostics.flake8,
    -- Golang
    formatting.goimports,
    -- JS/TS
    formatting.prettier,
    code_actions.eslint,
    -- Shell
    formatting.shfmt,
    diagnostics.shellcheck,
    diagnostics.zsh,
    -- YAML
    diagnostics.yamllint,
  },
})
