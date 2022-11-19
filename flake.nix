{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    melange.url = "github:melange-re/melange";
  };

  outputs = { self, ... }@inputs:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      createDevShell = system:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
        in
        pkgs.mkShell {
          buildInputs = [
            pkgs.ocaml
            pkgs.ocamlPackages.findlib
            pkgs.dune_3
            pkgs.ocamlPackages.ocaml-lsp
            pkgs.ocamlformat
            pkgs.ocamlPackages.ocamlformat-rpc-lib
            pkgs.ocamlPackages.utop
            pkgs.dot-merlin-reader

            inputs.melange.packages.${system}.mel

            pkgs.nodejs
            pkgs.yarn
          ];

          shellHook = ''
            ln -sfn ${inputs.melange.packages.${system}.melange}/lib/melange/runtime node_modules/melange
          '';
        };
    in
    {
      devShell = inputs.nixpkgs.lib.genAttrs supportedSystems createDevShell;
    };
}
