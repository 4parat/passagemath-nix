{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  cysignals,
  gmpy2,
  memory-allocator,
  passagemath-categories,
  passagemath-environment,
  ...
}:
let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-kNoG4lUtIuIXUZ/L1nJXFuAfAHifS5jAug5uGyIUj0s=";
      };
      cp314 = {
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-MUWTzP6Fttcp0FWalkKI12OkJhaoQgR7EGMZHoMWOWo=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-combinat: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-combinat";
  inherit version;
  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_combinat";
    inherit version;
    format = "wheel";
    dist = pythonTag;
    python = pythonTag;
    inherit (wheel) abi platform hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  dependencies = [
    gmpy2
    cysignals
    memory-allocator
    passagemath-categories
    passagemath-environment
  ];
}
