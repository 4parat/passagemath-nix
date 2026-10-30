{
  lib,
  stdenv,
  python,
  fetchPypi,
  buildPythonPackage,
  autoPatchelfHook,
  cysignals,
  gmpy2,
  memory-allocator,
  passagemath-environment,
  passagemath-glpk,
  passagemath-modules,
  passagemath-ppl,
  ...
} @ pkgs: let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings ["."] [""] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-v949NY0rODMHisMPOSMXbkW3PFyAxVkxek8Rr1EWIiI=";
      };

      cp314 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-XQt3o4ADJ4YWveRHGMoGb7LXNIRW3tAIrrjR2p4HkC8=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-polyhedra: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-polyhedra";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_polyhedra";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [autoPatchelfHook];
    dependencies = [
      cysignals
      gmpy2
      memory-allocator
      passagemath-environment
      passagemath-ppl
      passagemath-modules
      passagemath-glpk
    ];
  }
