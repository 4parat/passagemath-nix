{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,

  ...
}@pkgs:

let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux1_x86_64.manylinux_2_28_x86_64.manylinux_2_5_x86_64";
        abi = "cp313";
        hash = ""; # TODO
      };

      cp314 = {
        platform = "manylinux1_x86_64.manylinux_2_28_x86_64.manylinux_2_5_x86_64";
        abi = "cp314";
        hash = "sha256-I4jwREONgyaEwa8S/U3mOPuctrP7wqGUDCnquobJV/I=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-primesieve-primecount: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-primesieve-primecount";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_primesieve_primecount";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [ autoPatchelfHook ];
    dependencies = [
    ];
  }

