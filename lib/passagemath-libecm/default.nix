{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  memory-allocator,
  cysignals,
  passagemath-objects,
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
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-fjwYg720iis9O9bs9lvQemjIDcaLiNq/ZPWFmRdONf4=";
      };
      cp314 = {
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-25I/fEE8MF1yT7nCJomY6BDW+VLRmJ6AR61GJAHBqj8=";
      };
    };
  };
  wheel = wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "passagemath-libecm: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-libecm";
  inherit version;
  format = "wheel";
  src = fetchPypi {
    pname = "passagemath_libecm";
    inherit version;
    format = "wheel";
    dist = pythonTag;
    python = pythonTag;
    inherit (wheel) abi platform hash;
  };
  nativeBuildInputs = [ autoPatchelfHook ];
  dependencies = [
    memory-allocator
    cysignals
    passagemath-objects
    passagemath-categories
    passagemath-environment
  ];
}

