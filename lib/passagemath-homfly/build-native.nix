{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  cysignals,
  passagemath-objects,
  typing-extensions,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-homfly";
  version = "10.8.13";

  pyproject = true;
  build-system = [ setuptools cython pkgconfig passagemath-setup passagemath-environment ];
  buildInputs = with pkgs; [
    libhomfly
    boehmgc
  ];
  dependencies = [
    cysignals
    passagemath-objects
    typing-extensions
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_homfly";
    inherit version;
    hash = "sha256-fvrkxYRmVbDbCNBnaxy+yMw+bQ50sPZuWq4GdNN4Gks=";
  };
}
