#!/usr/bin/env python3
import sys
import networkx as nx
import re
import sys

version_rgx = r'\d\?)+'


G = nx.DiGraph(nx.nx_pydot.read_dot(sys.stdin))
gens = list(nx.topological_generations(G))
    

for i, gen in enumerate(reversed(gens)):
    print(f'# Stage {i}')
    for pkg in gen:
        print(f'- [ ] {pkg}')
    print()


