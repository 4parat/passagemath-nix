{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  cysignals,
  passagemath-categories,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-ecl";
  version = "10.8.13";

  pyproject = true;
  build-system = [
    setuptools
    passagemath-setup
    pkgconfig
    cython
  ];
  nativeBuildInputs = with pkgs; [
    ecl
  ];
  buildInputs = with pkgs; [
    ecl
    gmp
    libffi
  ];
  dependencies = [
    cysignals
    passagemath-categories
    passagemath-environment
  ];

  src = fetchPypi {
    pname = "passagemath_ecl";
    inherit version;
    hash = "sha256-BD6+7oPJpChvy6UFVMfMG6wa0ZQDzaIn0cuW9+2ExsU=";
  };
}
