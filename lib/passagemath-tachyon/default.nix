{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  libz,

  cysignals,
  passagemath-environment,
  passagemath-objects,
  ...
}:

let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "abi3-manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = ""; # TODO
      };

      cp314 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp314t";
        hash = "sha256-gj8Hx5Lm2HxMCxfdfm+NgVtykbbsCGlFAl+AOilqUCA=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-tachyon: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-tachyon";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_tachyon";
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
      passagemath-environment
      passagemath-objects
    ];
  }

