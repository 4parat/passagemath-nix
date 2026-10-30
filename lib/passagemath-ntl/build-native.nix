{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  memory-allocator,
  cysignals,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-ntl";
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
    mpc
    mpfr
    ntl
    mpfi
    m4ri
  ];
  dependencies = with pkgs.python3Packages; [
    memory-allocator
    cysignals
    passagemath-environment
    passagemath-categories
    passagemath-modules
  ];
  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_ntl";
    inherit version;
    hash = "sha256-d3OOsfFEsuoQbkPNuZnzotYabZX7xnuZ1Bf/LOAnEJQ=";
  };
}
