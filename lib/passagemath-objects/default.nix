{
  lib,
  stdenv,
  python3,
  python3Packages,
  fetchPypi,
  autoPatchelfHook,
  ...
}:

let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python3.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = ""; # TODO
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

python3Packages.buildPythonPackage {
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
    python3Packages.gmpy2
    python3Packages.typing-extensions
    python3Packages.cysignals
  ];

  pythonImportsCheck = [
    "passagemath_objects"
  ];
}

