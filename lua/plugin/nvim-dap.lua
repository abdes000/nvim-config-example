return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    -- Example: Python adapter
    dap.adapters.python = {
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        console = "integratedTerminal",
      },
    }

    -- Example: Node.js adapter
    dap.adapters.node2 = {
      type = "executable",
      command = "node",
      args = { os.getenv("HOME") .. "/vscode-node-debug2/out/src/nodeDebug.js" },
    }

    dap.configurations.javascript = {
      {
        type = "node2",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = vim.fn.getcwd(),
      },
    }
  end,
}