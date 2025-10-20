-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto save
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--   pattern = { "*" },
--   command = "silent! wall",
--   nested = true,
-- })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(event)
    vim.schedule(function()
      require("noice.text.markdown").keys(event.buf)
    end)
  end,
})

-- render markdown
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function(event)
--     local buf = event.buf
--     vim.treesitter.start(buf, "markdown")
--     vim.schedule(function()
--       assert(vim.treesitter.get_parser(buf)):parse({ 0, 80 })
--     end)
--   end,
-- })
-- Commented
--
-- local lsp_hacks = vim.api.nvim_create_augroup("LspHacks", { clear = true })
--
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
--   group = lsp_hacks,
--   pattern = ".env*",
--   callback = function(e)
--     vim.diagnostic.enable(false, { bufnr = e.buf })
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = { "*.md" },
--   command = "lua vim.diagnostic.disable()",
--   nested = false,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     vim.diagnostic.disable()
--   end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     vim.diagnostic.disable(0) -- disable for the current buffer
--   end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     if vim.diagnostic and vim.diagnostic.disable then
--       vim.diagnostic.disable(0) -- disable diagnostics for the current buffer
--     elseif vim.lsp and vim.lsp.diagnostic and vim.lsp.diagnostic.disable then
--       vim.lsp.diagnostic.disable(0)
--     else
--       vim.notify("Diagnostics API not available", vim.log.levels.WARN)
--     end
--   end,
-- })
--

-- Сделать $ частью слова только в php
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "php",
--   callback = function()
--     vim.opt_local.iskeyword:append("$")
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("InsertLeave", {
--   pattern = "*",
--   callback = function()
--     vim.cmd("silent! wall")
--   end,
--   nested = true,
-- })
--
-- vim.diagnostic.config({
--   float = { source = nil, border = "single" },
--   virtual_text = false,
--   signs = true,
-- })
--
-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
--   pattern = "*",
--   callback = function()
--     vim.schedule(function()
--       vim.diagnostic.open_float(nil, { focus = false })
--     end)
--   end,
-- })

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.vue",
  callback = function()
    local marks = {
      c = "created%(%s*%)", -- created()
      a = "asyncData%(%s*%)", -- asyncData()
      u = "updated%(%s*%)", -- updated
      i = "import", -- import
      m = "methods%s*:%s*", -- methods
      d = "data%(%s*%)", -- data()
      e = "export", -- export
      w = "watch%s*:", -- watch:
      p = "props%s*:%s*", -- props: {
      s = "<style>", -- style (опечатка была — исправил)
    }

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    for mark, pattern in pairs(marks) do
      for i, line in ipairs(lines) do
        if line:match(pattern) then
          vim.api.nvim_buf_set_mark(0, mark, i, 0, {}) -- line is 0-based
          break -- только первый матч для каждого mark
        end
      end
    end
  end,
})
----
-- vim.api.nvim_create_autocmd({ "TextChangedUI" }, {
--   callback = function()
--     local line = vim.api.nvim_get_current_line()
--     local cursor = vim.api.nvim_win_get_cursor(0)[2]
--
--     local current = string.sub(line, cursor, cursor + 1)
--     if current == "." or current == "," or current == " " then
--       require("cmp").close()
--     end
--
--     local before_line = string.sub(line, 1, cursor + 1)
--     local after_line = string.sub(line, cursor + 1, -1)
--     if not string.match(before_line, "^%s+$") then
--       if after_line == "" or string.match(before_lin:e, " $") or string.match(before_line, "%.$") then
--         require("cmp").complete()
--       end
--     end
--   end,
--   pattern = "*",
-- })
