{
  lib,
  stdenv,
  python,
  buildPythonPackage,
  fetchPypi,
  autoPatchelfHook,
  gmpy2,
  typing-extensions,
  cysignals,
  ...
}:
let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-knafc1OPYRAHTa+CzoHmtmLIPk2RGE3gamRZc9eJxPU=";
      };

      cp314 = {
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-kM5FnxQ7mu8btvSbcKFaWuJpA7J3NYXDNwiAd7OPf7U=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-objects: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-objects";
  inherit version;

  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_objects";
    inherit version;
    format = "wheel";

    dist = pythonTag;
    python = pythonTag;
    inherit (wheel) abi platform hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  dependencies = [
    gmpy2
    typing-extensions
    cysignals
  ];

  pythonImportsCheck = [
    "passagemath_objects"
  ];
}
