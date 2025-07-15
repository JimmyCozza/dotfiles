{ pkgs, ... }:

pkgs.writeShellScriptBin "claude-code" ''
  exec ${pkgs.nodejs}/bin/npx @anthropic-ai/claude-code@latest "$@"
''
