{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  passagemath-setup,
  pkgs,
  passagemath-environment,
  memory-allocator,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-categories";
  version = "10.8.13";

  pyproject = true;

  build-system = [
    setuptools
    cython
    passagemath-setup
    passagemath-environment
  ];

  buildInputs = with pkgs; [
    gmp
    libmpc
    mpfr
  ];

  dependencies = with pkgs.python3Packages; [
    jinja2
    memory-allocator
    passagemath-objects
    typing-extensions
  ];
  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_categories";
    inherit version;
    hash = "sha256-8Ni+F4oE2EkgcQIxMIkU5uPZrv4lnPz4wU24qXidPlc=";
  };
}
