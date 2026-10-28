{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # To import an internal flake module: ./other.nix
        # To import an external flake module:
        #   1. Add foo to inputs
        #   2. Add foo as a parameter to the outputs function
        #   3. Add here: foo.flakeModule

      ];
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages = {
          default = config.packages.passagemath-standard;

          passage-bootstrap = (import ./lib/passage-bootstrap/default.nix) pkgs;
          passage-conf = (import ./lib/passage-conf/default.nix) pkgs;
          passage-conf_conda = (import ./lib/passage-conf_conda/default.nix) pkgs;
          passage-conf_pypi = (import ./lib/passage-conf_pypi/default.nix) pkgs;
          passage-docbuild = (import ./lib/passage-docbuild/default.nix) pkgs;
          passagemath-benzene = (import ./lib/passagemath-benzene/default.nix) pkgs;
          passagemath-bliss = (import ./lib/passagemath-bliss/default.nix) pkgs;
          passagemath-brial = (import ./lib/passagemath-brial/default.nix) pkgs;
          passagemath-categories = (import ./lib/passagemath-categories/default.nix) pkgs;
          passagemath-cddlib = (import ./lib/passagemath-cddlib/default.nix) pkgs;
          passagemath-cliquer = (import ./lib/passagemath-cliquer/default.nix) pkgs;
          passagemath-cmr = (import ./lib/passagemath-cmr/default.nix) pkgs;
          passagemath-combinat = (import ./lib/passagemath-combinat/default.nix) pkgs;
          passagemath-coxeter3 = (import ./lib/passagemath-coxeter3/default.nix) pkgs;
          passagemath-database-cremona-ellcurve = (import ./lib/passagemath-database-cremona-ellcurve/default.nix) pkgs;
          passagemath-database-cunningham = (import ./lib/passagemath-database-cunningham/default.nix) pkgs;
          passagemath-database-jones-numfield = (import ./lib/passagemath-database-jones-numfield/default.nix) pkgs;
          passagemath-database-kohel = (import ./lib/passagemath-database-kohel/default.nix) pkgs;
          passagemath-database-mutation-class = (import ./lib/passagemath-database-mutation-class/default.nix) pkgs;
          passagemath-database-odlyzko-zeta = (import ./lib/passagemath-database-odlyzko-zeta/default.nix) pkgs;
          passagemath-database-polytopes-4d = (import ./lib/passagemath-database-polytopes-4d/default.nix) pkgs;
          passagemath-database-stein-watkins = (import ./lib/passagemath-database-stein-watkins/default.nix) pkgs;
          passagemath-database-stein-watkins-mini = (import ./lib/passagemath-database-stein-watkins-mini/default.nix) pkgs;
          passagemath-database-symbolic-data = (import ./lib/passagemath-database-symbolic-data/default.nix) pkgs;
          passagemath-doc-html = (import ./lib/passagemath-doc-html/default.nix) pkgs;
          passagemath-doc-pdf = (import ./lib/passagemath-doc-pdf/default.nix) pkgs;
          passagemath-ecl = (import ./lib/passagemath-ecl/default.nix) pkgs;
          passagemath-eclib = (import ./lib/passagemath-eclib/default.nix) pkgs;
          passagemath-environment = (import ./lib/passagemath-environment/default.nix) pkgs;
          passagemath-flint = (import ./lib/passagemath-flint/default.nix) pkgs;
          passagemath-fricas = (import ./lib/passagemath-fricas/default.nix) pkgs;
          passagemath-frobby = (import ./lib/passagemath-frobby/default.nix) pkgs;
          passagemath-gap = (import ./lib/passagemath-gap/default.nix) pkgs;
          passagemath-gap3 = (import ./lib/passagemath-gap3/default.nix) pkgs;
          passagemath-gap-pkg-agt-data = (import ./lib/passagemath-gap-pkg-agt-data/default.nix) pkgs;
          passagemath-gap-pkg-caratinterface = (import ./lib/passagemath-gap-pkg-caratinterface/default.nix) pkgs;
          passagemath-gap-pkg-cddinterface = (import ./lib/passagemath-gap-pkg-cddinterface/default.nix) pkgs;
          passagemath-gap-pkg-ctbllib-data = (import ./lib/passagemath-gap-pkg-ctbllib-data/default.nix) pkgs;
          passagemath-gap-pkg-curlinterface = (import ./lib/passagemath-gap-pkg-curlinterface/default.nix) pkgs;
          passagemath-gap-pkg-difsets-data = (import ./lib/passagemath-gap-pkg-difsets-data/default.nix) pkgs;
          passagemath-gap-pkg-factint-data = (import ./lib/passagemath-gap-pkg-factint-data/default.nix) pkgs;
          passagemath-gap-pkg-float = (import ./lib/passagemath-gap-pkg-float/default.nix) pkgs;
          passagemath-gap-pkg-irredsol-data = (import ./lib/passagemath-gap-pkg-irredsol-data/default.nix) pkgs;
          passagemath-gap-pkg-normalizinterface = (import ./lib/passagemath-gap-pkg-normalizinterface/default.nix) pkgs;
          passagemath-gap-pkg-numericalsgps-data = (import ./lib/passagemath-gap-pkg-numericalsgps-data/default.nix) pkgs;
          passagemath-gap-pkg-perfgrp-data = (import ./lib/passagemath-gap-pkg-perfgrp-data/default.nix) pkgs;
          passagemath-gap-pkg-primgrp-data = (import ./lib/passagemath-gap-pkg-primgrp-data/default.nix) pkgs;
          passagemath-gap-pkg-rcwa-data = (import ./lib/passagemath-gap-pkg-rcwa-data/default.nix) pkgs;
          passagemath-gap-pkg-semigroups = (import ./lib/passagemath-gap-pkg-semigroups/default.nix) pkgs;
          passagemath-gap-pkg-sglppow-data = (import ./lib/passagemath-gap-pkg-sglppow-data/default.nix) pkgs;
          passagemath-gap-pkg-simpcomp-data = (import ./lib/passagemath-gap-pkg-simpcomp-data/default.nix) pkgs;
          passagemath-gap-pkg-smallgrp-data = (import ./lib/passagemath-gap-pkg-smallgrp-data/default.nix) pkgs;
          passagemath-gap-pkg-smallsemi-data = (import ./lib/passagemath-gap-pkg-smallsemi-data/default.nix) pkgs;
          passagemath-gap-pkg-sonata-data = (import ./lib/passagemath-gap-pkg-sonata-data/default.nix) pkgs;
          passagemath-gap-pkg-tomlib-data = (import ./lib/passagemath-gap-pkg-tomlib-data/default.nix) pkgs;
          passagemath-gap-pkg-transgrp-data = (import ./lib/passagemath-gap-pkg-transgrp-data/default.nix) pkgs;
          passagemath-gap-pkg-unitlib-data = (import ./lib/passagemath-gap-pkg-unitlib-data/default.nix) pkgs;
          passagemath-gap-pkg-yangbaxter-data = (import ./lib/passagemath-gap-pkg-yangbaxter-data/default.nix) pkgs;
          passagemath-gfan = (import ./lib/passagemath-gfan/default.nix) pkgs;
          passagemath-giac = (import ./lib/passagemath-giac/default.nix) pkgs;
          passagemath-glpk = (import ./lib/passagemath-glpk/default.nix) pkgs;
          passagemath-glucose = (import ./lib/passagemath-glucose/default.nix) pkgs;
          passagemath-graphs = (import ./lib/passagemath-graphs/default.nix) pkgs;
          passagemath-graphviz = (import ./lib/passagemath-graphviz/default.nix) pkgs;
          passagemath-groups = (import ./lib/passagemath-groups/default.nix) pkgs;
          passagemath-gsl = (import ./lib/passagemath-gsl/default.nix) pkgs;
          passagemath-highs = (import ./lib/passagemath-highs/default.nix) pkgs;
          passagemath-homfly = (import ./lib/passagemath-homfly/default.nix) pkgs;
          passagemath-iml = (import ./lib/passagemath-iml/default.nix) pkgs;
          passagemath-kenzo = (import ./lib/passagemath-kenzo/default.nix) pkgs;
          passagemath-kissat = (import ./lib/passagemath-kissat/default.nix) pkgs;
          passagemath-latte-4ti2 = (import ./lib/passagemath-latte-4ti2/default.nix) pkgs;
          passagemath-lcalc = (import ./lib/passagemath-lcalc/default.nix) pkgs;
          passagemath-libbraiding = (import ./lib/passagemath-libbraiding/default.nix) pkgs;
          passagemath-libecm = (import ./lib/passagemath-libecm/default.nix) pkgs;
          passagemath-lie = (import ./lib/passagemath-lie/default.nix) pkgs;
          passagemath-linbox = (import ./lib/passagemath-linbox/default.nix) pkgs;
          passagemath-lrslib = (import ./lib/passagemath-lrslib/default.nix) pkgs;
          passagemath-m4ri-m4rie = (import ./lib/passagemath-m4ri-m4rie/default.nix) pkgs;
          passagemath-macaulay2 = (import ./lib/passagemath-macaulay2/default.nix) pkgs;
          passagemath-macaulay2-doc = (import ./lib/passagemath-macaulay2-doc/default.nix) pkgs;
          passagemath-mathilda = (import ./lib/passagemath-mathilda/default.nix) pkgs;
          passagemath-maxima = (import ./lib/passagemath-maxima/default.nix) pkgs;
          passagemath-mcqd = (import ./lib/passagemath-mcqd/default.nix) pkgs;
          passagemath-meataxe = (import ./lib/passagemath-meataxe/default.nix) pkgs;
          passagemath-modules = (import ./lib/passagemath-modules/default.nix) pkgs;
          passagemath-msolve = (import ./lib/passagemath-msolve/default.nix) pkgs;
          passagemath-nauty = (import ./lib/passagemath-nauty/default.nix) pkgs;
          passagemath-ntl = (import ./lib/passagemath-ntl/default.nix) pkgs;
          passagemath-objects = (import ./lib/passagemath-objects/default.nix) pkgs;
          passagemath-palp = (import ./lib/passagemath-palp/default.nix) pkgs;
          passagemath-pari = (import ./lib/passagemath-pari/default.nix) pkgs;
          passagemath-pari-elldata = (import ./lib/passagemath-pari-elldata/default.nix) pkgs;
          passagemath-pari-galdata = (import ./lib/passagemath-pari-galdata/default.nix) pkgs;
          passagemath-pari-galpol = (import ./lib/passagemath-pari-galpol/default.nix) pkgs;
          passagemath-pari-nflistdata = (import ./lib/passagemath-pari-nflistdata/default.nix) pkgs;
          passagemath-pari-nftables = (import ./lib/passagemath-pari-nftables/default.nix) pkgs;
          passagemath-pari-seadata = (import ./lib/passagemath-pari-seadata/default.nix) pkgs;
          passagemath-pari-seadata-big = (import ./lib/passagemath-pari-seadata-big/default.nix) pkgs;
          passagemath-pari-seadata-small = (import ./lib/passagemath-pari-seadata-small/default.nix) pkgs;
          passagemath-planarity = (import ./lib/passagemath-planarity/default.nix) pkgs;
          passagemath-plantri = (import ./lib/passagemath-plantri/default.nix) pkgs;
          passagemath-plot = (import ./lib/passagemath-plot/default.nix) pkgs;
          passagemath-polyhedra = (import ./lib/passagemath-polyhedra/default.nix) pkgs;
          passagemath-polymake = (import ./lib/passagemath-polymake/default.nix) pkgs;
          passagemath-qepcad = (import ./lib/passagemath-qepcad/default.nix) pkgs;
          passagemath-rankwidth = (import ./lib/passagemath-rankwidth/default.nix) pkgs;
          passagemath-repl = (import ./lib/passagemath-repl/default.nix) pkgs;
          passagemath-rubiks = (import ./lib/passagemath-rubiks/default.nix) pkgs;
          passagemath-schemes = (import ./lib/passagemath-schemes/default.nix) pkgs;
          passagemath-singular = (import ./lib/passagemath-singular/default.nix) pkgs;
          passagemath-sirocco = (import ./lib/passagemath-sirocco/default.nix) pkgs;
          passagemath-standard = (import ./lib/passagemath-standard/default.nix) pkgs;
          passagemath-standard-no-symbolics = (import ./lib/passagemath-standard-no-symbolics/default.nix) pkgs;
          passagemath-symbolics = (import ./lib/passagemath-symbolics/default.nix) pkgs;
          passagemath-sympow = (import ./lib/passagemath-sympow/default.nix) pkgs;
          passagemath-tachyon = (import ./lib/passagemath-tachyon/default.nix) pkgs;
          passagemath-tdlib = (import ./lib/passagemath-tdlib/default.nix) pkgs;
          passagemath-tides = (import ./lib/passagemath-tides/default.nix) pkgs;
          passagemath-topcom = (import ./lib/passagemath-topcom/default.nix) pkgs;
          passage-project-cookiecutter = (import ./lib/passage-project-cookiecutter/default.nix) pkgs;
          passage-setup = (import ./lib/passage-setup/default.nix) pkgs;
          passage-sws2rst = (import ./lib/passage-sws2rst/default.nix) pkgs;
          memory-allocator = (import ./lib/memory-allocator/default.nix) pkgs;
        };

        devShells = {
          default = pkgs.mkShellNoCC {
            packages = [ (pkgs.python3.withPackages (pypkgs: [
              pypkgs.ipython
              self'.packages.passagemath-objects
              self'.packages.passagemath-environment
            ])) ];
          };
        };
      };
    };
}
