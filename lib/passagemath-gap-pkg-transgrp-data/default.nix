{
  fetchPypi,
  buildPythonPackage,
  passagemath-environment,
  ...
}:
buildPythonPackage {
  pname = "passagemath-gap-pkg-transgrp-data";
  version = "10.8.13";
  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_gap_pkg_transgrp_data";
    version = "10.8.13";
    format = "wheel";
    dist = "py3";
    python = "py3";
    abi = "none";
    platform = "any";
    hash = "sha256-NQ8ZYNFEMvXAh6rGR2PFDAZbXYAeiL5OvGUIKtMF3+0=";
  };

  dependencies = [passagemath-environment];
}
