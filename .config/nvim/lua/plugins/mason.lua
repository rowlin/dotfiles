return {
  {
    "mason-org/mason.nvim",
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information

      ensure_installed = {
        "shellcheck",
        "shfmt",
        "blade-formatter",
        "html-lsp",
        "intelephense",
        "pint",
        "prettier",
        "tailwindcss-language-server",
        "php-cs-fixer",
      },
      handlers = {
        -- default handler (optional)
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      },
    },
  },
  { "mason-org/mason-lspconfig.nvim" },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "js-debug-adapter")
    end,
  },
}
