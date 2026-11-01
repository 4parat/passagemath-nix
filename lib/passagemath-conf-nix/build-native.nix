{
  buildPythonPackage,
  lib,
  fetchPypi,
  setuptools,
  build,
  packaging,
  writeText,
  ...
}:
let
  pname = "passagemath-conf";
  snake_pname = "passagemath_conf_pypi";
  version = "10.8.13";
  hash = "sha256-luuD+ARdXzSZx93UttZBUr9vjYlXhfkIfH5HUBRRRRg=";

  # Things we want to appear in the Sage configuration globally
  # Changing it will cause mass rebuild on Sage packages
  config = {
    CBLAS_PC_MODULES = "openblas:blas";
    # SINGULAR_BIN = "${singular}/bin/Singular";
    # MAXIMA = "${maxima}/bin/maxima";
    # OPENMP_CFLAGS = "";
    # OPENMP_CXXFLAGS = "";
    # NTL_INCDIR = null;
    # NTL_LIBDIR = null;
  };

  toPython =
    value:
    if value == null then
      "None"
    else if builtins.isBool value then
      (if value then "True" else "False")
    else
      builtins.toJSON value;

  # Files of the passagemath-conf implementations that are piloted by nix.
  files = {
    "VERSION.txt" = writeText "VERSION.txt" ''
      ${version}
    '';
    "_sage_conf/_conf.py" = writeText "_conf.py" (
      lib.concatStringsSep "\n" (lib.mapAttrsToList (name: value: "${name} = ${toPython value}") config)
      + "\n"
    );
  };
in
buildPythonPackage rec {
  inherit pname version;

  pyproject = true;

  build-system = [
    setuptools
    build
    packaging
  ];

  dependencies = [ ];

  postPatch = ''
    cp ${files."_sage_conf/_conf.py"} "_sage_conf/_conf.py"
    cp ${files."VERSION.txt"} "VERSION.txt"
  '';
  src = ./sage-conf;
}
