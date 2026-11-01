{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
}:
let
  version = "2.1";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-ct0jLBB2icw2YtMh/kuuLYsqBJj4AwZVDmqON/oGC/o=";
      };
      cp314 = {
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-S9NtqxqogwSZqxBviobAjupwVckETM1/PV8BkEzuLQU=";
      };
    };
  };
  wheel = wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "lrcalc: unsupported wheel");
in
buildPythonPackage {
  pname = "lrcalc";
  inherit version;
  format = "wheel";

  src = fetchPypi {
    pname = "lrcalc";
    inherit version;
    format = "wheel";
    dist = pythonTag;
    python = pythonTag;
    inherit (wheel) abi platform hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
}
