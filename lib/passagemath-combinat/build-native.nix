{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  gmpy2,
  cysignals,
  memory-allocator,
  passagemath-categories,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-combinat";
  version = "10.8.13";

  pyproject = true;
  build-system = [ setuptools cython pkgconfig passagemath-setup passagemath-environment ];
  buildInputs = with pkgs; [
    gmp
    symmetrica
    # No external libraries required.
  ];
  dependencies = [
    gmpy2
    cysignals
    memory-allocator
    passagemath-categories
    passagemath-environment
  ];

  src = fetchPypi {
    pname = "passagemath_combinat";
    inherit version;
    hash = "sha256-NL041IFFaWhfnXd47xHGwULzXJx1Il1WMCZAc6qqDFE=";
  };
}
