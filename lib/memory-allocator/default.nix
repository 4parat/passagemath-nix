{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  ...
}:
buildPythonPackage rec {
  name = "memory-allocator";
  version = "0.1.4";
  pyproject = true;
  build-system = [ setuptools cython ];

  src = fetchPypi {
    pname = "memory_allocator";
    inherit version;
    hash = "sha256-1gkhawMDGWfitFqASxL/kClXj07AGf3kLPau1soJ7+Q=";
  };
}

