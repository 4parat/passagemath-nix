{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,

  libz,
  passagemath-categories,
  passagemath-gap,
  passagemath-modules,
  ...
}@pkgs:

let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-XIVT9Fk7SzhGIKq1jBJCDIRrmyJn3TdXs5DEBq2IvDw=";
      };

      cp314 = {
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-Ff0na1o5WXXg/cXvOE8o8Z30XpvFwS6kh1hffoOYOOc=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-groups: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-groups";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_groups";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [ autoPatchelfHook ];
    buildInputs = [
      libz
    ];
    dependencies = [
      passagemath-categories
      passagemath-gap
      passagemath-modules
    ];
  }

