{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,
  
  libz,
  cysignals,
  gmpy2,
  memory-allocator,
  numpy,
  scipy,
  pillow,
  matplotlib,
  jupyter-threejs-sage,
  passagemath-categories,
  passagemath-modules,
  ...
}:

let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp313";
        hash = "sha256-MJ+t4J8hd3s/hmB4KW+JIoy/oxqeDcLw3lAKHQxJ+tI=";
      };
      cp314 = {
        platform = "manylinux_2_27_x86_64.manylinux_2_28_x86_64";
        abi = "cp314";
        hash = "sha256-YKuFJVGh0eUTBkWzH4spg8ZwUzgGffT8UYSGjvCQR6E=";
      };
    };
  };
  wheel = wheels.${stdenv.hostPlatform.system}.${pythonTag} or (throw "passagemath-plot: unsupported wheel");
in
buildPythonPackage {
  pname = "passagemath-plot";
  inherit version;
  format = "wheel";
  src = fetchPypi {
    pname = "passagemath_plot";
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
    gmpy2
    memory-allocator
    numpy
    scipy
    pillow
    matplotlib
    jupyter-threejs-sage
    passagemath-categories
    passagemath-modules
  ];
}

