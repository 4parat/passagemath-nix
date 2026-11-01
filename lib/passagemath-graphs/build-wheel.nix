{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  gmpy2,
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
        hash = "sha256-LUj1tsMGtN9O+KtcX/vX8gyoJY0G1EPFZU27wG5U62c=";
      };

      cp314 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-zVzzQmkZ/+bjbfrktFzA1YElohw4YxILPMDVIsvxnhg=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-graphs: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-graphs";
  inherit version;

  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_graphs";
    inherit version;
    format = "wheel";

    dist = pythonTag;
    python = pythonTag;
    inherit (wheel) abi platform hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  dependencies = [
    gmpy2
    memory-allocator
    cysignals
    passagemath-environment
    passagemath-categories
  ];
}
