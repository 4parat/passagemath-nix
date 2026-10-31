# passagemath-nix

Package definitions for [passagemath](https://github.com/passagemath/passagemath), a modularized fork of the [SageMath](https://github.com/sagemath/sage)

This repo does not contain every packages of passagemath, only the packages required to build up to `passagemath-standard`.

## Quick start

### With Flakes

You can use the provided overlays (`wheel` or `native`) :
```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    passagemath-nix.url = "github:4parat/passagemath-nix";
    passagemath-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, passagemath-nix, ... }: {
    devShells.x86_64-linux.default =
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [ passagemath-nix.overlays.wheel ] };
      in
      pkgs.mkShell {
        packages = [
          (pkgs.python3.withPackages (ps: [
            ps.passagemath-standard
            ps.pwntools
            ps.ipython
            ps.jupyter
            ps.requests
          ]))
        ];
      };
  };
}
```

Then run `nix develop` in that project and start Sage with `sage`.
Alternatively, you can grab packages from `passagemath.packages.<system>` (built via wheel).

### Without Flakes (legacy Nix)

Use `nix-shell` with the repository's GitHub source to create an environment
without cloning it first:

```nix
# shell.nix
let
  flake = builtins.getFlake "github:4parat/passagemath-nix";
  pkgs = import <nixpkgs> {
    overlays = [ ((import "${flake}/overlay.nix") { useWheel = true; }) ];
  };
in
pkgs.mkShell {
  packages = [
    (pkgs.python314.withPackages (ps: [
      ps.passagemath-standard
      ps.pwntools
      ps.ipython
      ps.jupyter
    ]))
  ];
}
```
Then `nix-shell`
Once the shell has loaded, use `sage` or run `sage -c "print(2 + 2)"`.

## Platforms

### Wheel

Currently only on `x86_64-linux` with Python3.13 and Python3.14 for wheels.
I recommand to use the wheel overlay since modules are long to build.
Overlay at `passagemath-nix.overlays.wheel`.

### Native

Native build is tested on `x86_64-linux`.
It *could* work on `aarch64-linux`, `x86_64-darwin`, `aarch64-darwin`, but It has not been tested.
Overlay at `passagemath-nix.overlays.native`.

## Downgrades

As of now, some packages inside nixpkgs are too recent for some passagemath packages, so they have been downgraded inside an overlay.
passagemath packages are also built inside this overlay.

## Dependency profiles and validation

Individual packages propagate their required runtime dependencies. Python
packages needed only for compilation are kept in `build-system`.
`passagemath-modules` exposes its NumPy and FLINT extras explicitly in both
overlays:

```nix
pkgs.python313.withPackages (ps: [
  ps.passagemath-modules
] ++ ps.passagemath-modules.optional-dependencies.numpy
  ++ ps.passagemath-modules.optional-dependencies.flint)
```

`passagemath-standard` already includes these dependencies.

Run `just check-dependencies` to evaluate all packages for wheel/native builds
with Python 3.13 and 3.14 on `x86_64-linux`, then compare their Python dependency
closures and version constraints with the pinned source archives. Missing
archives are reported as unverified; the checker does not download them. To
require complete archive coverage, run the checker with `--require-all-sources`.
This check complements package builds and their runtime dependency checks.
Additional runtime dependencies are reported for review: for example, Cliquer
needs `cysignals` to import its Cython extension even though upstream omits that
requirement from its metadata.

## Unit test

Not all unit tests are passing, but the only failing test I inspected was probably due to a bug inside the unit test.
TODO : Test unit tests failure against known unit tests failures in `passagemath/pkgs/*/known-test-failures.json`

## Other infos

- `%%cython` magic cells works half the time. Needs further investigation.
- Feel free to fork or implement into [nixpkgs](https://github.com/NixOS/nixpkgs), I will update this `README` if I decide to merge it on `nixpkgs` someday.

