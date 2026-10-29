graph pkg:
  nix-tree --dot {{ pkg }} 2>/dev/null | ./.scripts/restrained_transitive_closure.py | dot -Tsvg -o viz.svg
  # nix-tree --dot {{ pkg }} 2>/dev/null | ./.scripts/restrained_transitive_closure.py

mkPkg pkg:
  mkdir './lib/{{ pkg }}' -p
  cp .scripts/pkg-template.nix './lib/{{ pkg }}/default.nix' --update=none
