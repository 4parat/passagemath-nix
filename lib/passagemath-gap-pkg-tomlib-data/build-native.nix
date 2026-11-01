{
  pkgs,
  python,
  buildPythonPackage,
  fetchPypi,
  passagemath-setup,
  setuptools,
  passagemath-environment,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-gap-pkg-tomlib-data";
  version = "10.8.13";

  pyproject = true;
  build-system = [
    setuptools
    passagemath-setup
  ];

  dependencies = [
    passagemath-environment
  ];

  # The sdist contains metadata only; upstream adds GAP data when repairing wheels.
  postInstall = ''
    mkdir -p "$out/${python.sitePackages}/gap/pkg"
    ln -s ${pkgs.gap}/share/gap/pkg/tomlib "$out/${python.sitePackages}/gap/pkg/tomlib"
  '';

  src = fetchPypi {
    pname = "passagemath_gap_pkg_tomlib_data";
    inherit version;
    hash = "sha256-c927q/6dCkK44DAp9v1xS5Sj0MD5fkYhtau51o/qNE0=";
  };
}
