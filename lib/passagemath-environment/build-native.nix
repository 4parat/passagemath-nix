{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  platformdirs,
  packaging,
  wheel,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-environment";
  version = "10.8.13";

  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
  dependencies = [
    packaging
    platformdirs
  ];

  src = fetchPypi {
    pname = "passagemath_environment";
    inherit version;
    hash = "sha256-N6dB1NP1uUED/DxAwuRSChQejV4lyHqI6U8B6gQ7paI=";
  };
}
