{
  buildPythonPackage,
  fetchPypi,
  passagemath-setup,
  setuptools,
  passagemath-environment,
  cython,
  pkgconfig,
  pkgs,
  cysignals,
  memory-allocator,
  passagemath-categories,
  conway-polynomials,
  passagemath-modules,
  passagemath-flint,
  mpmath,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-pari";
  version = "10.8.13";

  pyproject = true;
  build-system = [
    setuptools
    passagemath-setup
    passagemath-modules
    passagemath-flint
    mpmath
    cython
    pkgconfig
  ];

  nativeBuildInputs = with pkgs; [
    pari
    flint
  ];

  buildInputs = with pkgs; [
    givaro
    libmpc
    mpfr
    gmp
    pari
    readline
    flint
    gsl
    ntl
    # m4ri
    # gd
    # libpng
  ];

  dependencies = [
    cysignals
    memory-allocator
    passagemath-environment
    passagemath-categories
    conway-polynomials
  ];

  src = fetchPypi {
    pname = "passagemath_pari";
    inherit version;
    hash = "sha256-kXS5ClhkZW4qJADSRMmDteBhbPMKon8Tu1rZkyr6+uM=";
  };
}
