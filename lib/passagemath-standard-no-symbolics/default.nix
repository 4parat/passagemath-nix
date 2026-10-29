{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,

  memory-allocator,
  cysignals,
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
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = ""; # TODO
      };

      cp314 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-dYVXv8LEja9tygtWX/CCaWakMna330pmkQ8yRPRveyo=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-standard-no-symbolics: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-standard-no-symbolics";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_standard_no_symbolics";
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
      passagemath-environment
      passagemath-categories
    ];
  }

