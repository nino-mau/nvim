-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  -- { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "vue",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    version = "^2.0.0",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "yaml-language-server",
        "vue-language-server",
        "typescript-language-server",
        "stylelint-lsp",
        "stylelint",
        "sqlls",
        "sql-formatter",
        "prettierd",
        "markdownlint",
        "lua-language-server",
        "jsonlint",
        "json-lsp",
        "html-lsp",
        "eslint_d",
        "emmet-ls",
        "emmet-language-server",
        "dotenv-linter",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "css-variables-language-server",
        "css-lsp",
        "commitlint",
        "shfmt",
        "stylua",
      },
    },
  },
}
