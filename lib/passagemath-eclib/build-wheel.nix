{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  cysignals,
  memory-allocator,
  passagemath-linbox,
  passagemath-modules,
  passagemath-ntl,
  ...
}: let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings ["."] [""] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-WoMOJQiJT7tCIWZBnEOJCHuUdxviCSajNdofiZpDNG8=";
      };
      cp314 = {
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-u3JVX22gQM6oRT9U9w6ENQVL9EhVqmiJJmw70I1fHow=";
      };
    };
  };
  wheel = wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "passagemath-eclib: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-eclib";
    inherit version;
    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_eclib";
      inherit version;
      format = "wheel";
      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [autoPatchelfHook];
    dependencies = [
      cysignals
      memory-allocator
      passagemath-linbox
      passagemath-modules
      passagemath-ntl
    ];
  }
