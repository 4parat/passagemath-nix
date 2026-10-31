{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  passagemath-objects,
  passagemath-categories,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-cliquer";
  version = "10.8.13";

  pyproject = true;
  build-system = [ setuptools cython pkgconfig passagemath-setup passagemath-environment ];
  buildInputs = with pkgs; [
    cliquer
  ];
  dependencies = [
    passagemath-objects
    passagemath-categories
    # No additional runtime dependencies.
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_cliquer";
    inherit version;
    hash = "sha256-VO/KTJVxsqA4XQqABKeYW4hV99lbYxSxfS55KgeZccw=";
  };
}
