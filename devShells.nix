{
  pkgs,
  self',
  ...
}:
{
  default = self'.devShells.debug;
  debug = pkgs.mkShellNoCC {
    packages = [
      (pkgs.python3.withPackages (pypkgs: [
        pypkgs.ipython
        pypkgs.requests
        pypkgs.pydot
        pypkgs.networkx
        pypkgs.packaging
      ]))
      pkgs.hyperfine
      pkgs.perf
      pkgs.alejandra
      pkgs.nix-tree
      pkgs.graphviz
    ];
  };

  wheel =
    let
      pkgs' = self'.pkgs.wheel;
    in
    pkgs'.mkShellNoCC {
      packages = [
        (pkgs'.python3.withPackages (pypkgs: [
          pypkgs.passagemath-standard
          pypkgs.jupyter
          pypkgs.notebook
        ]))
        pkgs'.dot2tex
        pkgs'.gap
        pkgs'.graphviz
        pkgs'.meson
        pkgs'.pari
        pkgs'.singular
        pkgs'.texliveSmall
      ];
    };

  native =
    let
      pkgs' = self'.pkgs.native;
    in
    pkgs'.mkShell {
      packages = [
        (pkgs'.python3.withPackages (pypkgs: [
          pypkgs.passagemath-standard
          pypkgs.ipython
          pypkgs.jupyter
          pypkgs.notebook
          pypkgs.cython
        ]))
        pkgs'.singular
        pkgs'.gdb
        pkgs'.gap
      ];
    };

  /*
       fflas-ffpack = pkgs.mkShellNoCC {
      packages = [
        (pkgs.python314.withPackages (pypkgs: [
          self'.packages.passagemath-standard
          pypkgs.jupyter

          pypkgs.distutils
        ]))
        pkgs.gdb
      ];

      nativeBuildInputs = [
        pkgs.pkg-config
      ];

      buildInputs = [
        pkgs.fflas-ffpack
        pkgs.givaro
        pkgs.flint
        pkgs.gsl
        pkgs.linbox
        pkgs.singular
        pkgs.libpng
        pkgs.gd
        pkgs.m4ri
        pkgs.openblas
        pkgs.ecl
        pkgs.pari
        pkgs.eclib
        pkgs.ntl
        pkgs.gcc
      ];

      shellHook = ''
        export PKG_CONFIG_PATH="${pkgs.fflas-ffpack}/lib/pkgconfig''${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
      '';
    };
  */
}
