final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pyFinal: pyPrev: {
      passage-conf = pyFinal.callPackage ./lib/passage-conf/default.nix {};
      passagemath-brial = pyFinal.callPackage ./lib/passagemath-brial/default.nix {};
      passagemath-categories = pyFinal.callPackage ./lib/passagemath-categories/default.nix {};
      passagemath-cddlib = pyFinal.callPackage ./lib/passagemath-cddlib/default.nix {};
      passagemath-cliquer = pyFinal.callPackage ./lib/passagemath-cliquer/default.nix {};
      passagemath-combinat = pyFinal.callPackage ./lib/passagemath-combinat/default.nix {};
      passagemath-ecl = pyFinal.callPackage ./lib/passagemath-ecl/default.nix {};
      passagemath-eclib = pyFinal.callPackage ./lib/passagemath-eclib/default.nix {};
      passagemath-environment = pyFinal.callPackage ./lib/passagemath-environment/default.nix {};
      passagemath-flint = pyFinal.callPackage ./lib/passagemath-flint/default.nix {};
      passagemath-gap = pyFinal.callPackage ./lib/passagemath-gap/default.nix {};
      passagemath-gap-pkg-ctbllib-data = pyFinal.callPackage ./lib/passagemath-gap-pkg-ctbllib-data/default.nix {};
      passagemath-gap-pkg-factint-data = pyFinal.callPackage ./lib/passagemath-gap-pkg-factint-data/default.nix {};
      passagemath-gap-pkg-irredsol-data = pyFinal.callPackage ./lib/passagemath-gap-pkg-irredsol-data/default.nix {};
      passagemath-gap-pkg-primgrp-data = pyFinal.callPackage ./lib/passagemath-gap-pkg-primgrp-data/default.nix {};
      passagemath-gap-pkg-smallgrp-data = pyFinal.callPackage ./lib/passagemath-gap-pkg-smallgrp-data/default.nix {};
      passagemath-gap-pkg-tomlib-data = pyFinal.callPackage ./lib/passagemath-gap-pkg-tomlib-data/default.nix {};
      passagemath-gap-pkg-transgrp-data = pyFinal.callPackage ./lib/passagemath-gap-pkg-transgrp-data/default.nix {};
      passagemath-glpk = pyFinal.callPackage ./lib/passagemath-glpk/default.nix {};
      passagemath-graphs = pyFinal.callPackage ./lib/passagemath-graphs/default.nix {};
      passagemath-groups = pyFinal.callPackage ./lib/passagemath-groups/default.nix {};
      passagemath-gsl = pyFinal.callPackage ./lib/passagemath-gsl/default.nix {};
      passagemath-highs = pyFinal.callPackage ./lib/passagemath-highs/default.nix {};
      passagemath-homfly = pyFinal.callPackage ./lib/passagemath-homfly/default.nix {};
      jupyter-threejs-sage = pyFinal.callPackage ./lib/jupyter-threejs-sage/default.nix {};
      passagemath-iml = pyFinal.callPackage ./lib/passagemath-iml/default.nix {};
      passagemath-lcalc = pyFinal.callPackage ./lib/passagemath-lcalc/default.nix {};
      passagemath-libbraiding = pyFinal.callPackage ./lib/passagemath-libbraiding/default.nix {};
      passagemath-libecm = pyFinal.callPackage ./lib/passagemath-libecm/default.nix {};
      passagemath-linbox = pyFinal.callPackage ./lib/passagemath-linbox/default.nix {};
      lrcalc = pyFinal.callPackage ./lib/lrcalc/default.nix {};
      passagemath-m4ri-m4rie = pyFinal.callPackage ./lib/passagemath-m4ri-m4rie/default.nix {};
      passagemath-maxima = pyFinal.callPackage ./lib/passagemath-maxima/default.nix {};
      passagemath-modules = pyFinal.callPackage ./lib/passagemath-modules/default.nix {};
      passagemath-nauty = pyFinal.callPackage ./lib/passagemath-nauty/default.nix {};
      passagemath-ntl = pyFinal.callPackage ./lib/passagemath-ntl/default.nix {};
      passagemath-objects = pyFinal.callPackage ./lib/passagemath-objects/default.nix {};
      passagemath-palp = pyFinal.callPackage ./lib/passagemath-palp/default.nix {};
      passagemath-pari = pyFinal.callPackage ./lib/passagemath-pari/default.nix {};
      passagemath-pari-galdata = pyFinal.callPackage ./lib/passagemath-pari-galdata/default.nix {};
      passagemath-pari-seadata-small = pyFinal.callPackage ./lib/passagemath-pari-seadata-small/default.nix {};
      passagemath-planarity = pyFinal.callPackage ./lib/passagemath-planarity/default.nix {};
      passagemath-plot = pyFinal.callPackage ./lib/passagemath-plot/default.nix {};
      passagemath-polyhedra = pyFinal.callPackage ./lib/passagemath-polyhedra/default.nix {};
      passagemath-ppl = pyFinal.callPackage ./lib/passagemath-ppl/default.nix {};
      passagemath-primesieve-primecount = pyFinal.callPackage ./lib/passagemath-primesieve-primecount/default.nix {};
      passagemath-repl = pyFinal.callPackage ./lib/passagemath-repl/default.nix {};
      passagemath-schemes = pyFinal.callPackage ./lib/passagemath-schemes/default.nix {};
      passagemath-singular = pyFinal.callPackage ./lib/passagemath-singular/default.nix {};
      passagemath-standard = pyFinal.callPackage ./lib/passagemath-standard/default.nix {};
      passagemath-standard-no-symbolics = pyFinal.callPackage ./lib/passagemath-standard-no-symbolics/default.nix {};
      passagemath-symbolics = pyFinal.callPackage ./lib/passagemath-symbolics/default.nix {};
      passagemath-tachyon = pyFinal.callPackage ./lib/passagemath-tachyon/default.nix {};

      # Downgrades
      memory-allocator = pyFinal.callPackage ./lib/memory-allocator/default.nix {};
      mpmath = pyFinal.callPackage ./lib/mpmath/default.nix {};
    }
  )];
}

