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
            pkgs.nodejs
            pkgs.yarn

            pkgs.ocaml
            pkgs.ocamlPackages.findlib
            pkgs.dune_3

            inputs.melange.packages.${system}.mel
            inputs.melange.packages.${system}.melange
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
