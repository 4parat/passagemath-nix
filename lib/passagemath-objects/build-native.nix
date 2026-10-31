{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  passagemath-setup,
  passagemath-environment,
  cysignals,
  gmpy2,
  pkgconfig,
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

    postPatch = ''
      sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
    '';
    src = fetchPypi {
      pname = snake_pname;
      inherit version hash;
    };
  }
