#!/usr/bin/env python3
import networkx as nx
import sys
import re
import spkgs


G = nx.DiGraph(nx.nx_pydot.read_dot(sys.stdin))
selected = {
    node for node in G.nodes
    if node in spkgs.ALL_PACKAGES
}


# Fermeture transitive restreinted
H = nx.transitive_closure(G).subgraph(selected).copy()

# Éviter les boucles réflexives
H.remove_edges_from(nx.selfloop_edges(H))

nx.nx_pydot.write_dot(H, sys.stdout)

