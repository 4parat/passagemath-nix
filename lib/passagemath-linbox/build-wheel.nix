{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  libz,
  cysignals,
  memory-allocator,
  passagemath-environment,
  passagemath-categories,
  passagemath-iml,
  passagemath-m4ri-m4rie,
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
        hash = "sha256-Ee2C4e/+JI+EsWdbe9wkzZ/vYitFAVvsCo19x5v9nmY=";
      };
      cp314 = {
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-p8RunLxjugoWaYFhj3X4jyYU66t2YLjyfQ/pVSSwA7k=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-linbox: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-linbox";
  inherit version;
  format = "wheel";
  src = fetchPypi {
    pname = "passagemath_linbox";
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
    memory-allocator
    passagemath-environment
    passagemath-categories
    passagemath-iml
    passagemath-m4ri-m4rie
  ];
}
