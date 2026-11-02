#!/usr/bin/env python3
import sys
import networkx as nx

G = nx.DiGraph(nx.nx_pydot.read_dot(sys.stdin))
H = G.reverse()
nx.nx_pydot.write_dot(H, sys.stdout)

