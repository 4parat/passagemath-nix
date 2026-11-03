{
  buildPythonPackage,
  cysignals,
  cython,
  fetchPypi,
  gmp,
  gmpy2,
  jinja2,
  libmpc,
  memory-allocator,
  mpfr,
  passagemath-environment,
  passagemath-objects,
  passagemath-setup,
  pkgconfig,
  pkgs,
  setuptools,
  typing-extensions,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-categories";
  version = "10.8.13";

  pyproject = true;

  # BUILDSYSTEM CHECKED
  build-system = [
    setuptools
    passagemath-setup
    jinja2
    cython
    pkgconfig
  ];

  # CHECKED
  buildInputs = [
    gmp
    libmpc
    mpfr
  ];

  # CHECKED
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
