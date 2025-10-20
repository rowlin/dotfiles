local util = require("conform.util")
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- format_on_save = function(bufnr)
    --   -- Disable "format_on_save lsp_fallback" for languages that don't
    --   -- have a well standardized coding style. You can add additional
    --   -- languages here or re-enable it for the disabled ones.
    --   local disable_filetypes = { vue = true, js = true }
    --   return {
    --     timeout_ms = 500,
    --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    --   }
    -- end,
    --format_on_save = {
    --   -- These options will be passed to conform.format()
    --  timeout_ms = 500,
    --},
    default_format_opts = {
      lsp_format = "fallback",
    },
    ---@type table<string, conform.FormatterUnit[]>
    formatters_by_ft = {
      lua = { "stylua" },
      typescript = { "prettierd" },
      javascript = { "prettierd" },
      vue = { "prettier" }, --- "prettier", stop_after_first = true },
      sh = { "shfmt" },
      php = { "php_cs_fixer" },
      sql = { "sql_formatter" },
    },
    -- LazyVim will merge the options you set here with builtin formatters.
    -- You can also define any custom formatters here.
    ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
    formatters = {
      injected = { options = { ignore_errors = true } },
      -- # Example of using dprint only when a dprint.json file is present
      -- dprint = {
      --   condition = function(ctx)
      --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
      --
      -- # Example of using shfmt with extra args
      -- shfmt = {
      --   extra_args = { "-i", "2", "-ci" },
      -- },
      -- that not tested
      ["php-cs-fixer"] = {
        -- local composer_globa_dir = vim.fn.expand("$HOME/.config/composer")
        -- local composer_global_bin_dir = composer_globa_dir .. "/vendor/bin"{
        command = "$HOME/.config/composer/vendor/bin/php-cs-fixer",
        args = {
          "fix",
          "--rules=@PSR12",
          -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
          "$FILENAME",
        },
        stdin = false,
      },
      pint = {
        meta = {
          url = "https://github.com/laravel/pint",
          description = "Laravel Pint",
        },
        command = util.find_executable({
          vim.fn.stdpath("data") .. "/mason/bin/pint",
          "./vendor/bin/sail php ./vendor/bin/pint",
        }, "pint"),
        args = { "$FILENAME" },
        stdin = false,
      },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
