return {
  "folke/sidekick.nvim",
  opts = {
    nes = { enabled = false },
    cli = {
      tools = {
        opencode = {
          cmd = { "opencode", "--continue" },
          -- HACK: https://github.com/sst/opencode/issues/445
          env = { OPENCODE_THEME = "system" },
        },
      },
    },
  },
  require("sidekick").setup({}),
  -- stylua: ignore
  keys = {
    -- nes is also useful in normal mode
    { "<tab>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n" }, expr = true },
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    {
      "<c-.>",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle",
      mode = { "n", "t", "i", "x" },
    },
    {
      "<leader>aa",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function() require("sidekick.cli").select() end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = "Select CLI",
    },
    {
      "<leader>ad",
      function() require("sidekick.cli").close() end,
      desc = "Detach a CLI Session",
    },
    {
      "<leader>at",
      function() require("sidekick.cli").send({ msg = "{this}" }) end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>af",
      function() require("sidekick.cli").send({ msg = "{file}" }) end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function() require("sidekick.cli").send({ msg = "{selection}" }) end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
    {
      "<leader>ag",
      function()
        local prompt_path = vim.fn.stdpath("config") .. "/lua/plugins/assets/gitCommitPrompt.md"
        local file = io.open(prompt_path, "r")
        if file then
          local content = file:read("*a")
          file:close()
          require("sidekick.cli").send({ msg = content })
        else
          vim.notify("Could not read git commit prompt file", vim.log.levels.ERROR)
        end
      end,
      desc = "Git Commit Message (Staged)",
    },
  },
}
