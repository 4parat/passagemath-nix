{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  passagemath-setup,
  pkgs,
  passagemath-environment,
  memory-allocator,
  passagemath-objects,
  jinja2,
  gmpy2,
  cysignals,
  pkgconfig,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-categories";
  version = "10.8.13";

  pyproject = true;

  build-system = [
    setuptools
    passagemath-setup
    jinja2
    passagemath-environment
    cython
    gmpy2
    cysignals
    pkgconfig
  ];

  buildInputs = with pkgs; [
    gmp
    libmpc
    mpfr
  ];

  dependencies = [
    passagemath-objects
    memory-allocator
  ];
  src = fetchPypi {
    pname = "passagemath_categories";
    inherit version;
    hash = "sha256-8Ni+F4oE2EkgcQIxMIkU5uPZrv4lnPz4wU24qXidPlc=";
  };
}
