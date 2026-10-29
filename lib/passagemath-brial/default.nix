{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  libz,
  cysignals,
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
        hash = "sha256-W4OTRE1o51sPI5JO16lnNVnc6/iwAXxM8hf7lNU6blw=";
      };
      cp314 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-MuBWv8wG4Arip8C0jZEUr9pFzrMGDuo4olR7dH0GX1Q=";
      };
    };
  };
  wheel = wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "passagemath-brial: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-brial";
  inherit version;
  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_brial";
    inherit version;
    format = "wheel";
    dist = pythonTag;
    python = pythonTag;
    inherit (wheel) abi platform hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ libz];
  dependencies = [ cysignals passagemath-categories ];
}

