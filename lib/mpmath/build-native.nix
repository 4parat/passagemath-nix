{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  ...
}:
buildPythonPackage rec {
  name = "mpmath";
  version = "1.3.0";
  pyproject = true;
  build-system = [
    setuptools
  ];

  src = fetchPypi {
    pname = "mpmath";
    inherit version;
    hash = "sha256-eijrKpd00Ax7ySQRwZqJIJ1dp8TJqeInvoMwojoluR8=";
  };
}
