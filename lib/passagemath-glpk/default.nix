{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  libz,

  passagemath-objects,
  memory-allocator,
  cysignals,
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
        hash = "sha256-B5EepDX6aXlhAYxxuPmcPwHcJzim1CFOxAt7D6cF+yc=";
      };

      cp314 = {
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-jhkxfwggirXnfnL1+CKg+XOe/cpNTdFJ6GW9cfiYays=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-glpk: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-glpk";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_glpk";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [ autoPatchelfHook ];
    buildInputs = [ libz ];
    dependencies = [
      passagemath-objects
      memory-allocator
      cysignals
    ];
  }

