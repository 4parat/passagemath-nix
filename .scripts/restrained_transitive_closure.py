#!/usr/bin/env python3
import networkx as nx
import sys
import pydot
import re
import spkgs




G = nx.DiGraph(nx.nx_agraph.read_dot(sys.stdin))
# G = nx.DiGraph(nx.nx_pydot.from_pydot(graphs[0]))
selected = set(G.nodes) & set(spkgs.ALL_PACKAGES)

H = nx.DiGraph()
H.add_nodes_from(selected)

for source in selected:
    targets = nx.descendants(G, source) & selected
    H.add_edges_from(
        (source, target)
        for target in targets
        if source != target
    )

nx.nx_pydot.write_dot(H, sys.stdout)


