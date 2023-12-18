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

          racket

          haskell.compiler.ghc94
          haskellPackages.lsp
          haskellPackages.haskell-language-server
          haskellPackages.cabal-install

          python311
          python311Packages.pytest
          python311Packages.python-lsp-server

          # ocaml
          # dune_3
          # ocamlPackages.ocamlformat_0_26_0
          # ocamlPackages.lsp

          luajit
          luajitPackages.luarocks
        ];

        shellHook = ''
          alias lua = luajit
        '';
      };
    });
}
