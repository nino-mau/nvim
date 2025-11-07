return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({})
    local suggestion = require("supermaven-nvim.completion_preview")

    -- Disable inline completion by default
    suggestion.disable_inline_completion = true
    suggestion.disable_keymaps = true
  end,
}
