{
  fetchPypi,
  buildPythonPackage,
  passagemath-environment,
  ...
}:
buildPythonPackage {
  pname = "passagemath-pari-galdata";
  version = "10.8.13";
  format = "wheel";
  src = fetchPypi {
    pname = "passagemath_pari_galdata";
    version = "10.8.13";
    format = "wheel";
    dist = "py3";
    python = "py3";
    abi = "none";
    platform = "any";
    hash = "sha256-UE4TlAxM1382bF7l5lF0FtFuuHjDvcgFbbOkJpmcWMw=";
  };
  dependencies = [ passagemath-environment ];
}
