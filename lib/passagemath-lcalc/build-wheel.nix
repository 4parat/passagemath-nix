{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  cysignals,
  memory-allocator,
  passagemath-environment,
  passagemath-objects,
  passagemath-categories,
  passagemath-modules,
  ...
}:
let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-/g5hCSvujUZOCEdKH1x3wPNrWnPmOQc36SnJHYhW0GI=";
      };
      cp314 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-3CgPVwK1j5eVuJWBNfo7suFw5Qw+cffbDQ+2piWov0I=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "passagemath-lcalc: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-lcalc";
  inherit version;
  format = "wheel";
  src = fetchPypi {
    pname = "passagemath_lcalc";
    inherit version;
    format = "wheel";
    dist = pythonTag;
    python = pythonTag;
    inherit (wheel) abi platform hash;
  };
  nativeBuildInputs = [ autoPatchelfHook ];
  dependencies = [
    cysignals
    memory-allocator
    passagemath-environment
    passagemath-objects
    passagemath-categories
    passagemath-modules
  ];
}
