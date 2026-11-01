{
  fetchPypi,
  buildPythonPackage,
  passagemath-objects,
  passagemath-environment,
  ipykernel,
  ipython,
  ipywidgets,
  jupyter-client,
  typing-extensions,
  ...
}@pkgs:
let
  version = "10.8.13";
  abi = "none";
  platform = "any";
  hash = "sha256-b/Ig7D+HhuOxisBTeFim1vnWtN2Mz16dA9BFnaDUC5k=";
in
buildPythonPackage {
  pname = "passagemath-repl";
  inherit version;

  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_repl";
    inherit version;
    format = "wheel";

    dist = "py3";
    python = "py3";
    inherit abi platform hash;
  };

  dependencies = [
    passagemath-objects
    passagemath-environment
    ipykernel
    ipython
    ipywidgets
    jupyter-client
    typing-extensions
  ];
}
