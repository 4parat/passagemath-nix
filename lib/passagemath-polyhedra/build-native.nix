{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  cysignals,
  gmpy2,
  memory-allocator,
  passagemath-ppl,
  passagemath-modules,
  passagemath-glpk,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-polyhedra";
  version = "10.8.13";

  pyproject = true;
  build-system = [
    setuptools
    cython
    pkgconfig
    passagemath-setup
    passagemath-environment
  ];
  buildInputs = with pkgs; [
    gmp
    libmpc
    mpfr
  ];
  dependencies = [
    cysignals
    gmpy2
    memory-allocator
    passagemath-environment
    passagemath-ppl
    passagemath-modules
    passagemath-glpk
  ];

  src = fetchPypi {
    pname = "passagemath_polyhedra";
    inherit version;
    hash = "sha256-lbpXqhcnE3O/X1ZPjmVPDMY7zeZazgvyG+Xg7vZgGaw=";
  };
}
