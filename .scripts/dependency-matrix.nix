# From the repository root:
# nix eval --impure --json .#pkgs.x86_64-linux --apply 'import ./.scripts/dependency-matrix.nix'
sets:
let
  names = builtins.attrNames (builtins.readDir ../lib);
  describe = p: {
    name = p.pname or p.name;
    version = p.version or null;
    path = p.outPath;
    python = p.pythonModule.pythonVersion or null;
  };
  inspect =
    ps: name:
    let
      p = ps.${name};
    in
    {
      inherit name;
      package = describe p;
      src = p.src.outPath;
      drv = p.drvPath;
      dependencies = map describe (p.dependencies or [ ]);
      runtimeClosure = map describe (ps.requiredPythonModules (p.dependencies or [ ]));
      buildClosure = map describe (
        ps.requiredPythonModules ((p.build-system or [ ]) ++ (p.dependencies or [ ]))
      );
      buildSystem = map describe (p.build-system or [ ]);
      relax = p.pythonRelaxDeps or [ ];
      remove = p.pythonRemoveDeps or [ ];
      postPatch = p.postPatch or "";
    };
  variant = mode: py: {
    name = "${mode}-${py}";
    value = map (inspect sets.${mode}.${"python${py}Packages"}) names;
  };
in
builtins.listToAttrs (
  builtins.concatMap
    (
      mode:
      map (variant mode) [
        "313"
        "314"
      ]
    )
    [
      "wheel"
      "native"
    ]
)
