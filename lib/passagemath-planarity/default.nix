{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  passagemath-graphs,
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
        hash = "sha256-KSO2RG06Ykm6/wftTBC5l6aUGveAAqYbv7aYOn+g/0c=";
      };
      cp314 = {
        dist = "cp312";
        python = "cp312";
        abi = "abi3";
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        hash = "sha256-KSO2RG06Ykm6/wftTBC5l6aUGveAAqYbv7aYOn+g/0c=";
      };
    };
  };
  wheel = wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "passagemath-planarity: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-planarity";
  inherit version;
  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_planarity";
    inherit version;
    format = "wheel";
    inherit (wheel) dist python abi platform hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  dependencies = [ passagemath-graphs ];
}

