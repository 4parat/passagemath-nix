{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  libz,
  cysignals,
  passagemath-environment,
  passagemath-categories,
  passagemath-flint,
  passagemath-modules,
  ...
}:
let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-nC8DMOt+nb2QB5bHMsSGfm2EOYI1g5WDQ6SoTnQPqtw=";
      };
      cp314 = {
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-ZriAI2jPfWI0+k+HZVikh8Kw8NdReTqyWIZeHfpjFYg=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "passagemath-iml: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-iml";
  inherit version;
  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_iml";
    inherit version;
    format = "wheel";
    dist = pythonTag;
    python = pythonTag;
    inherit (wheel) abi platform hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ libz ];
  dependencies = [
    cysignals
    passagemath-environment
    passagemath-categories
    passagemath-flint
    passagemath-modules
  ];
}
