{
  buildPythonPackage,
  fetchPypi,
  passagemath-setup,
  setuptools,
  passagemath-environment,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-gap-pkg-ctbllib-data";
  version = "10.8.13";

  pyproject = true;
  build-system = [
    setuptools
    passagemath-setup
  ];

  dependencies = [
    passagemath-environment
  ];

  src = fetchPypi {
    pname = "passagemath_gap_pkg_ctbllib_data";
    inherit version;
    hash = "sha256-cX03/dmpwhsu7kDQQKi4ONOabtwIZz3TePhR+5tYngs=";
  };
}
