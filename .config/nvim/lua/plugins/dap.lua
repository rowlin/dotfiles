return {
  "mfussenegger/nvim-dap",
  optional = true,
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "js-debug-adapter")
      end,
    },
  },
  opts = function()
    local dap = require("dap")
    if not dap.adapters["pwa-node"] then
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = {
            LazyVim.get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }
    end
    if not dap.adapters["node"] then
      dap.adapters["node"] = function(cb, config)
        if config.type == "node" then
          config.type = "pwa-node"
        end
        local nativeAdapter = dap.adapters["pwa-node"]
        if type(nativeAdapter) == "function" then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

    local vscode = require("dap.ext.vscode")
    vscode.type_to_filetypes["node"] = js_filetypes
    vscode.type_to_filetypes["pwa-node"] = js_filetypes

    for _, language in ipairs(js_filetypes) do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end
  end,
}
--
-- return {
--   { "nvim-neotest/nvim-nio" },
--   {
--     "mfussenegger/nvim-dap",
--     config = function()
--       local dap = require("dap")
--
--       local Config = require("lazyvim.config")
--       vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
--
--       for name, sign in pairs(Config.icons.dap) do
--         sign = type(sign) == "table" and sign or { sign }
--         vim.fn.sign_define(
--           "Dap" .. name,
--           { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
--         )
--       end
--
--       for _, language in ipairs(js_based_languages) do
--         dap.configurations[language] = {
--           -- Debug single nodejs files
--           {
--             type = "pwa-node",
--             request = "launch",
--             name = "Launch file",
--             program = "${file}",
--             cwd = vim.fn.getcwd(),
--             sourceMaps = true,
--           },
--           -- Debug nodejs processes (make sure to add --inspect when you run the process)
--           {
--             type = "pwa-node",
--             request = "attach",
--             name = "Attach",
--             processId = require("dap.utils").pick_process,
--             cwd = vim.fn.getcwd(),
--             sourceMaps = true,
--           },
--           -- Debug web applications (client side)
--           {
--             type = "firefox",
--             request = "launch",
--             name = "Launch & Debug firefox",
--             url = function()
--               local co = coroutine.running()
--               return coroutine.create(function()
--                 vim.ui.input({
--                   prompt = "Enter URL: ",
--                   default = "http://localhost:4000",
--                 }, function(url)
--                   if url == nil or url == "" then
--                     return
--                   else
--                     coroutine.resume(co, url)
--                   end
--                 end)
--               end)
--             end,
--             webRoot = vim.fn.getcwd(),
--             protocol = "inspector",
--             sourceMaps = true,
--             userDataDir = false,
--           },
--           -- Divider for the launch.json derived configs
--           {
--             name = "----- ↓ launch.json configs ↓ -----",
--             type = "",
--             request = "launch",
--           },
--         }
--       end
--     end,
--     keys = {
--       {
--         "<leader>dO",
--         function()
--           require("dap").step_out()
--         end,
--         desc = "Step Out",
--       },
--       {
--         "<leader>do",
--         function()
--           require("dap").step_over()
--         end,
--         desc = "Step Over",
--       },
--       {
--         "<leader>da",
--         function()
--           if vim.fn.filereadable(".vscode/launch.json") then
--             local dap_vscode = require("dap.ext.vscode")
--             dap_vscode.load_launchjs(nil, {
--               ["pwa-node"] = js_based_languages,
--               ["firefox"] = js_based_languages,
--               ["pwa-chrome"] = js_based_languages,
--             })
--           end
--           require("dap").continue()
--         end,
--         desc = "Run with Args",
--       },
--     },
--     dependencies = {
--       -- Install the vscode-js-debug adapter
--       {
--         "microsoft/vscode-js-debug",
--         -- After install, build it and rename the dist directory to out
--         build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
--         version = "1.*",
--       },
--       {
--         "mxsdev/nvim-dap-vscode-js",
--         config = function()
--           ---@diagnostic disable-next-line: missing-fields
--           require("dap-vscode-js").setup({
--             -- Path of node executable. Defaults to $NODE_PATH, and then "node"
--             -- node_path = "node",
--
--             -- Path to vscode-js-debug installation.
--             debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
--
--             -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
--             -- debugger_cmd = { "js-debug-adapter" },
--
--             -- which adapters to register in nvim-dap
--             adapters = {
--               "firefox",
--               "pwa-node",
--               "pwa-chrome",
--               "pwa-msedge",
--               "pwa-extensionHost",
--               "node-terminal",
--             },
--
--             -- Path for file logging
--             -- log_file_path = "(stdpath cache)/dap_vscode_js.log",
--
--             -- Logging level for output to file. Set to false to disable logging.
--             -- log_file_level = false,
--
--             -- Logging level for output to console. Set to false to disable console output.
--             -- log_console_level = vim.log.levels.ERROR,
--           })
--         end,
--       },
--       {
--         "Joakker/lua-json5",
--         build = "./install.sh",
--       },
--     },
--   },
-- }
