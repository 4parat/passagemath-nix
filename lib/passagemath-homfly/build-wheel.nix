{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  cysignals,
  ...
}: let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings ["."] [""] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-gup18OZHB2EGC50KTttuN9SD7zkHCciy6dCyYNptlXI=";
      };
      cp314 = {
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-qUZFRZv60OqtdpPCRWTB03dTrAgYdRQc++Irv03pTsk=";
      };
    };
  };
  wheel = wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "passagemath-homfly: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-homfly";
    inherit version;
    format = "wheel";
    src = fetchPypi {
      pname = "passagemath_homfly";
      inherit version;
      format = "wheel";
      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };
    nativeBuildInputs = [autoPatchelfHook];
    dependencies = [cysignals];
  }
