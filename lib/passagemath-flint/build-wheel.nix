{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  libz,
  numpy,
  passagemath-ntl,
  passagemath-categories,
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
        hash = "sha256-gGMgGgOtdfiK351QO/l0UzooShxI0KfeXavvBBj6ljQ=";
      };

      cp314 = {
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-nG2R6m+qaq6Nin9qxi6CScB4fSp6njFZU2lMTaxz0LE=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "passagemath-flint: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-flint";
  inherit version;

  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_flint";
    inherit version;
    format = "wheel";

    dist = pythonTag;
    python = pythonTag;
    inherit (wheel) abi platform hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ libz ];
  dependencies = [
    numpy
    passagemath-ntl
    passagemath-categories
  ];
}
