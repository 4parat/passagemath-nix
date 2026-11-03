{
  build,
  buildPythonPackage,
  packaging,
  setuptools,
  ...
}:
let
  pname = "passagemath-conf";
  version = "10.8.13";
in
buildPythonPackage {
  inherit pname version;

  pyproject = true;

  build-system = [
    setuptools
    build
    packaging
  ];

  src = ./sage-conf;
}
