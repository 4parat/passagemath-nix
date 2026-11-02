#!/usr/bin/env python3
import sys
import networkx as nx
import spkgs

G = nx.DiGraph(nx.nx_pydot.read_dot(sys.stdin))
H = nx.relabel_nodes(G, spkgs.get_name_or_raw)
nx.nx_pydot.write_dot(H, sys.stdout)

