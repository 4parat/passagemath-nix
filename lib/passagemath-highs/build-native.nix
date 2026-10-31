{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  memory-allocator,
  cysignals,
  passagemath-objects,
  passagemath-categories,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-highs";
  version = "10.8.13";

  pyproject = true;
  build-system = [ setuptools cython pkgconfig passagemath-setup passagemath-environment ];
  buildInputs = with pkgs; [
    highs
    libz
  ];
  dependencies = [
    memory-allocator
    cysignals
    passagemath-objects
    passagemath-categories
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_highs";
    inherit version;
    hash = "sha256-qhRPvx7g2q+w7KwKqL2Y2GhCHqOtgV2fj3qWHBpp3h8=";
  };
}
