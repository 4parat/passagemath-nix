{
  lib,
  stdenv,
  python3,
  python3Packages,
  fetchPypi,
  autoPatchelfHook,
  ...
}:
let
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python3.pythonVersion}";
in
  python3Packages.buildPythonPackage rec {
    pname = "passagemath-conf";
    version = "10.8.13.post1";

    format = "pyproject";

    src = fetchPypi {
      pname = "passagemath_conf";
      inherit version;
      hash = "sha256-hJI7kPFi5rEDnCmC1HBg74sjcJB44NMubpdDnZLoFTQ=";
    };
    build-system = [ python3Packages.setuptools ];

    preBuild = ''
      export SAGE_CONF_FILE=/dev/null
    '';

    pythonImportsCheck = [
      "sage.config"
    ];
}

