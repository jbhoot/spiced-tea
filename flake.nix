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
          pkgs =
            inputs.nixpkgs.legacyPackages.${system}.extend
              inputs.melange.overlays.default;
        in
        pkgs.mkShell {
          buildInputs = with pkgs.ocamlPackages; [
            ocaml
            findlib
            dune_3
            ocaml-lsp
            ocamlformat-rpc-lib
            utop
            dot-merlin-reader
            melange
            mel
            merlin

            pkgs.ocamlformat
            pkgs.nodejs
            pkgs.yarn
          ];

          shellHook = ''
            ln -sfn ${pkgs.ocamlPackages.melange}/lib/melange/runtime node_modules/melange
          '';
        };
    in
    {
      devShell = inputs.nixpkgs.lib.genAttrs supportedSystems createDevShell;
    };
}
