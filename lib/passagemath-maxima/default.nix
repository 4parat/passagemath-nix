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
  passagemath-ecl,
  passagemath-categories,
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
        # platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        platform = "manylinux1_x86_64.manylinux_2_28_x86_64.manylinux_2_5_x86_64";
        abi = "cp314";
        hash = "sha256-tOPuOMOZBldoPadAD/8COf/ntecdByAndHihwZoPItk=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-maxima: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-maxima";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_maxima";
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
      passagemath-ecl
    ];
  }


