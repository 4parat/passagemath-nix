{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  libz,

  gmpy2,
  cysignals,
  fpylll,
  memory-allocator,
  scipy,
  passagemath-modules,
  passagemath-flint,
  passagemath-polyhedra,
  passagemath-singular,
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
        hash = "sha256-NtSpnNQ1mmiv0FNSjIb++7kXtT2Z0JaNdwr/0sfdkl4=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-schemes: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-schemes";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_schemes";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [ autoPatchelfHook ];
    buildInputs = [ libz ];
    dependencies = [
      gmpy2
      cysignals
      fpylll
      memory-allocator
      scipy
      passagemath-modules
      passagemath-flint
      passagemath-polyhedra
      passagemath-singular
      # numpy
      # passagemath-ntl
      # passagemath-categories
    ];
  }

