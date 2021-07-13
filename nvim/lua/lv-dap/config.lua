O.plugin.dap = {
  active = false,
  adapters = {
   javascript = {
     type = 'executable',
     command = 'node',
     args = {os.getenv('HOME') .. '/tools/vscode-node-debug2/out/src/nodeDebug.js'},
   }
  },
  breakpoint = {
    text = "",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  },
  configurations = {
    javascript = {
      {
        name = 'Attach Job-Processor',
        type = 'node2',
        request = 'attach',
        port = 9230
      },
    }
  }
}
