{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  libz,

  passagemath-pari,
  cysignals,
  memory-allocator,
  pexpect,
  passagemath-environment,
  passagemath-categories,
  passagemath-modules,
  passagemath-flint,
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
        hash = ""; # TODO
      };

      cp314 = {
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-iQfrTPKMIwGv7MTaFgrK7LqCgB1J0Y3BNMLqP/X2Dh4=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-singular: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-singular";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_singular";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [ autoPatchelfHook ];
    buildInputs = [ libz ];
    dependencies = [
      passagemath-pari
      cysignals
      memory-allocator
      pexpect
      passagemath-environment
      passagemath-categories
      passagemath-modules
      passagemath-flint
    ];
  }

