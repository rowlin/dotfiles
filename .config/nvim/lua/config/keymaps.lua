-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("n", "<leader>C", function()
--   require("codecompanion").chat("open")
-- end, { desc = "Open CodeCompanion Chat" })

vim.keymap.set("n", "gt", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", {})
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})

-- dd without yank
-- vim.keymap.set("n", "dd", '"_dd', { noremap = true, silent = true })

vim.keymap.set("n", "gf", function()
  if require("obsidian").util.cursor_on_markdown_link() then
    return "<cmd>ObsidianFollowLink<CR>"
  else
    return "gf"
  end
end, { noremap = false, expr = true })
