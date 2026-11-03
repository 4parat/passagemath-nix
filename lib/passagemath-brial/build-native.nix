{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  cysignals,
  passagemath-categories,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-brial";
  version = "10.8.13";

  pyproject = true;

  # BUILDSYSTEM CHECKED
  build-system = [
    setuptools
    pkgconfig
    cython
    passagemath-setup
  ];

  # BUILDINPUTS CHECKED
  buildInputs = with pkgs; [
    gmp
    gd
    boost
    m4ri
    libpng
    brial
  ];

  # DEPENDENCIES CHECKED
  dependencies = [
    cysignals
    passagemath-categories
  ];

  src = fetchPypi {
    pname = "passagemath_brial";
    inherit version;
    hash = "sha256-HGCdG76KdKR/Us+Nd6pN5rD6VK1gS9OquaKsFniBjQY=";
  };
}
