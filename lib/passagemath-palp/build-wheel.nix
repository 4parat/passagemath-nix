{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  cysignals,
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
        dist = "cp312";
        python = "cp312";
        abi = "abi3";
        hash = "sha256-rJ04roV9HRLr+FWYUNBQTxPDxMHVPh9pBhfH792Mm50=";
      };
      cp314 = {
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        dist = "cp312";
        python = "cp312";
        abi = "abi3";
        hash = "sha256-rJ04roV9HRLr+FWYUNBQTxPDxMHVPh9pBhfH792Mm50=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "passagemath-palp: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-palp";
  inherit version;
  format = "wheel";
  src = fetchPypi {
    pname = "passagemath_palp";
    inherit version;
    format = "wheel";
    inherit (wheel)
      dist
      python
      abi
      platform
      hash
      ;
  };
  nativeBuildInputs = [ autoPatchelfHook ];
  dependencies = [
    cysignals
    passagemath-environment
  ];
}
