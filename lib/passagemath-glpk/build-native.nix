{
  buildPythonPackage,
  fetchPypi,
  passagemath-setup,
  setuptools,
  passagemath-environment,

  cython,
  pkgconfig,

  passagemath-objects,
  cysignals,
  memory-allocator,
  typing-extensions,
  passagemath-categories,
  pkgs,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-glpk";
  version = "10.8.13";

  pyproject = true;
  build-system = [
    setuptools
    passagemath-setup
    passagemath-environment
    cython
    pkgconfig
  ];

  buildInputs = with pkgs; [
    glpk
    gmp
    libmpc
    mpfr
    libz
  ];

  dependencies = with pkgs.python3Packages; [
    passagemath-categories
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_glpk";
    inherit version;
    hash = "sha256-7VNjIRAALpu0SuuUh+taNzOxxJp1rM2SndGykSm6fDY=";
  };
}

