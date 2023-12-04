{
  description = "Advent of Code 2023";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          alejandra

          # racket is currently broken
          # racket-minimal

          haskell.compiler.ghc94
          haskellPackages.lsp
          haskellPackages.haskell-language-server
          haskellPackages.cabal-install

          guile

          python3
        ];
      };
    });
}
