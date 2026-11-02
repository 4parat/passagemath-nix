#!/usr/bin/env python3
import sys
import networkx as nx
import re

version_rgx = r'\d\?)+'

def strip_pkg(pkg):
    return re.match(r'(?:python3.\d\d-)?(.*?)-(?:\d|\.)*(?:\.tar\.gz)?\.drv', pkg).group(1)


G = nx.DiGraph(nx.nx_pydot.read_dot(sys.stdin))
gens = list(nx.topological_generations(G))
    

for i, gen in enumerate(reversed(gens)):
    print(f'# Stage {i}')
    for pkg in gen:
        print(f'- [ ] {strip_pkg(pkg)}')
    print()


