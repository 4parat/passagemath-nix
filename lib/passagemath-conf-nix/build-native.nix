{
  build,
  buildPassagemathPackage,
  packaging,
  setuptools,
  ...
}:
let
  pname = "passagemath-conf";
  version = "10.8.13";
in
buildPassagemathPackage {
  inherit pname version;

  pyproject = true;

  build-system = [
    setuptools
    build
    packaging
  ];

  sageConf = {
    CBLAS_PC_MODULES = "openblas:blas";
  };

  dependencies = [ ];

  src = ./sage-conf;
}
