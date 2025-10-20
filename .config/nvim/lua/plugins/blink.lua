return {
  {
    "saghen/blink.compat",
    -- use v2.* for blink.cmp v1.*
    version = "2.*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      { "Exafunction/codeium.nvim" },
    },
    opts = {
      sources = {
        default = { "snippets", "lsp", "buffer", "codeium", "cmdline", "path", "laravel" },
        providers = {
          codeium = {
            name = "Codeium",
            module = "codeium.blink",
            async = true,
            min_keyword_length = 4,
            score_offset = -50,
          },
          laravel = {
            name = "laravel",
            module = "blink.compat.source",
            score_offset = 95, -- show at a higher priority than lsp
          },
          snippets = {
            min_keyword_length = 2,
            score_offset = 100,
          },
          lsp = {
            min_keyword_length = 2,
            score_offset = 25,
          },
          buffer = {
            min_keyword_length = 3,
            score_offset = 10,
          },
          cmdline = {
            min_keyword_length = 4,
            score_offset = 5,
          },
          path = {
            min_keyword_length = 5,
            score_offset = 0,
          },
        },
      },
      -- performance = {
      --   async_budget = 1,
      --   debounce = 0,
      --   fetching_timeout = 50,
      -- },
    },
    completion = {
      list = {
        selection = "auto_insert",
      },
      accept = { auto_brackets = true },
      delay = 0,
      throttle = 0,
      trigger = { debounce = 0 },
    },
  },
}
