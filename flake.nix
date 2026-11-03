{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          conf-nixig,
          self',
          inputs',
          pkgs,
          system,
          ...
        }@osConfig:
        {
          formatter = pkgs.nixfmt-tree;
          packages =
            let
              pkgs' = self'.pkgs.native;
            in
            {
              default = conf-nixig.packages.passagemath-standard;
              testDerivation = pkgs.python3.withPackages (_: [ self'.packages.passagemath-standard ]);
              passagemath-standard = pkgs'.python3Packages.passagemath-standard;

              test1 = pkgs'.python3.withPackages (pypkgs: [
                pypkgs.ipython
                pypkgs.cython
                # pypkgs.passagemath-objects
                pypkgs.passagemath-standard
                pypkgs.passagemath-polyhedra
              ]);
              test2 = pkgs'.mkShell {
                packages = [ pkgs'.lrcalc ];
              };
            };

          devShells = (import ./devShells.nix) osConfig;
          pkgs.wheel = pkgs.extend self.overlays.wheel;
          pkgs.native = pkgs.extend self.overlays.native;
        };

      transposition.pkgs.adHoc = true;

      flake.overlays = {
        default = self.overlays.wheel;
        native = (import ./overlay.nix) { useWheel = false; };
        wheel = (import ./overlay.nix) { useWheel = true; };
      };
    };
}
