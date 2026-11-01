{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  cysignals,
  ...
}:
let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        dist = "cp312";
        python = "cp312";
        abi = "abi3";
        hash = "sha256-KPbUOVyfj1CZN/tEYxGP40uGLtyRMpLtsv9gSaK4KKA=";
      };
      cp314 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        dist = "cp312";
        python = "cp312";
        abi = "abi3";
        hash = "sha256-KPbUOVyfj1CZN/tEYxGP40uGLtyRMpLtsv9gSaK4KKA=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-libbraiding: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-libbraiding";
  inherit version;
  format = "wheel";
  src = fetchPypi {
    pname = "passagemath_libbraiding";
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
  dependencies = [ cysignals ];
}
