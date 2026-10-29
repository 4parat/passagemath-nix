# passagemath-nix

Various nix builders for standard packages of [passagemath](https://github.com/passagemath/passagemath), a modularized fork of the [SageMath](https://github.com/sagemath/sage)

This repo does not contain every packages of passagemath, only the packages required to build up to `passagemath-standard`.

## Implementation choices

I made the decision to build the packages **using native ABI wheels**, which is not the [nixpkgs](https://github.com/NixOS/nixpkgs) way to build Python packages, but it's faster to build since it does not require costly compilation.

## Platforms

Currently only on `x86_64-linux` with Python3.13 and Python3.14.

## Downgrades

As of now, some packages inside nixpkgs are too recent for some passagemath packages, so they have been downgraded inside an overlay.
passagemath packages are also built inside this overlay.

## Unit test

Not all unit tests are passing, but the only failing test I inspected was most probably due to a bug inside the unit test (on lazy_rings module).

## Generative AI usage

- For fetching hashes and platforms strings from Pypi mainly.

