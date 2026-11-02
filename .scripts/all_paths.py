#!/usr/bin/env python
import networkx as nx
import sys
import spkgs

name = sys.argv[1]
G = nx.DiGraph(nx.nx_pydot.read_dot(sys.stdin))

for package in spkgs.ALL_PACKAGES:
    if package in G and nx.has_path(G, name, package):
        print(package)

