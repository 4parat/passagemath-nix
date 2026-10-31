{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  wheel,
}:
buildPythonPackage rec {
  pname = "lrcalc";
  version = "2.1";

  pyproject = true;
  build-system = [setuptools cython wheel];
  buildInputs = [pkgs.lrcalc];

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-46BQmu2kh7QSs5GlLoF8o2tcBjqDBeCf1U1TJZ3Wqqk=";
  };

  pythonImportsCheck = ["lrcalc"];
}
