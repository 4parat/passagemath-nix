{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,

  cysignals,
  ...
}@pkgs:

let
  version = "0.1.1.2";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux1_x86_64.manylinux_2_28_x86_64.manylinux_2_5_x86_64";
        abi = "cp313";
        hash = ""; # TODO
      };

      cp314 = {
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-3CH/3dyCR0TOm/Oghu6GcrO4tHMI16r5tn2l+CCes3o=";
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
      cysignals
    ];
  }

