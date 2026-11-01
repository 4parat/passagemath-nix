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
  hash = "sha256-UeZG72lGoGVWcbw1d1fDNpk1mYEnD3FqUUBR1vATQVY=";
in
buildPythonPackage {
  pname = "passagemath-gap-pkg-irredsol-data";
  inherit version;

  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_gap_pkg_irredsol_data";
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
