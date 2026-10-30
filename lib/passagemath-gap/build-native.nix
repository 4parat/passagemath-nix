{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  libz,
  cysignals,
  dot2tex,
  memory-allocator,
  pexpect,
  passagemath-categories,
  passagemath-gap-pkg-factint-data,
  passagemath-gap-pkg-primgrp-data,
  passagemath-gap-pkg-smallgrp-data,
  passagemath-modules,
  passagemath-repl,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-gap";
  version = "10.8.13";

  pyproject = true;
  build-system = [ setuptools cython pkgconfig passagemath-setup passagemath-environment ];
  buildInputs = with pkgs; [gmp mpfr gap libmpc];
  dependencies = with pkgs; [
    cysignals
    dot2tex
    memory-allocator
    pexpect
    passagemath-modules
    passagemath-environment
    passagemath-categories
    passagemath-gap-pkg-factint-data
    passagemath-gap-pkg-primgrp-data
    passagemath-gap-pkg-smallgrp-data
    passagemath-repl
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_gap";
    inherit version;
    hash = "sha256-V65670IxOhm/If+vV+95GqUPpNxQOzkBoE2plVlC7bo=";
  };
}
