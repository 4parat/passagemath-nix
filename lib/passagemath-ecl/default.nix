{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,

  memory-allocator,
  cysignals,
  pexpect,
  passagemath-environment,
  passagemath-categories,
  ...
}@pkgs:

let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_28_x86_64";
        abi = "cp313";
        hash = ""; # TODO
      };

      cp314 = {
        platform = "manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-rFI7eF6WD/1NK2HyF3aHyyYnjjhYlSwUbgS50llIL4c=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-ecl: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-ecl";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_ecl";
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
      pexpect
      passagemath-environment
      passagemath-categories
    ];
  }

