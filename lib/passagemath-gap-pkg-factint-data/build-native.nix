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
  pname = "passagemath-gap-pkg-factint-data";
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
    ln -s ${pkgs.gap}/share/gap/pkg/factint "$out/${python.sitePackages}/gap/pkg/factint"
  '';

  src = fetchPypi {
    pname = "passagemath_gap_pkg_factint_data";
    inherit version;
    hash = "sha256-AB8mjI1d8DfbiD9wSLM5tLHD402it+pPfOcxE5j7Ysc=";
  };
}
