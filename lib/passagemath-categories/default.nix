{
  lib,
  stdenv,
  python,
  buildPythonPackage,
  fetchPypi,
  autoPatchelfHook,
  memory-allocator,
  passagemath-objects,
  ...
}@pkgs:
let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-Ohx2Qan4LzOOMftCNpqd1nRTyJUCaYR4Fwckxa71l2E=";
      };

      cp314 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-D97UXRc6GyVNUDPPgLfzkiqtJ+dPevUQWlDyyBiP5E8=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-categories: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-categories";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_categories";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [ autoPatchelfHook ];
    dependencies = [
      memory-allocator
      passagemath-objects
    ];
  }

