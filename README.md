# passagemath-nix

Package definitions for [passagemath](https://github.com/passagemath/passagemath), a modularized fork of the [SageMath](https://github.com/sagemath/sage)

This repo does not contain every packages of passagemath, only the packages required to build up to `passagemath-standard`.

## Quick start

### With Flakes

To use the package from another flake, add this input and include
`passagemath-nix.packages.<system>.default` in a Python environment:

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
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.mkShell {
        packages = [
          (pkgs.python313.withPackages (pypkgs: [
            passagemath-nix.packages.x86_64-linux.default
            pypkgs.requests
          ]))
        ];
      };
  };
}
```

Then run `nix develop` in that project and start Sage with `sage`.

### Without Flakes (legacy Nix)

Use `nix-shell` with the repository's GitHub source to create an environment
without cloning it first:

```nix
# shell.nix
let
  pkgs = import <nixpkgs> {};
  src = pkgs.fetchFromGitHub {
    owner = "4parat";
    repo = "passagemath-nix";
    rev = "main";
    hash = "CHANGE_ME";
  };
  overlayPkgs = import (src + "/default.nix") { inherit pkgs; };
in overlayPkgs.mkShell {
  packages = [
    (overlayPkgs.python3.withPackages (ps: [ ps.passagemath-standard ]))
  ];
}'
```
Then `nix-shell`
Once the shell has loaded, use `sage` or run `sage -c "print(2 + 2)"`.

## Implementation choices

I made the decision to build the packages **using native ABI wheels**, which is not the [nixpkgs](https://github.com/NixOS/nixpkgs) way to build Python packages, but it's faster to build since it does not require costly compilation.

## Platforms

Currently only on `x86_64-linux` with Python3.13 and Python3.14.
Other platforms will most likely not be implemented unless it's done on `nixpkgs` from source.

## Downgrades

As of now, some packages inside nixpkgs are too recent for some passagemath packages, so they have been downgraded inside an overlay.
passagemath packages are also built inside this overlay.

## Unit test

Not all unit tests are passing, but the only failing test I inspected was probably due to a bug inside the unit test.

