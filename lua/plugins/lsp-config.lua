return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        stylelint_lsp = {
          filetypes = { "css", "vue", "scss", "less", "sass" },
          settings = {
            stylelintplus = {
              autoFixOnSave = true,
              autoFixOnFormat = true,
            },
          },
        },
        cssls = {
          settings = {
            css = {
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
        tailwindcss = {
          filetypes = { "css", "vue", "html", "typescript", "typescriptreact" },
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  "Styles\\s*(?::\\s*[^=]+)?\\s*=\\s*([^;]*);",
                  "Style\\s*(?::\\s*[^=]+)?\\s*=\\s*([^;]*);",
                  "Class\\s*(?::\\s*[^=]+)?\\s*=\\s*([^;]*);",
                  "Classnames\\s*(?::\\s*[^=]+)?\\s*=\\s*([^;]*);",
                  "Css\\s*(?::\\s*[^=]+)?\\s*=\\s*([^;]*);",
                },
              },
            },
          },
        },
        djls = {
          filetypes = { "htmldjango" },
        },
        vtsls = {
          -- Explicitly enable vtsls (LazyVim might default to tsserver/ts_ls otherwise)
          enabled = true,
          settings = {
            vtsls = {
              enableMoveToFileCodeAction = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              check = {
                -- Disable expensive checks
                npmIsInstalled = false,
              },
              tsserver = {
                -- CRITICAL: Increase memory limit to 8GB (8192MB)
                maxTsServerMemory = 8192,
                -- Note: Don't override pluginPaths - LazyVim injects @vue/typescript-plugin for Vue hover
              },
              preferences = {
                -- Reduce auto-import scanning cost
                includePackageJsonAutoImports = "off",
              },
            },
          },
        },
        biome = {
          enabled = true,
        },
        eslint = {
          enabled = false,
        },
      },
    },
  },
}
