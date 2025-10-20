-- if a file is a .env or .envrc file, set the filetype to sh
return {
  {
    "nvim-lua/plenary.nvim", -- пустышка-зависимость (чтобы lazy видел как плагин)
    init = function()
      vim.filetype.add({
        filename = {
          [".env"] = "sh",
          [".envrc"] = "sh",
        },
        pattern = {
          [".*%.env"] = "sh",
          [".*%.envrc"] = "sh",
        },
      })
    end,
  },
}
