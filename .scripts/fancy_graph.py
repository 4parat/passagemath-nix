#!/usr/bin/env python3
import sys
import shutil
import warnings
import webbrowser
from pathlib import Path

import networkx as nx
from sage.all import DiGraph
from sage.graphs.graph_plot_js import gen_html_code

# Masquer les warnings pydot
from pyparsing import PyparsingDeprecationWarning
warnings.filterwarnings("ignore", category=PyparsingDeprecationWarning)

# Lire le DOT
G = DiGraph(nx.nx_pydot.read_dot(sys.stdin))
print(G, file=sys.stderr)

# Générer le HTML avec Sage
tmp_html = gen_html_code(
    G,
    # edge_labels=False,
    # vertex_labels=False,
    # vertex_size=2,
    # edge_thickness=0.4,
    charge=-0.05,
    link_distance=800,
    link_strength=1,
    # gravity=0.005,
)

# Copier vers un emplacement persistant
output = Path.cwd() / "graph.html"
shutil.copyfile(tmp_html, output)

print(f"Visualisation : {output}", file=sys.stderr)

# Ouvrir dans le navigateur
webbrowser.open(output.as_uri())
