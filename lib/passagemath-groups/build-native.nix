{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  passagemath-categories,
  passagemath-gap,
  passagemath-modules,
  passagemath-flint,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-groups";
  version = "10.8.13";

  pyproject = true;
  build-system = [ setuptools cython pkgconfig passagemath-setup passagemath-environment ];
  buildInputs = with pkgs; [
    flint
    gap
    gmp
  ];
  dependencies = [
    passagemath-flint
    passagemath-categories
    passagemath-gap
    passagemath-modules
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_groups";
    inherit version;
    hash = "sha256-69dE3LSzdRyHbTZ9uM7cRP6RMErT+D7/62xCOcjlXys=";
  };
}
