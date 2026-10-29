{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,

  cysignals,
  gmpy2,
  ...
}@pkgs:

let
  version = "0.8.10.3";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-PyWffH0xcUZ9Oxc/lSDfArgq4hxhFzYprFsjlT4/KMU=";
      };

      cp314 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-SQH65t/wqW3sWLTi7mnamYz4KCfQJFv4zaHxNKqBwAM=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-ppl: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-ppl";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_ppl";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [ autoPatchelfHook ];
    dependencies = [
      cysignals
      gmpy2
    ];
  }


