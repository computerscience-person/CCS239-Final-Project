{
  description = "The base nix flake.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs =
    { nixpkgs, ... }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      eachSystem = nixpkgs.lib.genAttrs systems;
      withPkgs = system: nixpkgs.legacyPackages.${system};
    in
    {
      devShells = eachSystem (
        system:
        let
          pkgs = withPkgs system;
          julia' =
            (pkgs.julia.withPackages.override {
              precompile = false;
              augmentedRegistry = pkgs.callPackage ./registry.nix { };
            })
              [
                "LanguageServer"
                "Pluto"
                "PlutoUI"
                "Plots"
              ];
        in
        {
          default = pkgs.mkShell {
            packages = [ ];
            nativeBuildInputs = [ julia' ];
          };
        }
      );
    };
}
