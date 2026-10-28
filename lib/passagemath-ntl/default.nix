{
  lib,
  stdenv,
  python3,
  python3Packages,
  fetchPypi,
  autoPatchelfHook,
  ...
}@pkgs:

let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python3.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = ""; # TODO
      };

      cp314 = {
        platform = "manylinux_2_24_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-dYVXv8LEja9tygtWX/CCaWakMna330pmkQ8yRPRveyo=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-ntl: unsupported wheel");
  memory-allocator = (import ../memory-allocator/default.nix) pkgs;
  passagemath-environment = (import ../passagemath-environment/default.nix) pkgs;
  passagemath-categories = (import ../passagemath-categories/default.nix) pkgs;
in
  python3Packages.buildPythonPackage {
    pname = "passagemath-ntl";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_ntl";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [ autoPatchelfHook ];
    dependencies = [
      memory-allocator
      python3Packages.cysignals
      passagemath-environment
      passagemath-categories
    ];
  }

