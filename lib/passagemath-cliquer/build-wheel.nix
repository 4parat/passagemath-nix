{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  cysignals,
  ...
}: let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings ["."] [""] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        dist = "cp312";
        python = "cp312";
        abi = "abi3";
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        hash = "sha256-Gpt/vmKKLY1tP6lV1AbDMVMD7JHf268/iV6KmXJJoi4=";
      };
      cp314 = {
        dist = "cp312";
        python = "cp312";
        abi = "abi3";
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        hash = "sha256-Gpt/vmKKLY1tP6lV1AbDMVMD7JHf268/iV6KmXJJoi4=";
      };
    };
  };
  wheel = wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "passagemath-cliquer: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-cliquer";
    inherit version;
    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_cliquer";
      inherit version;
      format = "wheel";
      inherit (wheel) dist python abi platform hash;
    };

    nativeBuildInputs = [autoPatchelfHook];
    # The wheel imports cysignals.signals although its metadata omits it.
    dependencies = [cysignals];
  }
