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
  hash = "sha256-7imoYjpA5tnzElWKhzJJNbLrXXNWxOMlafOD94mb9Cg=";
in
buildPythonPackage {
  pname = "passagemath-gap-pkg-smallgrp-data";
  inherit version;

  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_gap_pkg_smallgrp_data";
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
