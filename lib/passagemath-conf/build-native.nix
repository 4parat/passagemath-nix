{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  build,
  packaging,
  writeText,
  lib,
  ...
}: let
  pname = "passagemath-conf";
  snake_pname = "passagemath_conf";
  version = "10.8.13";
  hash = "sha256-luuD+ARdXzSZx93UttZBUr9vjYlXhfkIfH5HUBRRRRg=";
in
  buildPythonPackage rec {
    inherit pname version;

    pyproject = true;

    env.SAGE_CONF_FILE = writeText "sage-conf-nix.py" ''
      CBLAS_PC_MODULES = "openblas:blas"
    '';
    build-system = [
      setuptools
      build
      packaging
    ];

    src = fetchPypi {
      pname = snake_pname;
      inherit version hash;
    };

    meta = {
      description = "Configuration module for the modular SageMath library";
      longDescription = ''
        PassageMath Conf provides configuration information for the modular
        SageMath library, both at build time and at runtime.

        It provides the Python module sage.config, the sage-config command-line
        utility, and the sage-env-config shell script.

        The package supports multiple implementations, allowing PassageMath
        to integrate with different packaging systems and distributions.
      '';
      homepage = "https://github.com/passagemath/passagemath";
      license = lib.licenses.gpl2Plus;
    };
  }
