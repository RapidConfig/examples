{
  description = "A demo python flake";

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
              python310
              python310Packages.pyfiglet
              cowsay
            ];
            shellHook = ''
              python -c 'import pyfiglet; print(pyfiglet.figlet_format("Python"))'
            '';
          };
        }
      );
}