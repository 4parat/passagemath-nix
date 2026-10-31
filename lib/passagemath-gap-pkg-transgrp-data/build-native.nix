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
  pname = "passagemath-gap-pkg-transgrp-data";
  version = "10.8.13";

  pyproject = true;
  build-system = [
    setuptools
    passagemath-setup
  ];

  dependencies = [
    passagemath-environment
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  # The sdist contains metadata only; upstream adds GAP data when repairing wheels.
  postInstall = ''
    mkdir -p "$out/${python.sitePackages}/gap/pkg"
    ln -s ${pkgs.gap}/share/gap/pkg/transgrp "$out/${python.sitePackages}/gap/pkg/transgrp"
  '';

  src = fetchPypi {
    pname = "passagemath_gap_pkg_transgrp_data";
    inherit version;
    hash = "sha256-6cfXruCpHjmV/PgNQQVr/HloYVT5kkWoTebAJ5Jj5sU=";
  };
}
