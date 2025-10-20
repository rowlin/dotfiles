local function get_intelephense_license()
  local path = vim.fn.expand("~/.intelephense/licence.txt")
  local f = io.open(path, "r")
  if not f then
    vim.notify("Intelephense licence.txt not found at " .. path, vim.log.levels.WARN)
    return ""
  end
  local content = f:read("*a")
  f:close()
  return (content:gsub("%s+", ""))
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          -- cmd = { "intelephense", "--stdio" },
          filetypes = { "php", "blade", "php_only" },
          -- root_dir = require("lspconfig.util").root_pattern("composer.json", ".git"),
          init_options = {
            licenceKey = get_intelephense_license(),
          },
        },
      },
    },
  },
}
