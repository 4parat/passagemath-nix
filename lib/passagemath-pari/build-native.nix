{
  buildPythonPackage,
  fetchPypi,
  passagemath-setup,
  setuptools,
  passagemath-environment,

  cython,
  pkgconfig,

  pkgs,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-pari";
  version = "10.8.13";

  pyproject = true;
  build-system = [
    setuptools
    passagemath-setup
    passagemath-environment
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

  dependencies = with pkgs.python3Packages; [
    numpy
    passagemath-modules
    passagemath-flint
    conway-polynomials
    # passagemath-categories
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_pari";
    inherit version;
    hash = "sha256-kXS5ClhkZW4qJADSRMmDteBhbPMKon8Tu1rZkyr6+uM=";
  };
}
