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
  passagemath-modules,
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
        hash = "sha256-OqnvVbSj5TIyELiIlHpI6X0DM4Ugr8fDtxdy1qVcha8=";
      };
      cp314 = {
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-SL7NMORxvIbaFchG5VrDrWNpvFV6P6Spw1iVwhomsAY=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-m4ri-m4rie: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-m4ri-m4rie";
  inherit version;
  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_m4ri_m4rie";
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
    passagemath-modules
  ];
}
