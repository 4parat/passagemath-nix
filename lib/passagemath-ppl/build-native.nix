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
  pname = "passagemath-ppl";
  version = "0.8.10.3";

  pyproject = true;
  build-system = [
    setuptools
    passagemath-setup
    passagemath-environment
    cython
    pkgconfig
  ];

  nativeBuildInputs = with pkgs; [
    # ppl
    # flint
  ];

  buildInputs = with pkgs; [
    # givaro
    libmpc
    mpfr
    gmp
    ppl
    ntl
    # flint
    # gsl
    # m4ri
    # gd
    # libpng
  ];

  dependencies = with pkgs.python3Packages; [
    gmpy2
    cysignals
    # numpy
    # passagemath-modules
    # passagemath-flint
    # passagemath-categories
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_ppl";
    inherit version;
    hash = "sha256-YuJKEt7o+PzugLuCMcllLhfT8tcQwKKBXSaosHEWLqM=";
  };
}
