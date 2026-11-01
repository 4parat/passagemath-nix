{
  buildPythonPackage,
  cysignals,
  cython,
  fetchPypi,
  gmpy2,
  passagemath-conf,
  passagemath-environment,
  passagemath-setup,
  pkgconfig,
  pkgs,
  setuptools,
  typing-extensions,
  ...
}: let
  pname = "passagemath-objects";
  snake_pname = "passagemath_objects";
  version = "10.8.13";
  hash = "sha256-mVGP1gXnEHeiP2B3WmVGh/RdFA79u0aL3iGd/dbRB58=";
in
  buildPythonPackage rec {
    inherit pname version;

    pyproject = true;

    dependencies = [
      passagemath-environment
      gmpy2
      cysignals
      typing-extensions
    ];
    buildInputs = with pkgs; [
      gmp
      libmpc
      mpfr
    ];
    build-system = [
      setuptools
      passagemath-setup
      passagemath-environment
      cython
      pkgconfig
    ];

    src = fetchPypi {
      pname = snake_pname;
      inherit version hash;
    };
  }
