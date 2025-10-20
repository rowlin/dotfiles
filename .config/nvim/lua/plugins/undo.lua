return {
  "debugloop/telescope-undo.nvim",
  dependencies = { -- note how they're inverted to above example
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  keys = {
    { -- lazy style key map
      "<leader>r",
      "<cmd>Telescope undo<cr>",
      desc = "Undo history",
    },
  },
  opts = {
    -- don't use `defaults = { }` here, do this in the main telescope spec
    extensions = {
      undo = {
        -- telescope-undo.nvim config, see below
        side_by_side = true,
        layout_strategy = "vertical",
        layout_config = {
          preview_height = 0.3,
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      local telescope = require("telescope")
      require("telescope").load_extension("undo")
      local undo_actions = require("telescope-undo.actions")

      -- обновляем настройки, включая actions
      telescope.setup({
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.3,
            },
            mappings = {
              i = {
                ["S-<cr>"] = undo_actions.restore,
                ["C-<cr>"] = undo_actions.restore,
              },
              n = {
                ["S-<cr>"] = undo_actions.restore,
                ["C-<cr>"] = undo_actions.restore,
              },
            },
          },
        },
      })
    end,
  },
}
