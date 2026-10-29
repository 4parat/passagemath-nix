{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages = 
          let
            pkgs' = pkgs.extend self.overlays.default;
          in
          {
            default = config.packages.passagemath-standard;
            testDerivation = pkgs.python3.withPackages (_: [ self'.packages.passagemath-standard ]);

            passage-bootstrap = pkgs'.python3Packages.passage-bootstrap;
            passage-conf = pkgs'.python3Packages.passage-conf;
            passage-conf_conda = pkgs'.python3Packages.passage-conf_conda;
            passage-conf_pypi = pkgs'.python3Packages.passage-conf_pypi;
            passage-docbuild = pkgs'.python3Packages.passage-docbuild;
            passagemath-benzene = pkgs'.python3Packages.passagemath-benzene;
            passagemath-bliss = pkgs'.python3Packages.passagemath-bliss;
            passagemath-brial = pkgs'.python3Packages.passagemath-brial;
            passagemath-categories = pkgs'.python3Packages.passagemath-categories;
            passagemath-cddlib = pkgs'.python3Packages.passagemath-cddlib;
            passagemath-cliquer = pkgs'.python3Packages.passagemath-cliquer;
            passagemath-cmr = pkgs'.python3Packages.passagemath-cmr;
            passagemath-combinat = pkgs'.python3Packages.passagemath-combinat;
            passagemath-coxeter3 = pkgs'.python3Packages.passagemath-coxeter3;
            passagemath-database-cremona-ellcurve = pkgs'.python3Packages.passagemath-database-cremona-ellcurve;
            passagemath-database-cunningham = pkgs'.python3Packages.passagemath-database-cunningham;
            passagemath-database-jones-numfield = pkgs'.python3Packages.passagemath-database-jones-numfield;
            passagemath-database-kohel = pkgs'.python3Packages.passagemath-database-kohel;
            passagemath-database-mutation-class = pkgs'.python3Packages.passagemath-database-mutation-class;
            passagemath-database-odlyzko-zeta = pkgs'.python3Packages.passagemath-database-odlyzko-zeta;
            passagemath-database-polytopes-4d = pkgs'.python3Packages.passagemath-database-polytopes-4d;
            passagemath-database-stein-watkins = pkgs'.python3Packages.passagemath-database-stein-watkins;
            passagemath-database-stein-watkins-mini = pkgs'.python3Packages.passagemath-database-stein-watkins-mini;
            passagemath-database-symbolic-data = pkgs'.python3Packages.passagemath-database-symbolic-data;
            passagemath-doc-html = pkgs'.python3Packages.passagemath-doc-html;
            passagemath-doc-pdf = pkgs'.python3Packages.passagemath-doc-pdf;
            passagemath-ecl = pkgs'.python3Packages.passagemath-ecl;
            passagemath-eclib = pkgs'.python3Packages.passagemath-eclib;
            passagemath-environment = pkgs'.python3Packages.passagemath-environment;
            passagemath-flint = pkgs'.python3Packages.passagemath-flint;
            passagemath-fricas = pkgs'.python3Packages.passagemath-fricas;
            passagemath-frobby = pkgs'.python3Packages.passagemath-frobby;
            passagemath-gap = pkgs'.python3Packages.passagemath-gap;
            passagemath-gap3 = pkgs'.python3Packages.passagemath-gap3;
            passagemath-gap-pkg-agt-data = pkgs'.python3Packages.passagemath-gap-pkg-agt-data;
            passagemath-gap-pkg-caratinterface = pkgs'.python3Packages.passagemath-gap-pkg-caratinterface;
            passagemath-gap-pkg-cddinterface = pkgs'.python3Packages.passagemath-gap-pkg-cddinterface;
            passagemath-gap-pkg-ctbllib-data = pkgs'.python3Packages.passagemath-gap-pkg-ctbllib-data;
            passagemath-gap-pkg-curlinterface = pkgs'.python3Packages.passagemath-gap-pkg-curlinterface;
            passagemath-gap-pkg-difsets-data = pkgs'.python3Packages.passagemath-gap-pkg-difsets-data;
            passagemath-gap-pkg-factint-data = pkgs'.python3Packages.passagemath-gap-pkg-factint-data;
            passagemath-gap-pkg-float = pkgs'.python3Packages.passagemath-gap-pkg-float;
            passagemath-gap-pkg-irredsol-data = pkgs'.python3Packages.passagemath-gap-pkg-irredsol-data;
            passagemath-gap-pkg-normalizinterface = pkgs'.python3Packages.passagemath-gap-pkg-normalizinterface;
            passagemath-gap-pkg-numericalsgps-data = pkgs'.python3Packages.passagemath-gap-pkg-numericalsgps-data;
            passagemath-gap-pkg-perfgrp-data = pkgs'.python3Packages.passagemath-gap-pkg-perfgrp-data;
            passagemath-gap-pkg-primgrp-data = pkgs'.python3Packages.passagemath-gap-pkg-primgrp-data;
            passagemath-gap-pkg-rcwa-data = pkgs'.python3Packages.passagemath-gap-pkg-rcwa-data;
            passagemath-gap-pkg-semigroups = pkgs'.python3Packages.passagemath-gap-pkg-semigroups;
            passagemath-gap-pkg-sglppow-data = pkgs'.python3Packages.passagemath-gap-pkg-sglppow-data;
            passagemath-gap-pkg-simpcomp-data = pkgs'.python3Packages.passagemath-gap-pkg-simpcomp-data;
            passagemath-gap-pkg-smallgrp-data = pkgs'.python3Packages.passagemath-gap-pkg-smallgrp-data;
            passagemath-gap-pkg-smallsemi-data = pkgs'.python3Packages.passagemath-gap-pkg-smallsemi-data;
            passagemath-gap-pkg-sonata-data = pkgs'.python3Packages.passagemath-gap-pkg-sonata-data;
            passagemath-gap-pkg-tomlib-data = pkgs'.python3Packages.passagemath-gap-pkg-tomlib-data;
            passagemath-gap-pkg-transgrp-data = pkgs'.python3Packages.passagemath-gap-pkg-transgrp-data;
            passagemath-gap-pkg-unitlib-data = pkgs'.python3Packages.passagemath-gap-pkg-unitlib-data;
            passagemath-gap-pkg-yangbaxter-data = pkgs'.python3Packages.passagemath-gap-pkg-yangbaxter-data;
            passagemath-gfan = pkgs'.python3Packages.passagemath-gfan;
            passagemath-giac = pkgs'.python3Packages.passagemath-giac;
            passagemath-glpk = pkgs'.python3Packages.passagemath-glpk;
            passagemath-glucose = pkgs'.python3Packages.passagemath-glucose;
            passagemath-graphs = pkgs'.python3Packages.passagemath-graphs;
            passagemath-graphviz = pkgs'.python3Packages.passagemath-graphviz;
            passagemath-groups = pkgs'.python3Packages.passagemath-groups;
            passagemath-gsl = pkgs'.python3Packages.passagemath-gsl;
            passagemath-highs = pkgs'.python3Packages.passagemath-highs;
            passagemath-homfly = pkgs'.python3Packages.passagemath-homfly;
            jupyter-threejs-sage = pkgs'.python3Packages.jupyter-threejs-sage;
            passagemath-iml = pkgs'.python3Packages.passagemath-iml;
            passagemath-kenzo = pkgs'.python3Packages.passagemath-kenzo;
            passagemath-kissat = pkgs'.python3Packages.passagemath-kissat;
            passagemath-latte-4ti2 = pkgs'.python3Packages.passagemath-latte-4ti2;
            passagemath-lcalc = pkgs'.python3Packages.passagemath-lcalc;
            passagemath-libbraiding = pkgs'.python3Packages.passagemath-libbraiding;
            passagemath-libecm = pkgs'.python3Packages.passagemath-libecm;
            passagemath-lie = pkgs'.python3Packages.passagemath-lie;
            passagemath-linbox = pkgs'.python3Packages.passagemath-linbox;
            passagemath-lrslib = pkgs'.python3Packages.passagemath-lrslib;
            passagemath-m4ri-m4rie = pkgs'.python3Packages.passagemath-m4ri-m4rie;
            passagemath-macaulay2 = pkgs'.python3Packages.passagemath-macaulay2;
            passagemath-macaulay2-doc = pkgs'.python3Packages.passagemath-macaulay2-doc;
            passagemath-mathilda = pkgs'.python3Packages.passagemath-mathilda;
            passagemath-maxima = pkgs'.python3Packages.passagemath-maxima;
            passagemath-mcqd = pkgs'.python3Packages.passagemath-mcqd;
            passagemath-meataxe = pkgs'.python3Packages.passagemath-meataxe;
            passagemath-modules = pkgs'.python3Packages.passagemath-modules;
            passagemath-msolve = pkgs'.python3Packages.passagemath-msolve;
            passagemath-nauty = pkgs'.python3Packages.passagemath-nauty;
            passagemath-ntl = pkgs'.python3Packages.passagemath-ntl;
            passagemath-objects = pkgs'.python3Packages.passagemath-objects;
            passagemath-palp = pkgs'.python3Packages.passagemath-palp;
            passagemath-pari = pkgs'.python3Packages.passagemath-pari;
            passagemath-pari-elldata = pkgs'.python3Packages.passagemath-pari-elldata;
            passagemath-pari-galdata = pkgs'.python3Packages.passagemath-pari-galdata;
            passagemath-pari-galpol = pkgs'.python3Packages.passagemath-pari-galpol;
            passagemath-pari-nflistdata = pkgs'.python3Packages.passagemath-pari-nflistdata;
            passagemath-pari-nftables = pkgs'.python3Packages.passagemath-pari-nftables;
            passagemath-pari-seadata = pkgs'.python3Packages.passagemath-pari-seadata;
            passagemath-pari-seadata-big = pkgs'.python3Packages.passagemath-pari-seadata-big;
            passagemath-pari-seadata-small = pkgs'.python3Packages.passagemath-pari-seadata-small;
            passagemath-planarity = pkgs'.python3Packages.passagemath-planarity;
            passagemath-plantri = pkgs'.python3Packages.passagemath-plantri;
            passagemath-plot = pkgs'.python3Packages.passagemath-plot;
            passagemath-polyhedra = pkgs'.python3Packages.passagemath-polyhedra;
            passagemath-polymake = pkgs'.python3Packages.passagemath-polymake;
            passagemath-ppl = pkgs'.python3Packages.passagemath-ppl;
            passagemath-primesieve-primecount = pkgs'.python3Packages.passagemath-primesieve-primecount;
            passagemath-qepcad = pkgs'.python3Packages.passagemath-qepcad;
            passagemath-rankwidth = pkgs'.python3Packages.passagemath-rankwidth;
            passagemath-repl = pkgs'.python3Packages.passagemath-repl;
            passagemath-rubiks = pkgs'.python3Packages.passagemath-rubiks;
            passagemath-schemes = pkgs'.python3Packages.passagemath-schemes;
            passagemath-singular = pkgs'.python3Packages.passagemath-singular;
            passagemath-sirocco = pkgs'.python3Packages.passagemath-sirocco;
            passagemath-standard = pkgs'.python3Packages.passagemath-standard;
            passagemath-standard-no-symbolics = pkgs'.python3Packages.passagemath-standard-no-symbolics;
            passagemath-symbolics = pkgs'.python3Packages.passagemath-symbolics;
            passagemath-sympow = pkgs'.python3Packages.passagemath-sympow;
            passagemath-tachyon = pkgs'.python3Packages.passagemath-tachyon;
            passagemath-tdlib = pkgs'.python3Packages.passagemath-tdlib;
            passagemath-tides = pkgs'.python3Packages.passagemath-tides;
            passagemath-topcom = pkgs'.python3Packages.passagemath-topcom;
            passage-project-cookiecutter = pkgs'.python3Packages.passage-project-cookiecutter;
            passage-setup = pkgs'.python3Packages.passage-setup;
            passage-sws2rst = pkgs'.python3Packages.passage-sws2rst;

            memory-allocator = pkgs'.python3Packages.memory-allocator;
            mpmath = pkgs'.python3Packages.mpmath;
            lrcalc = pkgs'.python3Packages.lrcalc;
          };


        devShells = {
          default = self'.devShells.test314;
          debug = pkgs.mkShellNoCC {
            packages = [
              (pkgs.python3.withPackages (pypkgs: [
                pypkgs.ipython
                pypkgs.requests
                pypkgs.pydot
                pypkgs.networkx
              ]))
              pkgs.nix-tree
              pkgs.graphviz
            ];
          };

          test313 = pkgs.mkShellNoCC {
            packages = [
              (pkgs.python313.withPackages (pypkgs: [
                self'.packages.passagemath-standard
                pypkgs.jupyter
                pypkgs.notebook
              ]))
              pkgs.dot2tex
              pkgs.gap
              pkgs.graphviz
              pkgs.meson
              pkgs.pari
              pkgs.singular
              pkgs.texliveSmall
            ];
          };
          test314 = pkgs.mkShellNoCC {
            packages = [
              (pkgs.python314.withPackages (pypkgs: [
                self'.packages.passagemath-standard
                pypkgs.jupyter
              ]))
              pkgs.pkg-config
              pkgs.fflas-ffpack
              pkgs.dot2tex
              pkgs.gap
              pkgs.graphviz
              pkgs.meson
              pkgs.pari
              pkgs.singular
              pkgs.texliveSmall
            ];
          };
        };
      };

      flake.overlays.default = import ./overlay.nix;
    };
}
