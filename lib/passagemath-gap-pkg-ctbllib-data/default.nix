{
  fetchPypi,
  buildPythonPackage,
  passagemath-environment,
  ...
}:
buildPythonPackage {
  pname = "passagemath-gap-pkg-ctbllib-data";
  version = "10.8.13";
  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_gap_pkg_ctbllib_data";
    version = "10.8.13";
    format = "wheel";
    dist = "py3";
    python = "py3";
    abi = "none";
    platform = "any";
    hash = "sha256-19o6f8MNjGczz6oxt/QLQ1obRb+pc/y+t1XWWElVq9Y=";
  };

  dependencies = [passagemath-environment];
}
