{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  libz,
  memory-allocator,
  cysignals,
  passagemath-objects,
  ...
}: let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings ["."] [""] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-62KB3VbA9oY15Vzm2/dM8DXyGiA6mFktJyWKkQyf/18=";
      };
      cp314 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-SN3+EsPE4f3WkSZKBHQTrghhsMCHsnj3/zp1qcOps2M=";
      };
    };
  };
  wheel = wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "passagemath-highs: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-highs";
    inherit version;
    format = "wheel";
    src = fetchPypi {
      pname = "passagemath_highs";
      inherit version;
      format = "wheel";
      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };
    nativeBuildInputs = [autoPatchelfHook];
    buildInputs = [libz];
    dependencies = [memory-allocator cysignals passagemath-objects];
  }
