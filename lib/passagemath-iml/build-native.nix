{
  buildPythonPackage,
  fetchPypi,
  cysignals,
  passagemath-environment,
  passagemath-categories,
  passagemath-flint,
  passagemath-modules,
  setuptools,
  flint,
  pkgconfig,
  iml,
  passagemath-setup,
  # cython,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-iml";
  version = "10.8.13";

  pyproject = true;

  src = fetchPypi {
    pname = "passagemath_iml";
    inherit version;
    hash = "sha256-SJQv6RXTQLmmZVvUd1NVVyG89UaPj/p353tJGKHbRDs=";
  };

  # BUILDSYSTEM CHECKED
  build-system = [
    setuptools
    pkgconfig
    passagemath-setup
  ];

  # BUILDINPUTS CHECKED
  buildInputs = [
    flint
    iml
  ];

  # DEPENDENCIES CHECKED
  dependencies = [
    passagemath-environment
    passagemath-flint
    passagemath-modules
  ];

  pythonImportsCheck = [
    "sage.env"
  ];
}

