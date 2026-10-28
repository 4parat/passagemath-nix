{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  libz,

  cysignals,
  memory-allocator,
  numpy,
  mpmath,
  passagemath-categories,
  passagemath-environment,
  ...
}@pkgs:

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
        hash = "sha256-cgj2thE92SZ41c8d94sVrYd1jb7tYnCh/h1aZScbWdI=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "mpmath: unsupported wheel");
in
  buildPythonPackage {
    pname = "mpmath";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "mpmath";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [ autoPatchelfHook ];
    buildInputs = [ libz ];
    dependencies = [
      mpmath
      cysignals
      memory-allocator
      numpy
      passagemath-categories
      passagemath-environment
    ];
  }

