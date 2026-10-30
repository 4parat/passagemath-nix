{
  buildPythonPackage,
  fetchPypi,
  platformdirs,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-environment";
  version = "10.8.13";

  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_environment";
    inherit version format;

    hash = "sha256-4vZOsX0/H6pK1ozy2VM33/s5snk6F9HSp3g8lszHels=";
    dist = "py3";
    python = "py3";
    abi = "none";
    platform = "any";
  };

  dependencies = [
    platformdirs
  ];

  pythonImportsCheck = [
    "sage.env"
  ];
}
