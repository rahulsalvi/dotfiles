return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "open_webui",
        },
        inline = {
          adapter = "open_webui",
        },
        cmd = {
          adapter = "open_webui",
        },
      },
      adapters = {
        open_webui = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              -- for whatever reason, the ollama openai api implementation works better than the openwebui one
              url = "https://open-webui.ipn.rahulsalvi.com/ollama",
              api_key = "cmd:systemd-creds --user decrypt ~/.config/nvim/openwebui_key.cred",
            },
            schema = {
              model = {
                default = "qwen2.5-coder:14b",
              },
            },
          })
        end,
      },
    },
  },
}
