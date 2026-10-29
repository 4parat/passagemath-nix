{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,

  libz,
  cysignals,
  dot2tex,
  memory-allocator,
  pexpect,
  passagemath-environment,
  passagemath-categories,
  passagemath-gap-pkg-factint-data,
  passagemath-gap-pkg-primgrp-data,
  passagemath-gap-pkg-smallgrp-data,
  passagemath-repl,
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
        hash = "sha256-wYxDJYWyUtJYDVXg56LETIdLbkWb09ODIuGwT+jADw4=";
      };

      cp314 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-TRdX+08WOPg4mP7OJ1iBWeOtIAMSNnF+1CSpwrDuGxo=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-gap: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-gap";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_gap";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [ autoPatchelfHook ];

    buildInputs = [
      libz
    ];

    dependencies = [
      cysignals
      dot2tex
      memory-allocator
      pexpect
      passagemath-environment
      passagemath-categories
      passagemath-gap-pkg-factint-data
      passagemath-gap-pkg-primgrp-data
      passagemath-gap-pkg-smallgrp-data
      passagemath-repl
    ];
  }

