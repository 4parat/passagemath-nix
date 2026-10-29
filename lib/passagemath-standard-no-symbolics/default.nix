{
  lib,
  stdenv,
  python,
  fetchPypi,
  autoPatchelfHook,
  buildPythonPackage,

  passagemath-tachyon,
  cysignals,
  cython,
  gmpy2,
  jupyter-core,
  lrcalc,
  memory-allocator,
  numpy,
  pkgconfig,
  passagemath-ppl,
  passagemath-primesieve-primecount,
  requests,
  ipython,
  pexpect,
  sphinx,
  networkx,
  scipy,
  matplotlib,
  pillow,
  ipykernel,
  jupyter-client,
  ipywidgets,
  fpylll,
  passagemath-brial,
  passagemath-cddlib,
  passagemath-cliquer,
  passagemath-combinat,
  passagemath-eclib,
  passagemath-gap-pkg-transgrp-data,
  passagemath-gap-pkg-ctbllib-data,
  passagemath-gap-pkg-tomlib-data,
  passagemath-gap-pkg-irredsol-data,
  passagemath-glpk,
  passagemath-graphs,
  passagemath-groups,
  passagemath-highs,
  passagemath-homfly,
  passagemath-lcalc,
  passagemath-libbraiding,
  passagemath-libecm,
  passagemath-linbox,
  passagemath-modules,
  passagemath-nauty,
  passagemath-ntl,
  passagemath-palp,
  passagemath-pari,
  passagemath-pari-galdata,
  passagemath-pari-seadata-small,
  passagemath-planarity,
  passagemath-plot,
  passagemath-polyhedra,
  passagemath-repl,
  passagemath-schemes,
  passagemath-singular,
  ...
}@pkgs:

let
  version = "10.8.13";
  pythonTag = "cp${lib.replaceStrings [ "." ] [ "" ] python.pythonVersion}";
  wheels = {
    x86_64-linux = {
      cp313 = {
        platform = "manylinux1_x86_64.manylinux_2_28_x86_64.manylinux_2_5_x86_64";
        abi = "cp313";
        hash = ""; # TODO
      };

      cp314 = {
        platform = "manylinux1_x86_64.manylinux_2_28_x86_64.manylinux_2_5_x86_64";
        abi = "cp314";
        hash = "sha256-I4jwREONgyaEwa8S/U3mOPuctrP7wqGUDCnquobJV/I=";
      };
    };
  };
  wheel =
    wheels.${stdenv.hostPlatform.system}.${pythonTag}
      or (throw "passagemath-standard-no-symbolics: unsupported wheel");
in
  buildPythonPackage {
    pname = "passagemath-standard-no-symbolics";
    inherit version;

    format = "wheel";

    src = fetchPypi {
      pname = "passagemath_standard_no_symbolics";
      inherit version;
      format = "wheel";

      dist = pythonTag;
      python = pythonTag;
      inherit (wheel) abi platform hash;
    };

    nativeBuildInputs = [ autoPatchelfHook ];
    pythonRelaxDeps = [ "sphinx" ];
    # Remove bytecode that collides with the same source files from passagemath-environment.
    postInstall = ''
      find "$out" -type d -name __pycache__ -prune -exec rm -rf {} +
    '';
    dependencies = [
      lrcalc
      passagemath-brial
      passagemath-cddlib
      passagemath-cliquer
      passagemath-combinat
      passagemath-eclib
      passagemath-gap-pkg-transgrp-data
      passagemath-gap-pkg-ctbllib-data
      passagemath-gap-pkg-tomlib-data
      passagemath-gap-pkg-irredsol-data
      passagemath-glpk
      passagemath-graphs
      passagemath-groups
      passagemath-highs
      passagemath-homfly
      passagemath-lcalc
      passagemath-libbraiding
      passagemath-libecm
      passagemath-linbox
      passagemath-modules
      passagemath-nauty
      passagemath-ntl
      passagemath-palp
      passagemath-pari
      passagemath-pari-galdata
      passagemath-pari-seadata-small
      passagemath-planarity
      passagemath-plot
      passagemath-polyhedra
      passagemath-repl
      passagemath-schemes
      passagemath-singular
      passagemath-tachyon
      cysignals
      cython
      gmpy2
      jupyter-core
      memory-allocator
      numpy
      pkgconfig
      passagemath-ppl
      passagemath-primesieve-primecount
      requests
      ipython
      pexpect
      sphinx
      networkx
      scipy
      matplotlib
      pillow
      ipykernel
      jupyter-client
      ipywidgets
      fpylll
    ];
  }

