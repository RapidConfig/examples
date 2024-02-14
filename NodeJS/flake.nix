{
  description = "A demo node flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs
              nodePackages.cat-me
            ];
            shellHook = ''
              node -e 'let ascii_text_generator = require('ascii-text-generator'); console.log(ascii_text_generator("NodeJS"));'
            '';
          };
        }
      );
}