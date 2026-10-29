{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  libz,

  cysignals,
  memory-allocator,
  passagemath-environment,
  passagemath-categories,
  conway-polynomials,
  ...
}:

let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-BNZOsZzJdskcO3nuKdNNGsWy+Z6ykz5pyoPSCKukdYc=";
      };

      cp314 = {
        platform = "manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-bc4uMckle42L+OafkFGTZUZP57DeMMuosTtOBAEnDHo=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-pari: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-pari";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_pari";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [ autoPatchelfHook ];
    buildInputs = [ libz ];
    dependencies = [
      cysignals
      memory-allocator
      passagemath-environment
      passagemath-categories
      conway-polynomials
    ];
  }


