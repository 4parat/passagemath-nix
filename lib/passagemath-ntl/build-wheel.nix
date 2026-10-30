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
}:
let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-4b/ypWkRz8bcI1kvvMnutHi7wfUKzlToHQ8XkzJjD6c=";
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
      or (throw "passagemath-ntl: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-ntl";
  inherit version;

  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_ntl";
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
