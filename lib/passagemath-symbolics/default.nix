{
  lib,
  stdenv,
  python3,
  python3Packages,
  fetchPypi,
  autoPatchelfHook,
  ...
}:

let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python3.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = ""; # TODO
      };

      cp314 = {
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-waBm9ZYdb2V/GvEb4oHNBZTNiaQmg3UehQQ420wNv0M=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-symbolics: unsupported wheel");
in

python3Packages.buildPythonPackage {
  pname = "passagemath-symbolics";
  inherit version;

  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_symbolics";
    inherit version;
    format = "wheel";

    dist = pythonTag;
    python = pythonTag;
    inherit (wheel) abi platform hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  dependencies = [
    python3Packages.gmpy2
    python3Packages.cysignals
    python3Packages.numpy
    python3Packages.sympy
  ];
}

