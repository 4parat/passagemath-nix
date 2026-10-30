build pkg *args:
  #!/usr/bin/env bash
  OUTPUT="outputs/builds/$(date +%F_%H-%M)-{{ pkg }}"
  mkdir -p "$OUTPUT"
  nix build .#{{ pkg }} -L --keep-failed '.#{{ pkg }}' {{ args }} 2>&1 | tee "$OUTPUT/log"

link pkg:
  #!/usr/bin/env bash
  OUTPUT="outputs/links"
  mkdir -p $OUTPUT
  echo "$OUTPUT/{{ pkg }}"
  nix build .#{{ pkg }} -o "$OUTPUT/{{ pkg }}"

graph pkg:
  # nix-tree --dot {{ pkg }} 2>/dev/null | ./.scripts/restrained_transitive_closure.py | dot -Tsvg -o viz.svg
  nix-tree --dot --derivation {{ pkg }} 2>/dev/null | ./.scripts/restrained_transitive_closure.py

mkPkg pkg:
  mkdir './lib/{{ pkg }}' -p
  cp .scripts/pkg-template.nix './lib/{{ pkg }}/default.nix' --update=none

[script("nix", "develop", ".#fflas-ffpack", "--command", "bash")]
test-custom-file module:
  #!/usr/bin/env bash
  OUTPUT="tests/$(date +%F_%H-%M)"
  mkdir -p "$OUTPUT"
  python -m unittest tests.{{ module }}
  

test-passage:
  #!/usr/bin/env bash
  OUTPUT="outputs/tests/$(date +%F_%H-%M)"
  mkdir -p "$OUTPUT"
  sage -t --all | tee "$OUTPUT"/out.txt

[script("nix", "develop", ".#test314", "--command", "bash")]
test-passage-file file:
  #!/usr/bin/env bash
  OUTPUT="tests/$(date +%F_%H-%M)"
  mkdir -p "$OUTPUT"
  nix build .#testDerivation
  sage -t $(find -L result -type d -name site-packages -print -quit)

# test-failing:
#   nix build .#testDerivation
#   sage -t result/lib/python3.14/site-packages/sage/rings/lazy_series_ring.py 
#   sage -t result/lib/python3.14/site-packages/sage/rings/number_field/number_field.py 
#   sage -t result/lib/python3.14/site-packages/sage/graphs/generic_graph.py 
#   sage -t result/lib/python3.14/site-packages/sage/combinat/symmetric_group_algebra.py 
#   sage -t result/lib/python3.14/site-packages/sage/combinat/posets/posets.py 
#   sage -t result/lib/python3.14/site-packages/sage/rings/function_field/function_field_polymod.py 
#   sage -t result/lib/python3.14/site-packages/sage/interfaces/maxima_abstract.py 
#   sage -t result/lib/python3.14/site-packages/sage/interfaces/gap.py 
#   sage -t result/lib/python3.14/site-packages/sage/rings/asymptotic/asymptotic_ring.py 
#   sage -t result/lib/python3.14/site-packages/sage/categories/finite_dimensional_algebras_with_basis.py 
#   sage -t result/lib/python3.14/site-packages/sage/tests/cmdline.py 
#   sage -t result/lib/python3.14/site-packages/sage/rings/asymptotic/growth_group.py 
#   sage -t result/lib/python3.14/site-packages/sage/algebras/cellular_basis.py 
#   sage -t result/lib/python3.14/site-packages/sage/categories/primer.py 
#   sage -t result/lib/python3.14/site-packages/sage/interfaces/sage0.py 
#   sage -t result/lib/python3.14/site-packages/sage/tests/lazy_imports.py 
#   sage -t result/lib/python3.14/site-packages/sage/misc/sageinspect.py 
#   sage -t result/lib/python3.14/site-packages/sage/interfaces/singular.py 
#   sage -t result/lib/python3.14/site-packages/sage/categories/crystals.py 
#   sage -t result/lib/python3.14/site-packages/sage/misc/persist.pyx 
#   sage -t result/lib/python3.14/site-packages/sage/graphs/graph_latex.py 
#   sage -t result/lib/python3.14/site-packages/sage/interfaces/tests.py 
#   sage -t result/lib/python3.14/site-packages/sage/sets/set_from_iterator.py 
#   sage -t result/lib/python3.14/site-packages/sage/lfunctions/pari.py 
#   sage -t result/lib/python3.14/site-packages/sage/misc/dev_tools.py 
#   sage -t result/lib/python3.14/site-packages/sage/misc/inline_fortran.py 
#   sage -t result/lib/python3.14/site-packages/sage/rings/tate_algebra_ideal.pyx 
#   sage -t result/lib/python3.14/site-packages/sage/misc/latex_standalone.py 
#   sage -t result/lib/python3.14/site-packages/sage/structure/dynamic_class.py 
#   sage -t result/lib/python3.14/site-packages/sage/misc/lazy_import.pyx 
#   sage -t result/lib/python3.14/site-packages/sage/features/pkg_systems.py 
