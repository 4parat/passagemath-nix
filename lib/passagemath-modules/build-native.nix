{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  passagemath-setup,
  passagemath-environment,
  libz,
  cysignals,
  memory-allocator,
  numpy,
  mpmath,
  passagemath-categories,
  passagemath-flint,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-modules";
  version = "10.8.13";

  pyproject = true;
  build-system = [
    setuptools
    cython
    passagemath-setup
    passagemath-environment
  ];

  nativeBuildInputs = [
    pkgs.pkg-config
  ];

  buildInputs = with pkgs; [
    gmp
    libmpc
    mpfr
    gsl
  ];

  dependencies = with pkgs.python3Packages; [
    mpmath
    jinja2
    # cysignals
    # memory-allocator
    numpy
    passagemath-categories
    # passagemath-flint
  ];
  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_modules";
    inherit version;
    hash = "sha256-EIsWJ3Ej1ubsYmjtAzIMrW3XPtyrJgfI2Day0X1dmQg=";
  };
}
