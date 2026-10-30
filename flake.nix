{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }@osConfig: {
        packages = 
          let
            pkgs' = pkgs.extend self.overlays.default;
          in
          {
            default = config.packages.passagemath-standard;
            testDerivation = pkgs.python3.withPackages (_: [ self'.packages.passagemath-standard ]);

            passage-conf = pkgs'.python3Packages.passage-conf;
            passagemath-brial = pkgs'.python3Packages.passagemath-brial;
            passagemath-categories = pkgs'.python3Packages.passagemath-categories;
            passagemath-cddlib = pkgs'.python3Packages.passagemath-cddlib;
            passagemath-cliquer = pkgs'.python3Packages.passagemath-cliquer;
            passagemath-combinat = pkgs'.python3Packages.passagemath-combinat;
            passagemath-ecl = pkgs'.python3Packages.passagemath-ecl;
            passagemath-eclib = pkgs'.python3Packages.passagemath-eclib;
            passagemath-environment = pkgs'.python3Packages.passagemath-environment;
            passagemath-flint = pkgs'.python3Packages.passagemath-flint;
            passagemath-gap = pkgs'.python3Packages.passagemath-gap;
            passagemath-gap-pkg-ctbllib-data = pkgs'.python3Packages.passagemath-gap-pkg-ctbllib-data;
            passagemath-gap-pkg-factint-data = pkgs'.python3Packages.passagemath-gap-pkg-factint-data;
            passagemath-gap-pkg-irredsol-data = pkgs'.python3Packages.passagemath-gap-pkg-irredsol-data;
            passagemath-gap-pkg-primgrp-data = pkgs'.python3Packages.passagemath-gap-pkg-primgrp-data;
            passagemath-gap-pkg-smallgrp-data = pkgs'.python3Packages.passagemath-gap-pkg-smallgrp-data;
            passagemath-gap-pkg-tomlib-data = pkgs'.python3Packages.passagemath-gap-pkg-tomlib-data;
            passagemath-gap-pkg-transgrp-data = pkgs'.python3Packages.passagemath-gap-pkg-transgrp-data;
            passagemath-glpk = pkgs'.python3Packages.passagemath-glpk;
            passagemath-graphs = pkgs'.python3Packages.passagemath-graphs;
            passagemath-groups = pkgs'.python3Packages.passagemath-groups;
            passagemath-gsl = pkgs'.python3Packages.passagemath-gsl;
            passagemath-highs = pkgs'.python3Packages.passagemath-highs;
            passagemath-homfly = pkgs'.python3Packages.passagemath-homfly;
            jupyter-threejs-sage = pkgs'.python3Packages.jupyter-threejs-sage;
            passagemath-iml = pkgs'.python3Packages.passagemath-iml;
            passagemath-lcalc = pkgs'.python3Packages.passagemath-lcalc;
            passagemath-libbraiding = pkgs'.python3Packages.passagemath-libbraiding;
            passagemath-libecm = pkgs'.python3Packages.passagemath-libecm;
            passagemath-linbox = pkgs'.python3Packages.passagemath-linbox;
            passagemath-m4ri-m4rie = pkgs'.python3Packages.passagemath-m4ri-m4rie;
            passagemath-maxima = pkgs'.python3Packages.passagemath-maxima;
            passagemath-modules = pkgs'.python3Packages.passagemath-modules;
            passagemath-nauty = pkgs'.python3Packages.passagemath-nauty;
            passagemath-ntl = pkgs'.python3Packages.passagemath-ntl;
            passagemath-objects = pkgs'.python3Packages.passagemath-objects;
            passagemath-palp = pkgs'.python3Packages.passagemath-palp;
            passagemath-pari = pkgs'.python3Packages.passagemath-pari;
            passagemath-pari-galdata = pkgs'.python3Packages.passagemath-pari-galdata;
            passagemath-pari-seadata-small = pkgs'.python3Packages.passagemath-pari-seadata-small;
            passagemath-planarity = pkgs'.python3Packages.passagemath-planarity;
            passagemath-plot = pkgs'.python3Packages.passagemath-plot;
            passagemath-polyhedra = pkgs'.python3Packages.passagemath-polyhedra;
            passagemath-ppl = pkgs'.python3Packages.passagemath-ppl;
            passagemath-primesieve-primecount = pkgs'.python3Packages.passagemath-primesieve-primecount;
            passagemath-repl = pkgs'.python3Packages.passagemath-repl;
            passagemath-schemes = pkgs'.python3Packages.passagemath-schemes;
            passagemath-singular = pkgs'.python3Packages.passagemath-singular;
            passagemath-standard = pkgs'.python3Packages.passagemath-standard;
            passagemath-standard-no-symbolics = pkgs'.python3Packages.passagemath-standard-no-symbolics;
            passagemath-symbolics = pkgs'.python3Packages.passagemath-symbolics;
            passagemath-tachyon = pkgs'.python3Packages.passagemath-tachyon;

            memory-allocator = pkgs'.python3Packages.memory-allocator;
            mpmath = pkgs'.python3Packages.mpmath;
            lrcalc = pkgs'.python3Packages.lrcalc;
          };


        devShells = (import ./devShells.nix) osConfig;
      };

      flake.overlays.default = import ./overlay.nix;
    };
}
