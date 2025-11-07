return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = { -- when LazyVim switches to nvim-lspconfig ≥ v2.2.0 rename this to `vue_ls`
          on_init = function(client)
            client.handlers["tsserver/request"] = function(_, result, context)
              -- find the vtsls client
              local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
              if #clients == 0 then
                vim.notify("Could not find `vtsls` client, Vue LSP features will be disabled", vim.log.levels.ERROR)
                return
              end
              local ts_client = clients[1]
              -- unpack the forwarded request
              local params = unpack(result)
              local id, command, payload = unpack(params)
              -- forward it
              ts_client:exec_cmd({
                title = "vue_request_forward",
                command = "typescript.tsserverRequest",
                arguments = { command, payload },
              }, { bufnr = context.bufnr }, function(_, resp)
                -- send the tsserver/response back to Vue LSP
                client.notify("tsserver/response", { { id, resp.body } })
              end)
            end
          end,
        },
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
      },
    },
  },
}
