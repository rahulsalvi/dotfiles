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
        -- there are a few choices for setting up the adapter:
        --  1. use open webui openai compatibility (open-webui/api/... or open-webui/api/v1/...)
        --  2. use open webui ollama passthrough with ollama openai compatibility (open-webui/ollama/v1/...)
        --  3. use open webui ollama passthrough with ollama api (open-webui/ollama/...)
        --  4. use ollama directly (ollama:11434)
        -- in practice, (1) seems to be the best, but some models don't format the output correctly
        --  qwen3 seems to work
        -- (2) works but throws some api errors when using tools
        -- (3) seems to have issues connecting
        -- (4) bypasses open-webui which is undesirable
        open_webui = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            name = "open_webui",
            formatted_name = "Open WebUI",
            env = {
              url = "https://open-webui.ipn.rahulsalvi.com/api",
              api_key = "cmd:systemd-creds --user decrypt ~/.config/nvim/openwebui_key.cred",
            },
            schema = {
              model = {
                default = "qwen3:14b",
              },
            },
          })
        end,
      },
    },
  },
}
