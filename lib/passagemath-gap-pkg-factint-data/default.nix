{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,

  passagemath-environment,
  ...
}@pkgs:
let
  version = "10.8.13";
  abi = "none";
  platform = "any";
  hash = "sha256-IWTfPuyeoRiFxwTLFTRrMYL9VVxGX/gZ1ZyK3Ho1+/0=";
  pythonTag = "py3";
in
  buildPythonPackage {
    pname = "passagemath-gap-pkg-factint-data";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_gap_pkg_factint_data";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit abi platform hash;
    };

    nativeBuildInputs = [ autoPatchelfHook ];
    dependencies = [
      passagemath-environment
    ];
  }

