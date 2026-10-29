{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  passagemath-environment,
  cysignals,
  ...
}:

let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        dist = "cp312";
        python = "cp312";
        abi = "abi3";
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        hash = "sha256-k9/H2Z7PSh5+GYxZxchYV2wG5lxnTqAieM1Z7K4hTCw=";
      };
      cp314 = {
        dist = "cp312";
        python = "cp312";
        abi = "abi3";
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        hash = "sha256-k9/H2Z7PSh5+GYxZxchYV2wG5lxnTqAieM1Z7K4hTCw=";
      };
    };
  };
  wheel = wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "passagemath-cddlib: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-cddlib";
  inherit version;
  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_cddlib";
    inherit version;
    format = "wheel";
    inherit (wheel) dist python abi platform hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  dependencies = [ passagemath-environment cysignals ];
}

