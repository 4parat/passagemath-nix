{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  libz,
  passagemath-pari,
  cysignals,
  memory-allocator,
  pexpect,
  passagemath-categories,
  passagemath-modules,
  passagemath-flint,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-singular";
  version = "10.8.13";

  pyproject = true;
  build-system = [ setuptools cython pkgconfig passagemath-setup passagemath-environment ];
  buildInputs = with pkgs; [ gmp libmpc mpfr singular givaro flint gsl ntl ];
  dependencies = [
    passagemath-pari
    cysignals
    memory-allocator
    pexpect
    passagemath-environment
    passagemath-categories
    passagemath-modules
    passagemath-flint
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_singular";
    inherit version;
    hash = "sha256-Vwb7Pc7qF5ikZ3L5BiEmlX2JS3cPzjQmaYCohasCoQs=";
  };
}
