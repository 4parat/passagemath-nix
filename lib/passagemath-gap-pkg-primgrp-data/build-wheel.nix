{
  fetchPypi,
  buildPythonPackage,
  passagemath-environment,
  ...
}@pkgs:
let
  version = "10.8.13";
  abi = "none";
  platform = "any";
  hash = "sha256-gnnck80x0xKH3+mFTTh4DDOERVGf7s0jaoFt8Dtbpz4=";
in
buildPythonPackage {
  pname = "passagemath-gap-pkg-primgrp-data";
  inherit version;

  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_gap_pkg_primgrp_data";
    inherit version;
    format = "wheel";

    dist = "py3";
    python = "py3";
    inherit abi platform hash;
  };

  dependencies = [
    passagemath-environment
  ];
}
