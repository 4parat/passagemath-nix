{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  libz,
  cysignals,
  memory-allocator,
  passagemath-categories,
  passagemath-iml,
  passagemath-m4ri-m4rie,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-linbox";
  version = "10.8.13";

  pyproject = true;
  build-system = [ setuptools cython pkgconfig passagemath-setup passagemath-environment ];
  buildInputs = with pkgs; [ givaro gmp linbox libmpc mpfr ];
  dependencies = [
    cysignals
    memory-allocator
    passagemath-environment
    passagemath-categories
    passagemath-iml
    passagemath-m4ri-m4rie
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_linbox";
    inherit version;
    hash = "sha256-Ri1r+dkUePtbLwWHqT5qLRA1MqIujAwS+ISNErU2dMo=";
  };
}
