{ pkgs, ... }:

pkgs.writeShellScriptBin "gemini" ''
  exec ${pkgs.nodejs}/bin/npx @google/gemini-cli@latest "$@"
''