{
  fetchPypi,
  buildPythonPackage,
  passagemath-environment,
  ...
}:
buildPythonPackage {
  pname = "passagemath-pari-seadata-small";
  version = "10.8.13";
  format = "wheel";
  src = fetchPypi {
    pname = "passagemath_pari_seadata_small";
    version = "10.8.13";
    format = "wheel";
    dist = "py3";
    python = "py3";
    abi = "none";
    platform = "any";
    hash = "sha256-X+Dw9No0ugX51p83xyW8zeEGlCn2AlrugFOodhn1FP8=";
  };
  dependencies = [ passagemath-environment ];
}

